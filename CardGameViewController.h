//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Allen Chang on 1/10/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"
@interface CardGameViewController : UIViewController

// all of the following methods must be overriden by concrete subclasses


@property (nonatomic) int currentCardCount; //keeps track of total # of cards thus far (decreasing due to deletes)

@property (readonly, nonatomic) NSUInteger startingCardCount; // abstract, is a fixed number depending on the type of game you are playing

@property (readonly, nonatomic) int maxFaceUps;  //abstract, different games allow diff number of faceup cards

@property (readonly,nonatomic) int flipCost; //abstract, diff games have diff flip penalties

@property (readonly,nonatomic) int addCards; //abstract, diff games have diff amounts


- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card; // abstract method to update all the relevant variables of the cell using a given card as reference

-(NSString *)generateUpdateString:(CardMatchingGame *)givenGame;


- (Deck *)createDeck; // abstract, creates a different kind of card deck depending on which game you are playing.  The game model can then use this deck in its initializer


-(void)updateHistory:(NSArray *)faceUpCards;  //abstract

@end
