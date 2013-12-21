//
//  SetCardView.h
//  Matchismo
//
//  Created by Allen Chang on 2/2/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView

@property (nonatomic) int shape;
@property (nonatomic) int color;
@property (nonatomic) int quant;
@property (nonatomic) int shading;

@property (nonatomic) BOOL faceUp;
@property (nonatomic) BOOL isUnplayable;


@end
