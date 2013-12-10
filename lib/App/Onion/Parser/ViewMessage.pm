package App::Onion::Parser::ViewMessage;
use strict;
use warnings;

use parent qw(App::Onion::Parser::Base);

use HTML::TreeBuilder::XPath;
use URI;

sub parse {
    my ($self) = @_;
    my $html = $self->{content};

    return {} unless $html;

    my $nodes = __find_nodes($html, q{//div});
    my @messages;
    for my $node (@$nodes) {
        next unless defined $node->attr('class');
        next unless $node->attr('class') =~ /JS_messageRow/;
        my $result = __parse_message_row($node);
        push @messages, $result;
    }
    my %members = map {
        $_->{id} => $_->{name};
    } grep {
        defined $_->{id} && defined $_->{name};
    } @messages;

    return {
        member => \%members,
        message => [
            map {
                my %query = URI->new($_->{url})->query_form;
                +{
                    sender => $_->{id} ? $_->{id} : '@me',
                    body      => $_->{body},
                    timestamp => $_->{timestamp},
                    $_->{url}         ? (url       => $_->{url}) : (),
                    $query{id}        ? (id        => $query{id}) : (),
                    $query{thread_id} ? (thread_id => $query{thread_id}) : (),
                }
            } @messages
        ],
    };
}

sub __parse_message_row {
    my ($node) = @_;

    my $message_row = {};
    for my $child ($node->content_list) {
        my $class_name = $child->attr('class');
        next unless defined $class_name;

        if ($class_name eq 'author') {
            my ($id, $name) = __extract_author($child);
            $message_row->{id} = $id;
            $message_row->{name} = $name;
        }

        if ($class_name eq 'postBody') {
            $message_row->{body} = __extract_body($child);
        }

        if ($class_name eq 'postData') {
            $message_row->{timestamp} = __extract_timestamp($child);
            $message_row->{url} = __extract_url($child);
        }
    }

    return $message_row;
}

sub __extract_author {
    my ($node) = @_;
    my $href = $node->content_array_ref->[0]->content_array_ref->[0]->attr('href');

    my ($id, $name) = undef;
    if ($href) {
        my %query = URI->new($href)->query_form;
        $id = $query{id};
    }

    my $name_node;
    for my $n (@{$node->content_array_ref}) {
        next unless defined $n;
        next unless ref $n eq 'HTML::Element';
        next unless $n->attr('class') eq 'name';
        $name_node = $n;
    }

    return ($id, $name_node->as_text);
}

sub __extract_body {
    my ($node) = @_;

    return $node->content_array_ref->[0]->as_text;
}

sub __extract_timestamp {
    my ($node) = @_;

    return $node->content_array_ref->[0]->as_text;
}

sub __extract_url {
    my ($node) = @_;

    my $href_node = $node->content_array_ref->[0]->content_array_ref->[0];
    return undef unless defined $href_node;
    return undef unless ref $href_node eq 'HTML::Element';
    return $href_node->attr('href');
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
