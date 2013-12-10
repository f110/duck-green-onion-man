package App::Onion::Parser::ListMessage;
use strict;
use warnings;
use HTML::TreeBuilder::XPath;
use URI;
use parent qw(App::Onion::Parser::Base);
use Data::Dumper;

sub get_message_ids {
    my ($self) = @_;
    my $html = $self->{content};
    return unless $html;

    my $tree = HTML::TreeBuilder::XPath->new_from_content($html);

    my @nodes = $tree->findnodes(q{//table[@class='tableBody']/tr});

    my @message_ids;
    for my $node (@nodes) {
        next unless $node->attr('class') =~ m/notOpened/;
        my $thread_id = __parse_not_opened_message($node);
        push @message_ids, $thread_id if defined $thread_id;
    }

    return wantarray ? @message_ids : \@message_ids;
}

sub __parse_not_opened_message {
    my ($node) = @_;

    for my $child ($node->content_list) {
        next unless $child->attr("class") eq "subject";
        my $url = __pickup_url($child);
        my $thread_id = __parse_url($url);
        return $thread_id if defined $thread_id;
    }
}

sub __pickup_url {
    my ($node) = @_;

    for my $child ($node->content_list) {
        next unless ref $child eq 'HTML::Element';
        next unless $child->tag eq 'a';
        return $child->attr('href');
    }
}

sub __parse_url {
    my ($url) = @_;

    my $uri = URI->new($url);
    my %query = $uri->query_form;
    $query{thread_id};
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
