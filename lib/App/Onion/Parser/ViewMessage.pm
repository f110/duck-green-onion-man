package App::Onion::Parser::ViewMessage;
use strict;
use warnings;

use parent qw(App::Onion::Parser::Base);

use HTML::TreeBuilder::XPath;
use URI;

sub get_sender {
    my ($self) = @_;
    my $html = $self->{content};

    return (undef, undef) unless $html;
    my $node = __find_nodes($html, q{//div[@class='messageDetailHead']/dl/dd/a})->pop;
    return (undef, undef) unless $node;

    my $profile_url = URI->new($node->attr("href"));
    my $sender_name = $node->as_text;
    my %query = $profile_url->query_form;

    return ($sender_name, $query{id});
}

sub get_body {
    my ($self) = @_;
    my $html = $self->{content};
    return unless $html;

    my $body_node = __find_nodes($html, q{//div[@id="message_body"]})->[0];
    return if not defined $body_node;
    my $content_ref = $body_node->content_array_ref;

    my $message_body;
    foreach my $node (@$content_ref) {
        if (ref $node eq "HTML::Element" and $node->tag eq "br") {
            $message_body .= "\n";
        } elsif (ref $node eq "HTML::Element" and $node->tag eq "a") {
            $message_body .= $node->attr("href")."\n";
        } else {
            $message_body .= $node;
        }
    }

    return $message_body;
}

sub get_title {
    my ($self) = @_;
    my $html = $self->{content};
    return unless $html;

    my $title_node = __find_nodes($html, q{//div[@class="messageDetailHead"]})->[0];
    return if not defined $title_node;
    my $content_ref = $title_node->content_array_ref;

    foreach my $node (@$content_ref) {
        return $node->as_text if (ref $node eq "HTML::Element" and $node->tag eq "h3");
    }
}

sub get_send_date {
    my ($self) = @_;
    my $html = $self->{content};
    return unless $html;

    my $date_node = __find_nodes($html, q{//div[@class="messageDetailHead"]/dl/dd})->[0];
    return if not defined $date_node;
    return $date_node->content_array_ref->[0];
}

sub __find_nodes {
    my ($content, $xpath) = @_;

    my $tree = HTML::TreeBuilder::XPath->new_from_content($content);
    return $tree->findnodes($xpath);
}

1;
__END__
=pod

=encoding utf-8

=head1 NAME

App::Onion::Parser::ViewMessage - 

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHOD

=head1 AUTHOR

=cut
