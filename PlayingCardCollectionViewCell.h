//
//  PlayingCardCollectionViewCell.h
//  Matchismo
//
//  Created by Allen Chang on 2/2/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCardView.h"

@interface PlayingCardCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;  //the only thing in the cell is this view.  There must be some view object inside the cell though first (drag a generic one in). 


@end
