//
//  SetCard.h
//  Matchismo
//
//  Created by Allen Chang on 1/24/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"


@interface SetCard : Card
@property (nonatomic) NSInteger shape;
@property (nonatomic) NSInteger quant;
@property (nonatomic) NSInteger shading;
@property (nonatomic) NSInteger color;

+(int)max_attr;  //returns the max # varieties of any one attribute

@end
