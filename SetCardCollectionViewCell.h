//
//  SetCardCollectionViewCell.h
//  Matchismo
//
//  Created by Allen Chang on 2/2/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetCardView.h"

@interface SetCardCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet SetCardView *setCardView;

@end
