package Net::Google::Spreadsheets::Cell;
use Mouse;

with 'Net::Google::Spreadsheets::Entry';

has position => (
    is => 'rw',
    isa => 'Str',
    default => "",
);
has value => (
    is => 'rw',
    isa => 'Str',
    default => "",
);
has updated => (
    is => 'rw',
    isa => 'Str',
    default => "",
);
has col => (
    is => 'rw',
    isa => 'Int',
    default => 0,
);
has row => (
    is => 'rw',
    isa => 'Int',
    default => 0,
);

__PACKAGE__->meta->make_immutable;
no Mouse;

use XML::XPath;
use Encode;

sub set_value {
    my $self = shift;
    my $value = shift;

    my $xml = XML::XPath->new(xml => $self->xml_string);
    $xml->setNodeText(q{//entry/gs:cell/@inputValue}, $value);
    $self->xml_string(encode_utf8($xml->findnodes_as_string("//entry")));
    warn $self->xml_string;
}

1;
__END__
=pod

=encoding utf-8

=head1 NAME

Net::Google::Spreadsheets::Cell -

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHOD

=head1 AUTHOR

=cut
