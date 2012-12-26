package App::Onion::Parser;
use strict;
use warnings;
use parent qw/Exporter/;
use HTML::TreeBuilder::XPath;
use URI;
use Data::Dumper;

our @EXPORT = qw/
    get_sender
    get_message_ids
    get_body
    get_title
    get_send_date
/;

sub get_sender($) {
    my $html = shift;
    return (undef, undef) unless $html;
    my $tree = HTML::TreeBuilder::XPath->new_from_content($html);

    my $node = $tree->findnodes(q{//div[@class='messageDetailHead']/dl/dd/a})->pop;
    return (undef, undef) unless $node;

    my $profile_url = URI->new($node->attr("href"));
    my $sender_name = $node->as_text;
    my %query = $profile_url->query_form;

    return ($sender_name, $query{id});
}

sub get_message_ids {
    my $html = shift;
    return unless $html;
    my $tree = HTML::TreeBuilder::XPath->new_from_content($html);

    my @messages = $tree->findvalues(q{//td[@class='subject']/a/@href});
    my @message_ids = map {
        my $uri = URI->new($_);
        my %query = $uri->query_form;
        $query{id};
    } @messages;

    return @message_ids;
}

sub get_body {
    my $html = shift;
    return unless $html;

    my $tree = HTML::TreeBuilder::XPath->new_from_content($html);
    my $body_node = $tree->findnodes(q{//div[@id="message_body"]})->[0];
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
    my $html = shift;
    return unless $html;

    my $tree = HTML::TreeBuilder::XPath->new_from_content($html);
    my $title_node = $tree->findnodes(q{//div[@class="messageDetailHead"]})->[0];
    return if not defined $title_node;
    my $content_ref = $title_node->content_array_ref;

    foreach my $node (@$content_ref) {
        if (ref $node eq "HTML::Element" and $node->tag eq "h3") {
            return $node->as_text;
        }
    }
}

sub get_send_date {
    my $html = shift;
    return unless $html;

    my $tree = HTML::TreeBuilder::XPath->new_from_content($html);
    my $date_node = $tree->findnodes(q{//div[@class="messageDetailHead"]/dl/dd})->[0];
    return if not defined $date_node;
    return $date_node->content_array_ref->[0];
}

1;
__END__
=pod

=encoding utf-8

=head1 NAME

App::Onion::Parser -

=head1 SYNOPSIS

    use App::Onion::Parser;

    my $sneder = get_sender($decoded_content);

=cut
