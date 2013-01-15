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

use XML::DOM;
use Encode;

sub set_value {
    my ($self, $value) = @_;

    $self->value($value);

    my $entry_element = $self->dom->getElementsByTagName("entry")->item(0);

    # remove all gs:cell elements if it exists
    my $cells = $self->dom->getElementsByTagName("gs:cell");
    if ($cells->getLength > 0) {
        my $length = $cells->getLength;
        my $index = 0;
        while ($index < $length) {
            my $element = $cells->item($index);
            $entry_element->removeChild($element);
            $index++;
         }
    }

    my $id_node = $self->dom->getElementsByTagName("id")->item(0)->getChildNodes;
    $self->dom->getElementsByTagName("id")->item(0)->appendChild(
        $self->dom->createTextNode(
            sprintf('https://spreadsheets.google.com/feeds/cells/%s/%s/private/full/%s',
                $self->worksheet->spreadsheet->id,
                $self->worksheet->id,
                $self->id,
            )
        )
    );
    my $cell = $self->dom->createElement('gs:cell');
    $cell->setAttribute(row => $self->row);
    $cell->setAttribute(col => $self->col);
    $cell->setAttribute(inputValue => $self->value);
    $self->dom->getDocumentElement->appendChild($cell);
}

sub add_url {
    my $self = shift;

    return sprintf(
        'https://spreadsheets.google.com/feeds/cells/%s/%s/private/full/%s',
        $self->worksheet->spreadsheet->id,
        $self->worksheet->id,
        $self->id,
    );
}

sub edit_url {
    return shift->add_url;
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
