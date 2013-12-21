//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Allen Chang on 2/2/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "PlayingCardCollectionViewCell.h"
#import "CardMatchingGame.h"
@interface PlayingCardGameViewController()

@property (nonatomic) IBOutlet PlayingCardView *history1;
@property (nonatomic) IBOutlet PlayingCardView *history2;



@end

@implementation PlayingCardGameViewController


//required to fill out these methods from the superclass



- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (NSUInteger)startingCardCount  //lazy initializer
{
    return 22;
}

-(int)maxFaceUps  //lazy initializer for abstract property
{
    return 1;
}

-(int)flipCost  //lazy initializer for abstract property
{
    return 1;
}

-(int)addCards{
    return 0;
}

-(void)updateHistory:(NSArray *)faceUpCards{
    int numFaceUps=[faceUpCards count];
    self.history1.faceUp = NO;  //reset the history cards
    self.history2.faceUp = NO;
    if(numFaceUps>0){
        self.history1.rank = ((PlayingCard *)[faceUpCards objectAtIndex:0]).rank;
        self.history1.suit = ((PlayingCard *)[faceUpCards objectAtIndex:0]).suit;
        self.history1.faceUp = YES;
            
    }
    if(numFaceUps>1){
        self.history2.rank = ((PlayingCard *)[faceUpCards objectAtIndex:1]).rank;
        self.history2.suit = ((PlayingCard *)[faceUpCards objectAtIndex:1]).suit;
        self.history2.faceUp = YES;
    }
}


 

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    if ([cell isKindOfClass:[PlayingCardCollectionViewCell class]]) {
        PlayingCardView *playingCardView = ((PlayingCardCollectionViewCell *)cell).playingCardView;
        if ([card isKindOfClass:[PlayingCard class]]) {
            PlayingCard *playingCard = (PlayingCard *)card;
            playingCardView.rank = playingCard.rank;
            playingCardView.suit = playingCard.suit;
            playingCardView.faceUp = playingCard.isFaceUp;
            
        }
    }
}

-(NSString *)generateUpdateString:(CardMatchingGame *)givenGame {
  
    if(givenGame.recentScore < 0){//case where made a mismatched set
        NSString *contents1 = ((Card *)givenGame.recentCards[0]).contents;
        NSString *contents2 = ((Card *)givenGame.recentCards[1]).contents;
        return [[NSString alloc] initWithFormat:@"Mismatched %@ and %@ for a penalty of %d points",contents1,contents2,givenGame.recentScore];
    }
    else if(givenGame.recentScore >0){  //case where there is a successful match
        NSString *contents1 = ((Card *)givenGame.recentCards[0]).contents;
        NSString *contents2 = ((Card *)givenGame.recentCards[1]).contents;
        return [[NSString alloc] initWithFormat:@"Matched %@ and %@ for %d points",contents1,contents2,givenGame.recentScore];
    }
    return @"";  //don't return an outcome string if not making a match
}

@end
