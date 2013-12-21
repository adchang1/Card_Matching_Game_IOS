//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Allen Chang on 1/11/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"


@implementation PlayingCardDeck


-(id) init{  //initialization routine (Constructor)
    self = [super init];    //first run superclass init to get started
    if(self){  //make sure init succeeded and self != nil
        for(NSString *suit in [PlayingCard validSuits]){
            for(NSUInteger rank =1; rank <= [PlayingCard maxRank]; rank++){
                //for every combo of rank and suit...create a card, set suit/rank, add it
                PlayingCard *card = [[PlayingCard alloc] init];
                [card setSuit:suit];  //can alternatively just use the getter notation on left side of =....
                [card setRank:rank];
                [self addCard:card atTop:YES];
                
            }
            
            
        }
        
    }
    return self;  //return this class Object
}





@end
