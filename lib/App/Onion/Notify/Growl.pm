package App::Onion::Notify::Growl;
use strict;
use warnings;
use Mouse;

with 'App::Onion::Notify::Base';

no Mouse;

sub call {
    system q#growlnotify -t '鴨ネギ男' -m 'Got new message!'#;
}

1;
__END__
=pod

=encoding utf-8

=head1 NAME

App::Onion::Notify::Growl -

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHOD

=head1 AUTHOR

=cut
