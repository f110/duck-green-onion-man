package Net::Google::Spreadsheets::Cell;
use Mouse;

with 'Net::Google::Spreadsheets::Entry';

has "+id" => (
    lazy => 1,
    builder => '_build_id',
);
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
    required => 1,
);
has row => (
    is => 'rw',
    isa => 'Int',
    required => 1,
);

__PACKAGE__->meta->make_immutable;
no Mouse;

use XML::XPath;
use XML::DOM;
use Encode;

sub set_value {
    my $self = shift;
    my $value = shift;

    my $xml = XML::XPath->new(xml => $self->xml_string);
    $xml->setNodeText(q{//entry/gs:cell/@inputValue}, $value);
    $self->xml_string(encode_utf8($xml->findnodes_as_string("//entry")));
}

sub to_string {
    my $self = shift;

    my $parser = XML::DOM::Parser->new();
    my $dom = $parser->parse(BASE_XML());
    $dom->getElementsByTagName("id")->item(0)->appendChild(
        $dom->createTextNode(
            sprintf('https://spreadsheets.google.com/feeds/cells/%s/%s/private/full/%s',
                $self->worksheet->spreadsheet->id,
                $self->worksheet->id,
                $self->id,
            )
        )
    );
    my $cell = $dom->createElement('gs:cell');
    $cell->setAttribute(row => $self->row);
    $cell->setAttribute(col => $self->col);
    $cell->setAttribute(inputValue => $self->value);
    $dom->getDocumentElement->appendChild($cell);

    return $dom->toString;
}

sub _build_id {
    my $self = shift;

    return sprintf("R%dC%d", $self->row, $self->col);
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
