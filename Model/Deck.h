//
//  Deck.h
//  Machismo
//
//  Created by Sam on 10/6/13.
//  Copyright (c) 2013 Sam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (Card *)drawRandomCard;


@end
