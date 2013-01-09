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

my $END_POINT = 'https://spreadsheets.google.com/feeds';

sub get_list {
    my $self = shift;

    my @spreadsheet_list = $self->_get_nodes(
        "//entry",
        $self->request->get($END_POINT."/spreadsheets/private/full")->body,
    );

    my @spreadsheet_object;
    foreach my $node (@spreadsheet_list) {
        my @child = $node->getChildNodes;

        my $attributes = {};
        foreach my $child_node (@child) {
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

    my @worksheets = $self->_get_nodes(
        "//entry",
        $self->request->get(
            sprintf("%s/worksheets/%s/private/full",
                $END_POINT,
                $spreadsheet->id
            )
        )->body,
    );

    my @worksheets_objects;
    foreach my $worksheet (@worksheets) {
        my $attributes = {};
        foreach my $child ($worksheet->getChildNodes) {
            my $value_node = $child->getChildNodes->[0] or next;

            $attributes->{$child->getName} = $value_node->getValue
                if List::MoreUtils::any {$_ eq $child->getName} @NODE_NAME;
        }

        $attributes->{'row_count'} = $attributes->{'gs:rowCount'};
        delete $attributes->{'gs:rowCount'};
        $attributes->{'col_count'} = $attributes->{'gs:colCount'};
        delete $attributes->{'gs:colCount'};
        $attributes->{id} = pop @{[ split "/", $attributes->{id} ]};
        $attributes->{spreadsheet} = $spreadsheet,

        push @worksheets_objects, Net::Google::Spreadsheets::Worksheet->new(%$attributes);
    }

    return @worksheets_objects;
}

sub get_rows {
    my $self = shift;
    my $worksheet = shift;
    my @NODE_NAME = qw(id title content);

    die unless ref $worksheet eq "Net::Google::Spreadsheets::Worksheet";

    my @rows = $self->_get_nodes(
        "//entry",
        $self->request->get(
            sprintf("%s/list/%s/%s/private/full",
                $END_POINT,
                $worksheet->spreadsheet->id,
                $worksheet->id,
            )
        )->body,
    );

    my @row_objects;
    foreach my $row (@rows) {
        my $attributes = {};
        foreach my $child ($row->getChildNodes) {
            my $value_node = $child->getChildNodes->[0] or next;

            $attributes->{$child->getName} = $value_node->getValue
                if List::MoreUtils::any {$_ eq $child->getName} @NODE_NAME;
        }

        $attributes->{id} = pop @{[ split "/", $attributes->{id} ]};
        $attributes->{worksheet} = $worksheet,

        push @row_objects, Net::Google::Spreadsheets::Row->new(%$attributes);
    }

    return @row_objects;
}

sub _get_nodes {
    my $self = shift;
    my $path = shift;
    my $content = shift;

    my $xml = XML::XPath->new(xml => $content);

    return $xml->findnodes($path)->get_nodelist;
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
