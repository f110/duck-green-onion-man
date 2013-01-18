package Net::Google::Spreadsheets;
use Mouse;

has access_token => (
    is => 'ro',
    isa => 'Str',
    required => 1,
);
has request => (
    is => 'ro',
    isa => 'Net::Google::Spreadsheets::Request',
    lazy_build => 1,
);

__PACKAGE__->meta->make_immutable;

no Mouse;

use Furl;
use XML::XPath;
use List::MoreUtils qw();
use Data::Dumper;

use Net::Google::Spreadsheets::Request;
use Net::Google::Spreadsheets::Spreadsheet;
use Net::Google::Spreadsheets::Worksheet;
use Net::Google::Spreadsheets::Row;
use Net::Google::Spreadsheets::Cell;

my $END_POINT = 'https://spreadsheets.google.com/feeds';

sub update {
    my $self = shift;
    my $entry = shift;

    die unless $entry->does("Net::Google::Spreadsheets::Entry");

    my $response = $self->request->put(
        $entry->edit_url,
        [
            "Content-Type" => "application/atom+xml",
            "If-Match" => "*",
        ],
        $entry->to_string,
    );

    unless ($response->is_success) {
        die "could not update row: ".$response->body;
    }
}

sub add {
    my $self = shift;
    my $entry = shift;

    die unless $entry->does("Net::Google::Spreadsheets::Entry");

    my $response = $self->request->put(
        $entry->add_url,
        [
            "Content-Type" => "application/atom+xml",
            "IF-Match" => "*",
        ],
        $entry->to_string,
    );

    unless ($response->is_success) {
        die "could not update row: ".$response->body;
    }
}

sub get_list {
    my $self = shift;

    my @spreadsheet_list = $self->_get_nodes(
        "//entry",
        $self->request->get($END_POINT."/spreadsheets/private/full")->body,
    );

    my @spreadsheet_object;
    foreach my $node (@spreadsheet_list) {
        my $attributes = {};
        foreach my $child_node ($node->getChildNodes) {
            if ($child_node->getName eq "author") {
                foreach my $author_child_node (@{$child_node->getChildNodes}) {
                    $attributes->{"author_".$author_child_node->getName} =
                        $author_child_node->getChildNodes->[0]->getValue;
                }
            } else {
                my $value_child = $child_node->getChildNodes->[0] or next;
                $attributes->{$child_node->getName} = $value_child->getValue;
            }
        }

        $attributes->{id} = pop @{[ split "/", $attributes->{id} ]};

        push @spreadsheet_object, Net::Google::Spreadsheets::Spreadsheet->new(%$attributes);
    }

    return @spreadsheet_object;
}

sub get_worksheets {
    my $self = shift;
    my $spreadsheet = shift;
    my @NODE_NAME = qw(id title updated gs:rowCount gs:colCount);

    die unless ref $spreadsheet eq "Net::Google::Spreadsheets::Spreadsheet";

    my @worksheets = $self->_get_entry(
        sprintf("%s/worksheets/%s/private/full",
            $END_POINT,
            $spreadsheet->id
        ),
    );

    my @worksheets_objects;
    foreach my $worksheet (@worksheets) {
        my $attributes = $self->_build_attributes_hashref(
            $worksheet,
            \@NODE_NAME,
            +{
                'gs:rowCount' => 'row_count',
                'gs:colCount' => 'col_count',
            },
        );

        push @worksheets_objects, Net::Google::Spreadsheets::Worksheet->new(
            %$attributes,
            spreadsheet => $spreadsheet,
        );
    }

    return @worksheets_objects;
}

#sub get_rows {
    #my $self = shift;
    #my $worksheet = shift;
    #my @NODE_NAME = qw(id title content updated);

    #die unless ref $worksheet eq "Net::Google::Spreadsheets::Worksheet";

    #my @rows = $self->_get_entry(
        #sprintf("%s/list/%s/%s/private/full",
            #$END_POINT,
            #$worksheet->spreadsheet->id,
            #$worksheet->id,
        #),
    #);

    #my @row_objects;
    #foreach my $row (@rows) {
        #my $attributes = $self->_build_attributes_hashref(
            #$row,
            #\@NODE_NAME,
        #);
        #$attributes->{values} = {};
        #foreach my $child ($row->getChildNodes) {
            #my $value_node = $child->getChildNodes->[0] or next;
            #if ($child->getName =~ m/^gsx:(.+)/) {
                #$attributes->{values}->{$1} = $value_node->getValue;
            #}
        #}

        #push @row_objects, Net::Google::Spreadsheets::Row->new(
            #%$attributes,
            #worksheet => $worksheet
        #);
    #}

    #return @row_objects;
#}

#sub get_row {
    #my $self = shift;
    #my $row = shift;
    #my @NODE_NAME = qw(title content updated);

    #die unless ref $row eq "Net::Google::Spreadsheets::Row";

    #my @rows = $self->_get_entry(
        #sprintf("%s/list/%s/%s/private/full/%s",
            #$END_POINT,
            #$row->worksheet->spreadsheet->id,
            #$row->worksheet->id,
            #$row->id
        #),
    #);

    #foreach my $child ($rows[0]->getChildNodes) {
        #my $value_node = $child->getChildNodes->[0] or next;
        #if ($child->getName =~ m/^gsx:(.+)/) {
            #$row->values->{$1} = $value_node->getValue;
        #}

        #$row->{$child->getName} = $value_node->getValue
            #if List::MoreUtils::any {$_ eq $child->getName} @NODE_NAME;
    #}

    #return $row;
#}

sub get_cells {
    my $self = shift;
    my $worksheet = shift;
    my @NODE_NAME = qw(id title content updated);

    die unless ref $worksheet eq "Net::Google::Spreadsheets::Worksheet";

    my @cells = $self->_get_entry(
        sprintf("%s/cells/%s/%s/private/full",
            $END_POINT,
            $worksheet->spreadsheet->id,
            $worksheet->id,
        ),
    );

    my @cell_objects;
    foreach my $cell (@cells) {
        my $attributes = $self->_build_attributes_hashref(
            $cell,
            \@NODE_NAME,
            +{
                title => 'position',
                content => 'value',
            }
        );
        foreach my $child ($cell->getChildNodes) {
            if ($child->getName eq "gs:cell") {
                $attributes->{col} = $child->getAttribute("col");
                $attributes->{row} = $child->getAttribute("row");
            }
        }

        push @cell_objects, Net::Google::Spreadsheets::Cell->new(
            %$attributes,
            worksheet => $worksheet,
        );
    }

    return @cell_objects;
}

sub get_cell {
    my $self = shift;
    my $cell = shift;
    my @NODE_NAME = qw(title content updated);

    die unless ref $cell eq "Net::Google::Spreadsheets::Cell";

    my @cells = $self->_get_entry(
        sprintf("%s/cells/%s/%s/private/full/%s",
            $END_POINT,
            $cell->worksheet->spreadsheet->id,
            $cell->worksheet->id,
            $cell->id,
        )
    );

    my $attributes = $self->_build_attributes_hashref(
        $cells[0],
        \@NODE_NAME,
        +{
            title => 'position',
            content => 'value',
        }
    );
    foreach my $child ($cells[0]->getChildNodes) {
        if ($child->getName eq "gs:cell") {
            $attributes->{col} = $child->getAttribute("col");
            $attributes->{row} = $child->getAttribute("row");
        }
    }

    while (my ($key, $value) = each %$attributes) {
        $cell->$key($value);
    }

    return $cell;
}

sub _build_attributes_hashref {
    my $self = shift;
    my $entry = shift;
    my $extract_node_name = shift || [];
    my $convert_map = shift || {};

    my $attributes = {};
    foreach my $child ($entry->getChildNodes) {
        my $value_node = $child->getChildNodes->[0] or next;

        $attributes->{$child->getName} = $value_node->getValue
            if List::MoreUtils::any {$_ eq $child->getName} @$extract_node_name;
    }

    $attributes->{id} = pop @{[ split "/", $attributes->{id} ]} if exists $attributes->{id};

    foreach my $key (keys %$convert_map) {
        next unless exists $attributes->{$key};
        $attributes->{$convert_map->{$key}} = $attributes->{$key};
        delete $attributes->{$key};
    }

    return $attributes;
}

sub _get_nodes {
    my $self = shift;
    my $path = shift;
    my $content = shift;

    my $xml = XML::XPath->new(xml => $content);

    return $xml->findnodes($path)->get_nodelist;
}

sub _get_content {
    my $self = shift;
    my $method = lc(shift) || 'get';
    my $url = shift;

    my $content = $self->request->$method($url);
    die $content->message unless $content->code == 200;

    return $content;
}

sub _get_entry {
    my $self = shift;
    my $url = shift;
    my $content = $self->_get_content('GET', $url);

    return $self->_get_nodes(
        "//entry",
        $content->body,
    );
}

sub _build_request {
    my $self = shift;

    return Net::Google::Spreadsheets::Request->new(
        access_token => $self->access_token,
        token_type => "Bearer",
    );
}

1;
__END__
=pod

=encoding utf-8

=head1 NAME

Net::Google::Spreadsheets -

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHOD

=head1 AUTHOR

Fumihiro Itoh

=cut
