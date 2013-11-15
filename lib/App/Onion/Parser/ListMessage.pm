package App::Onion::Parser::ListMessage;
use strict;
use warnings;
use HTML::TreeBuilder::XPath;
use URI;
use parent qw(App::Onion::Parser::Base);

sub get_message_ids {
    my ($self) = @_;
    my $html = $self->{content};
    return unless $html;

    my $tree = HTML::TreeBuilder::XPath->new_from_content($html);

    my @messages = $tree->findvalues(q{//td[@class='subject']/a/@href});
    my @message_ids = map {
        my $uri = URI->new($_);
        my %query = $uri->query_form;
        $query{thread_id};
    } @messages;

    return wantarray ? @message_ids : \@message_ids;
}

1;
__END__
=pod

=encoding utf-8

=head1 NAME

App::Onion::Parser::ListMessage -

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHOD

=head1 AUTHOR

=cut
