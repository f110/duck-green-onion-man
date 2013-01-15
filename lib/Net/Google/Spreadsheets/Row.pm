package Net::Google::Spreadsheets::Row;
use Mouse;

with 'Net::Google::Spreadsheets::Entry';

has title => (
    is => 'rw',
    isa => 'Str',
    default => "",
);
has content => (
    is => 'rw',
    isa => 'Str',
    default => "",
);
has values => (
    is => 'rw',
    isa => 'HashRef',
    default => sub { +{} },
);

__PACKAGE__->meta->make_immutable;
no Mouse;

use Encode;
use XML::XPath;

sub set_value {
    my $self = shift;
    my $key = shift;
    my $value = shift;

    my $xml = XML::XPath->new(xml => $self->xml_string);
    $xml->setNodeText(sprintf("//entry/gsx:%s", $key), $value);
    $self->values->{$key} = $value if exists $self->values->{$key};
    $self->xml_string(encode_utf8($xml->findnodes_as_string("//entry")));
}

sub add_url {
    my $self = shift;

    return sprintf(
        'https://spreadsheets.google.com/feeds/list/%s/%s/private/full',
        $self->worksheet->spreadsheet->id,
        $self->worksheet->id,
    );
}

sub edit_url {
    my $self = shift;
    my $xml = XML::XPath->new(xml => $self->xml_string);

    return $xml->findvalue('//entry/link[@rel="edit"]/@href')->value;
}

1;
__END__
=pod

=encoding utf-8

=head1 NAME

Net::Google::Spreadsheets::Row -

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHOD

=head1 AUTHOR

=cut
