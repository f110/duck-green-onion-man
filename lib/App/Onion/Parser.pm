package App::Onion::Parser;
use strict;
use warnings;
use parent qw/Exporter/;
use HTML::TreeBuilder::XPath;
use URI;

our @EXPORT = qw/
    get_sender
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
