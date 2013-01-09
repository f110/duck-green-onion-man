package Net::Google::Spreadsheets::Spreadsheet;
use Mouse;

has id => (
    is => 'ro',
    isa => 'Str',
    required => 1,
);
has title => (
    is => 'ro',
    isa => 'Str',
    default => "",
);
has author_name => (
    is => 'ro',
    isa => 'Str',
    default => "",
);
has author_email => (
    is => 'ro',
    isa => 'Str',
    default => "",
);
has updated => (
    is => 'ro',
    isa => 'Str',
    default => "",
);

__PACKAGE__->meta->make_immutable;

no Mouse;

1;
__END__
=pod

=encoding utf-8

=head1 NAME

Net::Google::Spreadsheets::Spreadsheet -

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHOD

=head1 AUTHOR

=cut
