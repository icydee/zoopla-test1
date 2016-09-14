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
    my $cards_dealt = 0;	# Number of cards played
    my @player_cards = (0,0);   # Number of cards held by each player

    my $shoe = Games::Blackjack::Shoe->new(nof_decks => $self->decks);

    while ($shoe->remaining >= 2) {
        my $card1 = $shoe->draw_card;
        my $card2 = $shoe->draw_card;
        $cards_dealt += 2;
   
        if ($self->cards_matched($card1, $card2)) {
            say "MATCHED ".$self->condition;
            my $winner = int(rand(2));
            say "WINNER Player$winner";
            
            # Move cards to the winners pile
            $player_cards[$winner] += $cards_dealt;
            $cards_dealt = 0;            
        }	
        $self->print_players_hands($card1, $card2);
    }
    say "Cards left unmatched = $cards_dealt";
    say "Cards held by player 1 = ".$player_cards[0];
    say "Cards held by player 2 = ".$player_cards[1];

    if ($player_cards[0] == $player_cards[1]) {
        say "Match! is a Draw";
    }
    elsif ($player_cards[0] > $player_cards[1]) {
        say "Player 1 wins";
    }
    else {
        say "Player 2 wins";
    }
    say "Thank you for playing Match!";
}

#-- Check if cards are matched
#
sub cards_matched {
    my ($self, $card1, $card2) = @_;

    if ($self->condition eq 'value') {
        if ($card1->[1] eq $card2->[1]) {
            return 1;
        }
    }
    elsif ($self->condition eq 'suit') {
        if ($card1->[0] eq $card2->[0]) {
            return 1;
        }
    }
    elsif ($self->condition eq 'both') {
        if ($card1->[1] eq $card2->[1] && $card1->[0] eq $card2->[0]) {
            return 1;
        }
    }
    else {
        die "Unknown condition '".$self->condition."'";
    }
    return;
}


#-- Print players hands
#
sub print_players_hands {
    my ($self, $card1, $card2) = @_;

    say "Player 1 - ".$self->card_to_str($card1);
    say "Player 2 - ".$self->card_to_str($card2);
    say "";
}


#-- Stringify a card
#
sub card_to_str {
    my ($self, $card) = @_;

    return $card->[0] . " " . $card->[1];
}

1;

