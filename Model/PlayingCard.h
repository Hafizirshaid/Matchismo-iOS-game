//
//  PlayingCard.h
//  Matchismo
//
//  Created by Hafiz on 10/29/13.
//  Copyright (c) 2013 Hafiz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
@interface PlayingCard : Card

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

@end
