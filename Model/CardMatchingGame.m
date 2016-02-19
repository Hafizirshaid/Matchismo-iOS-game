//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Hafiz on 11/11/13.
//  Copyright (c) 2013 Hafiz. All rights reserved.
//

#import "CardMatchingGame.h"
@interface CardMatchingGame()
@property (strong,nonatomic) NSMutableArray * cards;
@property (nonatomic) int score;
@end


@implementation CardMatchingGame
#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4

-(void) setLastFlipResult:(NSString *)lastFlipResult
{
    self.lastFlipResult = lastFlipResult;
}

-(NSMutableArray *) cards
{
    
    
    if(!_cards)
    {
        _cards = [[NSMutableArray alloc]init];
    }
    return _cards;

}

-(id) initWithCardCount:(NSUInteger) cardCount withDeck:(Deck *) deck
{
    self = [super init];
    if(self)
    {
        for(int i = 0; i < cardCount; i++)
        {
            Card *card = [deck drawRandomCard];
            if(!card)
            {
                self = nil;
            }
            else
            {
                self.cards[i] = card;
            }
            
        }
        
    }
    return self;
}


-(Card *) cardAtIndex:(NSUInteger) index
{
    return (index < self.cards.count ? self.cards[index] : nil);
    
}


-(void) flipCardIndex:(NSUInteger) index andMode :(BOOL) twoOrThree
{
    Card *card = [self cardAtIndex:index ];
    NSMutableArray * twoCards = [[NSMutableArray alloc]init];
    int cardCounter = 0;
    if(!card.isUnplayable)
    {
        if(!card.isFaceUp)
        {
            for(Card * otherCard in self.cards)
            {
                if(otherCard.isFaceUp && !otherCard.isUnplayable)
                {
                    
                    if(twoOrThree == true)
                    {
                        int matchScore = [card match:@[otherCard]];
                        if(matchScore)
                        {
                            otherCard.unplayable = YES;
                            card.unplayable = YES;
                            self.score += matchScore * MATCH_BONUS;
                        
                            _lastFlipResult = [NSString stringWithFormat:@"Matched %@ & %@ for 4 Points",card.contents, otherCard.contents];
                        }
                        else
                        {
                            otherCard.faceUp = NO;
                            self.score -= MISMATCH_PENALTY;
                            _lastFlipResult = [NSString stringWithFormat:@"%@ & %@ don’t match! 2 point penalty!",card.contents,otherCard.contents];
                        }
                        break;
                    }
                    else
                    {
                        //NSLog(@"hahahahahah");
                        cardCounter++;
                        [twoCards addObject:otherCard];
                        if(cardCounter == 2)
                        {
                            break;
                        }
                        
                    }
                    
                }
                _lastFlipResult = [NSString stringWithFormat:@"Flipped Up %@", card.contents];
            }
            if(twoOrThree == NO && cardCounter == 2)
            {
                
                Card *card1 = [twoCards objectAtIndex:0];
                Card *card2 = [twoCards objectAtIndex:1];
                int matchScore = [card match:@[card1,card2]];
                if(matchScore)
                {
                    //twoCards[0].unplayable = YES;
                                        
                    card1.unplayable = YES;
                    card2.unplayable = YES;
                    card.unplayable = YES;
                    //card.unplayable = YES;
                    self.score += matchScore * MATCH_BONUS;
                    
                    //_lastFlipResult = [NSString stringWithFormat:@"Matched %@ & %@ for 4 Points",card.contents, otherCard.contents];
                }
                else
                {
                    //otherCard.faceUp = NO;
                    card1.faceUp = NO;
                    card2.faceUp = NO;
                    self.score -= MISMATCH_PENALTY;
                    //_lastFlipResult = [NSString stringWithFormat:@"%@ & %@ don’t match! 2 point penalty!",card.contents,otherCard.contents];
                }

            }
            //loop
            self.score -=FLIP_COST;
        }
        card.FaceUp = !card.isFaceUp;
    }
}
@end
