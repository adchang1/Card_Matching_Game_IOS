//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Allen Chang on 1/18/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
@interface CardMatchingGame : NSObject
-(id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck*)deck withFaceUp:(int)maxFaceUps withFlipCost:(int)flipCost withAddCards:(int)addCards;  //desig init
-(void)flipCardAtIndex:(NSUInteger)index;
-(Card*)cardAtIndex:(NSUInteger)index;
-(void)deleteCardAtIndex:(NSUInteger)index;
-(int)cardCount;
-(NSMutableArray *)moreCards;   //requests that more cards be added

@property(nonatomic,readonly)int score;
@property (nonatomic) int recentScore;
@property (strong, nonatomic) NSMutableArray *recentCards;
@property(strong, nonatomic) NSArray *allFaceUps;

@end
