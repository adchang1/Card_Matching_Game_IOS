//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Allen Chang on 1/18/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@property  (nonatomic) int maxFaceUpAllowed;  //max face up cards differs btw game types
@property (nonatomic) int flipCost; //penalty for flipping a card can differ btw game types
@property (nonatomic) int addCards; //number of cards to possibly add on user prompt; differs btw games
@property (nonatomic) Deck *cardDeck;

@end

@implementation CardMatchingGame

-(int)cardCount{
    return [self.cards count];
}

-(void)deleteCardAtIndex:(NSUInteger)index{
    [self.cards removeObjectAtIndex:index];
}

/*
-(NSArray *)allFaceUps{
    NSMutableArray *faceUps = [[NSMutableArray alloc]init];
    for(Card *othercard in self.cards){       //generate array of cards that are currently in play and face up.
        if(othercard.isFaceUp && !othercard.isUnplayable){
            [faceUps addObject:othercard];
        }
    }  //end for all cards  -- generates array of comparable cards
    return (NSArray *)faceUps;
    
}
*/


-(NSMutableArray *)cards  //getter for cards array property
{
    if(!_cards){
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;

}

-(NSMutableArray *)moreCards{  //adds X more cards, where X is defined by the specific instance of the game (Set Games can add 3, whereas match games can add 0)
    NSMutableArray *indexesAdded = [[NSMutableArray alloc]init];
    int numCards = [self.cardDeck quantity];
    int limit = MIN(numCards, self.addCards); //if there's less than X cards left in the deck, just give whatever is remaining
    for(int index=0;index<limit;index++){
        Card *card = [self.cardDeck drawRandomCard];
        [self.cards addObject:card];
        int indexAdd = [self.cards count]-1; //the index added is the most recent one
        [indexesAdded addObject:[NSNumber numberWithInt:indexAdd]];  //must wrap in an object
    }
    return indexesAdded;
}
//designated init; specify number of cards to use
-(id)initWithCardCount:(NSUInteger)cardCount  usingDeck:(Deck *)deck withFaceUp:(int)maxFaceUps withFlipCost:(int)flipCost withAddCards:(int)addCards{
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
        self.maxFaceUpAllowed = maxFaceUps;
        self.flipCost = flipCost;
        self.addCards  = addCards;
        self.cardDeck = deck;
    }
    return self;
}

-(Card *) cardAtIndex:(NSUInteger)index{
    if(index<self.cards.count) return self.cards[index];  //cards is the array variable in self.  Arrays have "count" aspect by default
    else return nil;
    
}

-(void)flipCardAtIndex:(NSUInteger)index{
   //do a new count of face Up Cards
    self.recentCards = [[NSMutableArray alloc]init];
    self.recentScore=0;  //reset recent match score and recent cards properties
    
    Card *card=self.cards[index];
    card.faceUp = !card.isFaceUp;  //flip the card the other way (either down or up)
    
    
    for(Card *othercard in self.cards){       //generate array of cards that are currently in play and face up 
        if(othercard.isFaceUp){ 
            [self.recentCards addObject:othercard];
        }
    }  
    NSInteger faceUpCount = [self.recentCards count];


    if(card.isFaceUp){
        self.score = self.score - self.flipCost; //immediately assess the min flip penalty if you flipped a card face up

    }
    
    
    if(card.isFaceUp && faceUpCount > self.maxFaceUpAllowed){  //we do match scoring only if we are flipping a card faceup and are going to exceed the max faceup cards allowed
        
      
        int matchScore = [card match:self.recentCards];  //assess total score first
        [self setRecentScore:matchScore];  //update the recent Score;
        self.score = self.score + matchScore; //finalize resultant score
        
        if(matchScore <0){  //mismatch case...flip them all facedown, but leave playable
            for(Card *otherCard in self.recentCards){
                otherCard.faceUp = NO;
            }
     
        }
        else{   //successful match - show the faceup card, and also set all to unplayable

            for(Card *otherCard in self.recentCards){
                [otherCard setUnplayable:TRUE];
            }
       
        }
        
    } //end if card is face up
   
 

    
}  //end flipCardAtIndex

@end
