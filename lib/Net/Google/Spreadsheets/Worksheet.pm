package Net::Google::Spreadsheets::Worksheet;
use Mouse;

has id => (
    is => 'ro',
    isa => 'Str',
    required => 1,
);
has spreadsheet => (
    is => 'ro',
    isa => 'Net::Google::Spreadsheets::Spreadsheet',
    required => 1,
);
has title => (
    is => 'ro',
    isa => 'Str',
    default => "",
);
has updated => (
    is => 'ro',
    isa => 'Str',
    default => "",
);
has row_count => (
    is => 'ro',
    isa => 'Int',
    default => 0,
);
has col_count => (
    is => 'ro',
    isa => 'Int',
    default => 0,
);

__PACKAGE__->meta->make_immutable;
no Mouse;

1;
__END__
=pod

=encoding utf-8

=head1 NAME

Net::Google::Spreadsheets::Worksheet -

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHOD

=head1 AUTHOR

=cut
