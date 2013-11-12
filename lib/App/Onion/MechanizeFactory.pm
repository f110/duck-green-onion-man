package App::Onion::MechanizeFactory;
use strict;
use warnings;

use App::Onion::Mechanize;
use WWW::Mechanize::Plugin::FollowMetaRedirect;

sub logged_in {
    my ($class, $url, $email, $password);

    my $mech = App::Onion::Mechanize->new($url);
    $mech->login($email, $password);
    $mech->follow_meta_redirect;

    return $mech;
}

1;
__END__
=pod

=encoding utf-8

=head1 NAME

App::Onion::MechanizeFactory -

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHOD

=head1 AUTHOR

=cut
