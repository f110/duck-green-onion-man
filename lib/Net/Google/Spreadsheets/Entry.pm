package Net::Google::Spreadsheets::Entry;
use Mouse::Role;

has id => (
    is => 'ro',
    isa => 'Str',
);
has worksheet => (
    is => 'ro',
    isa => 'Net::Google::Spreadsheets::Worksheet',
    required => 1,
);
has dom => (
    is => 'rw',
    isa => 'XML::DOM::Document',
    lazy_build => 1,
    handles => {
        to_string => "toString",
    },
);
has updated => (
    is => 'rw',
    isa => 'Str',
    default => "",
);

requires 'add_url';
requires 'edit_url';

no Mouse::Role;

use XML::DOM;
use constant BASE_XML => qq{<entry xmlns="http://www.w3.org/2005/Atom" xmlns:gs="http://schemas.google.com/spreadsheets/2006">
<id></id>
</entry>};

sub _build_dom {
    my $self = shift;

    my $parser = XML::DOM::Parser->new;
    return $parser->parse(BASE_XML());
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
