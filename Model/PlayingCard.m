//
//  PlayingCard.m
//  Matchismo
//
//  Created by Allen Chang on 1/11/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard
-(NSString *)contents{
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
    
}



-(int)match:(NSArray *)otherCards{  //should only be 2 objects in here
    int score =0;
    PlayingCard* card1 = otherCards[0];
    PlayingCard* card2 = otherCards[1];
    
    if([card1.suit isEqualToString:card2.suit]){
    score =3;
    }
    else if(card1.rank == card2.rank){
    score =12; //rank matches are worth more

    }
    else{  //mismatch
    score = -2;
    }
    
    
    return score;

}//override Card's version; create diff values for suit match and rank match



+(NSArray *)validSuits{  //class method uses plus sign. Cannot use instance methods inside it
    return @[@"♥",@"♦",@"♠",@"♣"];
    
    
}
+(NSArray *)rankStrings{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSUInteger)maxRank{
    
    return [PlayingCard rankStrings].count-1;
}

//**** suit set/get
@synthesize suit = _suit; //need to manually create since we overwrote getter AND setter
-(NSString *)suit{  //initialize using getter
    return _suit ? _suit : @"?";  //if suit has been written, let it be.  If not, spot initialize to ?, to be consistent with the contents method
}
-(void)setSuit:(NSString *)suit{
    if([[PlayingCard validSuits] containsObject:suit]){
        _suit=suit;
    }
}

//**** rank set
-(void)setRank:(NSUInteger)rank{  //remember the arg is unsigned so rank will always be >0, don't need to check that
    if(rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
}


@end
