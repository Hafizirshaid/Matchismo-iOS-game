//
//  PlayingCard.m
//  Matchismo
//
//  Created by Hafiz on 10/29/13.
//  Copyright (c) 2013 Hafiz. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard
@synthesize suit = _suit;


-(int)  match:(NSArray *)otherCards
{
    int score = 0;
    //two card matching
    if(otherCards.count == 1)
    {
        PlayingCard *otherCard = [otherCards lastObject];
        if([otherCard.suit isEqualToString:self.suit])
        {
            score = 1;
        }
        else if(otherCard.rank == self.rank)
        {
            score = 4;
        }
    }
    //three card matching 
    else if(otherCards.count == 2)
    {
        PlayingCard *otherCard1 = [otherCards lastObject];
        PlayingCard *otherCard2 = [otherCards objectAtIndex:[otherCards count] - 1];

        if(([otherCard1.suit isEqualToString:self.suit]) && ([otherCard2.suit isEqualToString:self.suit]) && ([otherCard1.suit isEqualToString:otherCard2.suit]))
        {
            score = 2;
        }
        else if((otherCard1.rank == self.rank) && (otherCard2.rank == self.rank) && (otherCard1.rank == otherCard2.rank))
        {
            score = 8;
        }
    }
    
    
    return score;
}

- (NSString *)contents
{
     NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
        
     }
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count-1;
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}


-(void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

@end
