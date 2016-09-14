package Zoopla::App::Match;

use 5.010;
use MooseX::App::Simple qw(Config Color);
use Games::Blackjack;
use Data::Dumper;

option 'decks' => (
    is              => 'rw',
    isa             => 'Int',
    documentation   => q[Number of Decks],
    default         => 1,
);

option 'condition' => (
    is              => 'rw',
    isa             => 'Str',
    documentation   => q[Match Condition, one of value,suit,both],
    required        => 1,
);

sub run {
    my ($self) = @_;

    print "Game On!\n";

    my $shoe = Games::Blackjack::Shoe->new(nof_decks => $self->decks);

    while ($shoe->remaining >= 2) {
        my $card1 = $shoe->draw_card;
        my $card2 = $shoe->draw_card;
        print_players_hands($card1, $card2);
    }
}

#-- Print players hands
#
sub print_players_hands {
    my ($card1, $card2) = @_;

    say "Player 1 - ".card_to_str($card1);
    say "Player 2 - ".card_to_str($card2);
    say "";
}


#-- Stringify a card
#
sub card_to_str {
    my ($card) = @_;

    return $card->[0] . " " . $card->[1];
}

1;

