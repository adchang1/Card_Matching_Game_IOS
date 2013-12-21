//
//  SetCardView.m
//  Matchismo
//
//  Created by Allen Chang on 2/2/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "SetCardView.h"
#define CORNER_RADIUS 12.0

@implementation SetCardView

- (void)setShape:(int)shape
{
    _shape = shape;
    [self setNeedsDisplay];
}

- (void)setColor:(int)color
{
    _color = color; 
    [self setNeedsDisplay];
}
- (void)setShading:(int)shading
{
    _shading=shading;
    [self setNeedsDisplay];
}
- (void)setQuant:(int)quant
{
    _quant = quant;
    [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];          //MARK IT FOR REFRESH
}

- (void)setIsUnplayable:(BOOL)isUnplayable
{
    _isUnplayable = isUnplayable;
    [self setNeedsDisplay];
}

#define H_SCALE 0.8
#define H_SEGMENT 0.05
#define CORNER_RADIUS 12.0

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //draw the basic card
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:CORNER_RADIUS];
    [roundedRect addClip];
    //color the inner area of the rect
    [[UIColor whiteColor] setFill];   //this SETS the fill color but doesnt actually do the fill
    UIRectFill(self.bounds);
    [[UIColor blackColor] setStroke];   //color the wireframe of the rect
    [roundedRect stroke];
    
    if(self.faceUp){
        UIColor* bkgnd = [UIColor grayColor];
        bkgnd = [bkgnd colorWithAlphaComponent:0.3];
        [bkgnd setFill];
        [roundedRect fill];
    }
    else{

    }
    
    
    
    int quantity =(self.quant+1);
    int spacing = ((self.bounds.size.height*H_SCALE)/quantity);
    int startHeight = ((self.bounds.size.height*H_SCALE)-self.bounds.size.height*H_SEGMENT/2)/(quantity+1);
    CGPoint start = CGPointMake(self.bounds.size.width/2, startHeight);
    
    for(int shapeNumber=1; shapeNumber <= quantity;shapeNumber++){
        UIBezierPath *shape = [self ShapePath:self.shape :start];
        if(self.color==0){
            [[UIColor greenColor] setStroke];  //set the line color
            
            if(self.shading ==2){  //figure out fill types
                UIImage * line = [UIImage imageNamed:@"greenstripe.png"];
                [[UIColor colorWithPatternImage:line] setFill];
            }
            else if(self.shading ==1){
                [[UIColor greenColor]setFill];
            }
            
        }  //end green cases
        else if(self.color==1){
            [[UIColor redColor] setStroke];  //set the line color
            if(self.shading==2){
                UIImage *line = [UIImage imageNamed:@"redstripe.png"];
                [[UIColor colorWithPatternImage:line] setFill];
            }
            else if(self.shading ==1){
                [[UIColor redColor]setFill];
            }
        } //end red case
        
        
        else {  //definitely purple at this point
            [[UIColor purpleColor] setStroke];  //set the line color
            if(self.shading==2){
                UIImage *line = [UIImage imageNamed:@"purplestripe.png"];
                [[UIColor colorWithPatternImage:line] setFill];
            }
            else if(self.shading ==1){
                [[UIColor purpleColor]setFill];
            }
        }  //end purple
        
        shape.lineWidth = 1.0;
        [shape fill];
        [shape stroke];
        
        start = CGPointMake(start.x, start.y+spacing);  //prep the position of the next shape on the card
    }
    
 
}


-(UIBezierPath *)ShapePath:(int)type :(CGPoint)start{
    int unit = self.bounds.size.width*H_SEGMENT;  //scalable length of shape segments
    UIBezierPath *path = [[UIBezierPath alloc]init];
    [path moveToPoint:start];
    
    if(type==0){  //pill shape
        [path addLineToPoint:CGPointMake(start.x-2*unit, start.y)];
        CGPoint circle1Center = CGPointMake(start.x-2*unit, start.y+2*unit);
        [path addArcWithCenter:circle1Center radius:2*unit startAngle:-M_PI/2 endAngle:M_PI/2 clockwise:NO];
        [path addLineToPoint:CGPointMake(start.x+2*unit, start.y+4*unit)];
        CGPoint circle2Center = CGPointMake(start.x+2*unit, start.y+2*unit);
        [path addArcWithCenter:circle2Center radius:2*unit startAngle:M_PI/2 endAngle:-M_PI/2 clockwise:NO];
        [path closePath];
       
        return path;
        
    }
    if(type==1){  //diamond shape
        [path addLineToPoint:CGPointMake(start.x+4*unit, start.y+2*unit)];
        [path addLineToPoint:CGPointMake(start.x, start.y+4*unit)];
        [path addLineToPoint:CGPointMake(start.x-4*unit, start.y+2*unit)];
        [path closePath];
        
        return path;
        
    }
    if(type==2){  //squiggle shape
      //  start = CGPointMake(start.x, start.y+10);
        [path moveToPoint:start];
        [path addLineToPoint:CGPointMake(start.x+1*unit, start.y+1*unit)];
        [path addLineToPoint:CGPointMake(start.x+2*unit, start.y+1*unit)];
        [path addLineToPoint:CGPointMake(start.x+4*unit, start.y-1*unit)];
        [path addLineToPoint:CGPointMake(start.x+4*unit, start.y+2*unit)];
        [path addLineToPoint:CGPointMake(start.x+2*unit, start.y+4*unit)];
        [path addLineToPoint:CGPointMake(start.x+1*unit, start.y+4*unit)];
        [path addLineToPoint:CGPointMake(start.x, start.y+3*unit)];
        [path addLineToPoint:CGPointMake(start.x-1*unit, start.y+2*unit)];
        [path addLineToPoint:CGPointMake(start.x-2*unit, start.y+2*unit)];
        [path addLineToPoint:CGPointMake(start.x-4*unit, start.y+4*unit)];
        [path addLineToPoint:CGPointMake(start.x-4*unit, start.y+1*unit)];
        [path addLineToPoint:CGPointMake(start.x-2*unit, start.y-1*unit)];
        [path addLineToPoint:CGPointMake(start.x-1*unit, start.y-1*unit)];
        
        [path closePath];
        return path;
    }
    return nil;
}

#pragma mark - Initialization

- (void)setup
{
    // do initialization here
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame    //the initializer!  we usually use initwithFrame...to set the boundaries
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}


@end
