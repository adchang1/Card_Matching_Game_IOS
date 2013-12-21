//
//  SetGame.m
//  Matchismo
//
//  Created by Allen Chang on 1/24/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "SetGame.h"
#import "SetCardDeck.h"
#define FLIP_COST 0

@interface SetGame()  //need to redeclare stuff that we don't inherit from superclass
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;


@end



@implementation SetGame

//designated init; specify number of cards to use
-(id)initWithCardCount:(NSUInteger)cardCount  usingDeck:(SetCardDeck *)deck{
    self = [super init];
 /*   if(self){  //checks for nil
        for(int i=0; i<cardCount;i++){
            Card *card = [deck drawRandomCard];
            if(!card){ //check for nil
                self = nil; //scrap this game (don't add nil to an array...
            }
            else{
                self.cards[i]=card;  //fill out array elements!
            }
        }
    }
 */
    return self;
}

/*
-(int) maxFaceUpAllowed //lazy init getter
{
    if(!_maxFaceUpAllowed){
        _maxFaceUpAllowed = 2; //by default, max face up cards (aside from candidate card) equals 1
    }
    return _maxFaceUpAllowed;
    
}

-(NSMutableArray *)cards  //getter for cards array property
{
    if(!_cards){
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
    
}

//designated init; specify number of cards to use
-(id)initWithCardCount:(NSUInteger)cardCount  usingDeck:(Deck *)deck{
    self = [super init];
    if(self){  //checks for nil
        for(int i=0; i<cardCount;i++){
            Card *card = [deck drawRandomCard];
            if(!card){ //check for nil
                self = nil; //scrap this game (don't add nil to an array...
            }
            else{
                self.cards[i]=card;  //fill out array elements!
            }
        }
    }
    return self;
}

-(Card *) cardAtIndex:(NSUInteger)index{
    if(index<self.cards.count) return self.cards[index];  //cards is the array variable in self.  Arrays have "count" aspect by default
    else return nil;
    
}

-(void)flipCardAtIndex:(NSUInteger)index{
    Card *card=self.cards[index];
    NSMutableArray *faceUpCards = [[NSMutableArray alloc]init ];
    for(Card *othercard in self.cards){       //generate array of cards that are currently in play and face up.
        if(othercard.isFaceUp && !othercard.isUnplayable){ //we prevent scoring against self since the current card is still "face down" and we only score vs cards that are "face up"
            [faceUpCards addObject:othercard];
            
        }
    }  //end for all cards  -- generates array of comparable cards
    NSInteger faceUpCount = faceUpCards.count;
    
    if(!card.isUnplayable){ //recall isUnplayable is a class variable (property) of Card
        if(!card.isFaceUp){
            self.score = self.score - FLIP_COST; //immediately assess the min flip penalty if you are flipping a card face up
            
        }
        [self setRecentScore:0];  //reset recent match score and recent cards properties
        [self setRecentCards:@[card]];
        
        if(!card.isFaceUp && faceUpCount ==self.maxFaceUpAllowed){  //we do match scoring only if we are flipping a card faceup and are going to hit the max faceup cards allowed
            
            
            int matchScore = [card match:faceUpCards];  //assess total score first
            [self setRecentScore:matchScore];  //update the recent Score;
            self.score = self.score + matchScore; //finalize resultant score
            [card setUnplayable:TRUE];
            for(Card *otherCard in faceUpCards){
                [otherCard setUnplayable:TRUE];
            }
            
            [faceUpCards addObject:card]; //prepare to set the recentCards property
            [self setRecentCards:faceUpCards];  //update the recentCards property
            
            
        } //end if card is face down
        
        [card setFaceUp:(!card.isFaceUp)];  //change face of candidate card, regardless of faceup/facedown or matching
    } //end if card is not unplayable
    
    
}  //end flipCardAtIndex

*/

@end
