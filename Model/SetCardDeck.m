//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Allen Chang on 1/24/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"
#define MAX_ATTR 3
@implementation SetCardDeck

-(id) init{  //initialization routine (Constructor)
    self = [super init];    //first run superclass init to get started
    
    
    
    
    if(self){  //make sure init succeeded and self != nil
        for(int shape=0; shape<MAX_ATTR;shape++){
            for(int shading =0; shading <MAX_ATTR;shading ++){
                for(int quant=0;quant <MAX_ATTR;quant++){
                    for(int color=0;color<MAX_ATTR;color++){
                        //for every combo of color/quant/shade/shape...create a card, add it to the deck
                        SetCard *card = [[SetCard alloc] init];
                        [card setShape:shape];
                        [card setShading:shading];
                        [card setQuant:quant];
                        [card setColor:color];
                        [self addCard:card atTop:YES];
                        
                 
               
                    }       
                }
            }   
        }
    }
    return self;  //return this class Object
}

@end
