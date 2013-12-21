//
//  PlayingCard.h
//  Matchismo
//
//  Created by Allen Chang on 1/11/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card
@property (strong,nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;
+(NSArray *)validSuits;   //public method, class method
+(NSUInteger)maxRank;   //public method, class method

@end
