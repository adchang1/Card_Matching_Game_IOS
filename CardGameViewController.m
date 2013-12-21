//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Allen Chang on 1/10/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"

#define MAX_CARDS_SELECT 3

@interface CardGameViewController () <UICollectionViewDataSource>  //this acts as the datasource for the collectionview



@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *Outcome;
@property (strong, nonatomic) NSString *outcomeString;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak,nonatomic) IBOutlet UICollectionView *cardCollectionView;
@property (weak,nonatomic) IBOutlet UIButton *addButt;

@end



@implementation CardGameViewController



-(void)updateHistory:(NSArray *)faceUpCards{
    //abstract
}

- (Deck *)createDeck {return nil;}  //abstract...needs to be filled out by subclass!

-(NSString *)generateUpdateString:(CardMatchingGame *)givenGame{  //also abstract...
    return nil;
    
}


-(CardMatchingGame *)game{
    if(!_game){
        _game = [[CardMatchingGame alloc] initWithCardCount:self.startingCardCount usingDeck:[self createDeck] withFaceUp:self.maxFaceUps withFlipCost:self.flipCost withAddCards:self.addCards];
    }
    return _game;
}

-(int)currentCardCount{
    if(!_currentCardCount){
        _currentCardCount = self.startingCardCount;
    }
    return _currentCardCount;
}

#pragma mark - UICollectionViewDataSource   
//required methods since you are the data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
  //  return self.startingCardCount;  //startingCardCount defined by subclasses
    return self.currentCardCount;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath  //given an indexPath and a collectionView, returns the cell at that indexPath.  Also updates cell's properties to align with model before handing it over.  
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PlayingCard" forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card];
    [self updateHistory:self.game.recentCards];  //need this here for the initial wiping of the history
    

    return cell;
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card  //align the cell with the model state
{
    // abstract
}



#pragma mark - Updating the UI



-(void)updateUI{
    [self updateHistory:self.game.recentCards];

    
    //out of all visible cells on screen...retrieve their indexpaths, retrieve the corresponding model object, update them to be aligned.
    

    
    for(int index=0;index < self.game.cardCount;index++){
        Card *card = [self.game cardAtIndex:index];
        if(card.isUnplayable){
        
            
            [self.game deleteCardAtIndex:index];
            index--;  //because the rest of the items shifted down..stay in place to check a new item
        }
    }
    self.currentCardCount = self.game.cardCount;  //update the number of cells we should have (must do this before we do the cell deletion!)
    [self.cardCollectionView reloadData];  //resync!
    
    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells]) {
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card];  //only need to update cells that were not rendered unplayable
  
    }
    
    
   
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score ];
    self.Outcome.text = self.outcomeString;
    self.outcomeString  = nil;   //blank out the outcome status report for a fresh start
    
}


#define pragma mark - Target/Action/Gestures

- (IBAction)flipCard:(UITapGestureRecognizer *)gesture{
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];  //get the physical location of tap
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];  //find the index of the cell that overlaps the tap location

    if (indexPath) {   //if there actually is a cell that matches that location...
        [self.game flipCardAtIndex:indexPath.item];  //indexPath.item is the numerical index; use it to select the corresp card in the game model
        self.outcomeString = [self generateUpdateString:self.game];  //output string determination - must be implemented by the specific subclass
        
        [self updateUI];
     
    } 

}
- (IBAction)dealButton:(UIButton *)sender {
 
    self.game = nil;
    self.addButt.alpha=1;
    [self.cardCollectionView reloadData];
    [self updateUI];
}

- (IBAction)addButton:(UIButton *)sender {
    //must construct an array of NSIndexPaths corresp to the cards we added...
    NSMutableArray *indexPathsToAdd = [[NSMutableArray alloc]init];
    NSMutableArray * indexesToBeAdded = [self.game moreCards];
    
    if([indexesToBeAdded count] <=0){
        self.addButt.alpha=0.3;
    }
    
     self.currentCardCount = self.game.cardCount;  //update the number of cells we should have
    
    for(int index=0;index<[indexesToBeAdded count];index++){
        NSNumber *numObject = indexesToBeAdded[index];
        int num = [numObject integerValue];
        NSIndexPath *path = [NSIndexPath indexPathForItem:num inSection:0];
        [indexPathsToAdd addObject:path];
    }
    [self.cardCollectionView insertItemsAtIndexPaths:indexPathsToAdd];
    [self updateUI];
    if([indexPathsToAdd lastObject]){  //only scroll to newly added items if they actually exist...
        [self.cardCollectionView scrollToItemAtIndexPath:[indexPathsToAdd lastObject] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        
    }
    
}


@end
