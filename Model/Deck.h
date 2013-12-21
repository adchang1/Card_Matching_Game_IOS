//
//  Deck.h
//  Matchismo
//
//  Created by Allen Chang on 1/11/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard:(Card *)card atTop:(BOOL)atTop;

-(Card *)drawRandomCard;

-(NSUInteger)quantity;   //returns quantity of cards in deck

@end
