Thank you for an interesting coding challange :)

Total time was under 90 minutes, of which about 15 minutes was taking 
boiler-plate code for docker and directory structure and setting up the
build environment in Docker.

A search of CPAN showed a couple of possible modules, Games:Cards looked
promising at first, but closer inspection suggested that it could only
manage one deck of cards so that was out.

Games::Blackjack was then my next choice, although only the 'Shoe' class
was needed so it could be considered to be more than was needed for the
task to hand but it avoided having to write a Card and Deck class by hand.

I estimate that searching CPAN and evaluating the two modules took a further
20 to 40 minutes.

No specific tests were written, but I developed the code in stages and
by writing simple sub-routines. These were 'tested' in stages by using 
print statements as the code was developed.

Similarly by printing out the number of cards at the end a 'sanity check'
was made to ensure that the total number of cards agreed with the number of
decks.

By choosing 1 Deck and 'both' match condition this ensured a draw which
was another test.


If I were to spend more time on this task, I would probably want to look
again at the Games::Cards code, I did find a 'TODO' in the comments to 
support more than one deck. It would be an interesting exercise to submit
a patch to support this feature.

Also creating a number of simple module tests would have been worth doing
if I had had more time. (I can discuss with you my approach to TDD)

Another issue I do not like is that the cards are represented by either
a number or a character ('A',1,2... 'J','Q','K') requiring an 'eq' to 
compare them which I am uneasy using to compare numbers, but it seems to 
work. (I should probably have stringified the numbers)





