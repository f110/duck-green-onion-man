package Net::Google::Spreadsheets::Entry;
use Mouse::Role;

has id => (
    is => 'ro',
    isa => 'Str',
    required => 1,
);
has worksheet => (
    is => 'ro',
    isa => 'Net::Google::Spreadsheets::Worksheet',
    required => 1,
);
has xml_string => (
    is => 'rw',
    isa => 'Str',
    default => "",
);
has edit_url => (
    is => 'ro',
    isa => 'Str',
    lazy_build => 1,
);
has etag => (
    is => 'ro',
    isa => 'Str',
    lazy_build => 1,
);

requires 'set_value';

no Mouse::Role;

sub _build_edit_url {
    my $self = shift;

    my $xml = XML::XPath->new(xml => $self->xml_string);

    return $xml->findvalue('//entry/link[@rel="edit"]/@href')->value;
}

sub _build_etag {
    my $self = shift;

    my $xml = XML::XPath->new(xml => $self->xml_string);
    return $xml->findvalue('//entry/@gd:etag')->value;
}

1;
__END__
=pod

=encoding utf-8

=head1 NAME

Net::Google::Spreadsheets::Entry -

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHOD

=head1 AUTHOR

=cut
