package Net::Google::Spreadsheets::Request;
use Mouse;

has furl => (
    is => 'ro',
    isa => 'Furl',
    lazy_build => 1,
    handles => [qw(get post put)]
);
has access_token => (
    is => 'ro',
    isa => 'Str',
    requred => 1,
);
has token_type => (
    is => 'ro',
    isa => 'Str',
    requred => 1,
);

__PACKAGE__->meta->make_immutable;

no Mouse;

use Furl;

sub _build_furl {
    my $self = shift;

    return Furl->new(
        headers => [
            'GData-Version' => '3.0',
            $self->_authorization_header,
        ],
    );
}

sub _authorization_header {
    my $self = shift;

    return "Authorization"
            => sprintf("%s %s", $self->token_type, $self->access_token);
}

1;
__END__
=pod

=encoding utf-8

=head1 NAME

Net::Google::Spreadsheets::Request -

=head1 SYNOPSIS

    use Net::Google::Spreadsheets::Request;

=head1 DESCRIPTION

=head1 METHOD

=head2 get

same as Furl's method

=head2 post

=head2 put

=head1 AUTHOR

=cut
