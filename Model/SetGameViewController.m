//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Allen Chang on 1/25/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "SetGameViewController.h"
#import "CardMatchingGame.h"
#import "SetCardDeck.h"
#import "SetCardCollectionViewCell.h"

#define LIGHT 0
#define MIDDLE 0.5
#define DARK 1

#define RED 0 
#define BLUE 1
#define GREEN 2

@interface SetGameViewController ()


@property (strong, nonatomic) NSMutableAttributedString *outcomeAttrString;

@property (nonatomic) IBOutlet SetCardView *history1;
@property (nonatomic) IBOutlet SetCardView *history2;
@property (nonatomic) IBOutlet SetCardView *history3;


@end


@implementation SetGameViewController

- (Deck *)createDeck   //was abstract
{
    return [[SetCardDeck alloc] init];
}

-(NSUInteger)startingCardCount{  //was abstract
    return 12;
}

-(int)maxFaceUps{  //lazy initializer for abstract property
    return 2;
}

-(int)flipCost  //lazy initializer for abstract property
{
    return 0;
}

-(int)addCards{
    return 3;
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card  //was abstract
{
    
    if ([cell isKindOfClass:[SetCardCollectionViewCell class]]) {
        SetCardView *setCardView = ((SetCardCollectionViewCell *)cell).setCardView;
        if ([card isKindOfClass:[SetCard class]]) {
            SetCard *setCard = (SetCard *)card;
            setCardView.color = setCard.color;
            setCardView.quant = setCard.quant;
            setCardView.shading = setCard.shading;
            setCardView.shape  = setCard.shape ;
            setCardView.faceUp = setCard.isFaceUp;
            
        }
     }
    
    
}


-(void)updateHistory:(NSArray *)faceUpCards{  //was abstract
    
   
     int numFaceUps=[faceUpCards count];
     self.history1.hidden = YES;  //reset the history cards
     self.history2.hidden = YES;
    self.history3.hidden = YES;
    
 
     if(numFaceUps>0){
         SetCard *card = (SetCard *)[faceUpCards objectAtIndex:0];
         [self updateHistoryCell:self.history1 withCard:card];
         self.history1.hidden = NO;
     
     }
     if(numFaceUps>1){
         SetCard *card = (SetCard *)[faceUpCards objectAtIndex:1];
         [self updateHistoryCell:self.history2 withCard:card];
         self.history2.hidden = NO;
     }
    if(numFaceUps>2){
        SetCard *card = (SetCard *)[faceUpCards objectAtIndex:2];
        [self updateHistoryCell:self.history3 withCard:card];
        self.history3.hidden = NO;
    }
    
}

-(void)updateHistoryCell:(SetCardView *)view withCard:(SetCard*)card{ //helper function for update history
    view.quant = card.quant;
    view.color = card.color;
    view.shading = card.shading;
    view.shape = card.shape;
    
}

    


-(NSString *)  generateUpdateString:(CardMatchingGame *)givenGame{
    if(givenGame.recentScore<0){  //mismatch penalty
        return [[NSString alloc] initWithFormat:@"Mismatched for a penalty of %d points",givenGame.recentScore];
    }
    else if(givenGame.recentScore>0){
        return [[NSString alloc] initWithFormat:@"Matched a set for %d points",givenGame.recentScore];
    }
    else{
        return @" ";
    }
}

@end


