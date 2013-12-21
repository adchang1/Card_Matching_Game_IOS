//
//  SetCard.m
//  Matchismo
//
//  Created by Allen Chang on 1/24/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "SetCard.h"
#define MAX_ATTR 3
#define SET_POINTS 4
#define SET_PENALTY -1

@implementation SetCard



-(BOOL)areAllIdentical:(NSArray *)attribute{  //checks if an array of objects is all identical
    for(int index=0;index<[attribute count];index++){  //compare each to the first element
        if(attribute[0]!=attribute[index]){
            return NO;
        }
    }
    return YES;
}

-(BOOL)areAllUnique:(NSArray *)attribute{  //checks if array of objects is all unique
    NSMutableDictionary *occurence = [[NSMutableDictionary alloc]init];
    for(int index=0;index<[attribute count];index++){
        if(![occurence objectForKey:attribute[index]]){  //if key does not exist...make an entry
            NSNumber *exist = [NSNumber numberWithInt:1];
            [occurence setObject:exist forKey:attribute[index]];
        }
        else return NO;    //if key does exist...not unique!
    }
    return YES;
}


-(BOOL)isSet:(NSMutableArray *)totalCards{  //an array of objects is a set if each of its 4 attributes are either all identical or all unique
    NSMutableArray *color = [[NSMutableArray alloc]init];
    NSMutableArray *shape = [[NSMutableArray alloc]init];
    NSMutableArray *quant = [[NSMutableArray alloc]init];
    NSMutableArray *shading = [[NSMutableArray alloc]init];
    
    for(int index=0;index<[totalCards count];index++){
        SetCard *card = (SetCard *)totalCards[index];
        [color addObject:[NSNumber numberWithInt:card.color]];
        [shape addObject:[NSNumber numberWithInt:card.shape]];
        [quant addObject:[NSNumber numberWithInt:card.quant]];
        [shading addObject:[NSNumber numberWithInt:card.shading]];   
    }
  
    
    BOOL colorSet = ([self areAllIdentical:color] || [self areAllUnique:color]);
    BOOL shapeSet = ([self areAllIdentical:shape] || [self areAllUnique:shape]);
    BOOL quantSet = ([self areAllIdentical:quant] || [self areAllUnique:quant]);
    BOOL shadingSet = ([self areAllIdentical:shading] || [self areAllUnique:shading]);
    if(colorSet && shapeSet && quantSet && shadingSet){
        return YES;
    }
    return NO;

}

-(int)match:(NSArray *)otherCards{ //otherCards should contain all cards in the group to be evaluated
    int score =0;
    NSMutableArray *totalCards = (NSMutableArray*)otherCards;
    if([self isSet:totalCards]){
        score = SET_POINTS;
    }
    else{
        score = SET_PENALTY;
    }
  
    return score;
    
}//override Card's version; create diff values for suit match and rank match



+(int)max_attr{
    return MAX_ATTR;
}


//setters

-(void)setShape:(NSInteger)shape{
    //custom setter does check to ensure shape is legit
    if((shape>0) && (shape<MAX_ATTR)){
        _shape=shape;
    }
}

-(void)setQuant:(NSInteger)quant{  //quant should be between 1 and MAX_QUANT
    if((quant>0) && (quant<MAX_ATTR)){
        _quant = quant;
    }
}

-(void)setShading:(NSInteger)shading{  //shading needs to be one of the legit values
    if((shading>0) && (shading<MAX_ATTR)){
        _shading = shading;
    }
}

-(void)setColor:(NSInteger)color{  //color needs to be one of the legit values (less than or equal to MAX_COLORS)
    if((color>0) && (color<MAX_ATTR)){
        _color = color;
    }
}

@end
