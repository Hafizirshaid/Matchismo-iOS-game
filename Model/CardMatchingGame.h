//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Hafiz on 11/11/13.
//  Copyright (c) 2013 Hafiz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject
-(id) initWithCardCount:(NSUInteger) cardCount withDeck:(Deck *) deck;

-(void) flipCardIndex:(NSUInteger) index andMode :(BOOL) twoOrThree;

-(Card *) cardAtIndex:(NSUInteger) index;

@property(nonatomic,readonly) int score;
@property(nonatomic,readonly) NSString *lastFlipResult;

@end
