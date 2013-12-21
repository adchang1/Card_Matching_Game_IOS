//
//  Deck.m
//  Matchismo
//
//  Created by Allen Chang on 1/11/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic)NSMutableArray *cards;


@end


@implementation Deck
-(NSMutableArray *)cards{
    if(!_cards){
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

-(void)addCard:(Card *)card atTop:(BOOL)atTop{
    if(atTop){
        [self.cards insertObject:card atIndex:0];
    }
    else{
        [self.cards addObject:card];
    }
    
}

-(Card *)drawRandomCard{
    Card *randomCard = nil;
    if(self.cards.count){  //if still elements in array (cards left)
        unsigned index = arc4random() % self.cards.count; //generate a rand that is in the range of the array indexes
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    return randomCard;
    
}

-(NSUInteger)quantity{
    return [self.cards count];
}

@end
