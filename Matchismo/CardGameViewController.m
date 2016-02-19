//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Hafiz on 10/29/13.
//  Copyright (c) 2013 Hafiz. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
@interface CardGameViewController ()

//i just wanna say that if it is true so two card matching,else if it is false so you can say that the game is gonna be three card matching, here we go
@property(nonatomic) BOOL matchingMode;
@property (nonatomic) BOOL gameEnableDisable;
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic) BOOL startDeal;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultOfLastFlip;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameStatusBar;
@property (weak, nonatomic) IBOutlet UISwitch *gameEnable;

@end

@implementation CardGameViewController

- (IBAction)enableDisableGame:(UISwitch *)sender
{
    NSLog(@"fljgsifg");
    if(_gameEnableDisable == YES)
    {
        NSLog(@"fljgsifg");
        if([sender isOn])
        {
            NSLog(@"fljgsifg");
            [_gameStatusBar setEnabled:YES];
            _gameEnableDisable = YES;
            [_gameStatusBar setEnabled:YES ];
            _game = nil;
        }
        else
        {
            NSLog(@"fljgsifg");
            _gameEnableDisable = NO;
        }
    }
}

- (IBAction)gameStatus:(id)sender
{
    //NSLog(@"NSkfgbi %d", [self.gameStatusBar selectedSegmentIndex]) ;
    if([self.gameStatusBar selectedSegmentIndex] == 0)
    {
        NSLog(@"Two card Match\n");
        _matchingMode = NO;
    }
    else if([self.gameStatusBar selectedSegmentIndex] == 1)
    {
        NSLog(@"Three Card Match \n");
        _matchingMode = YES;
        
    }
    
    _gameStatusBar.enabled = NO;
}

- (IBAction)deal:(UIButton *)sender
{
    self.game = nil;
    _game = [[CardMatchingGame alloc]initWithCardCount:self.cardButtons.count withDeck:[[PlayingCardDeck alloc]init]];
    
    [self.gameEnable setOn:YES animated:YES];
 
    self.startDeal = TRUE;
    
    self.gameEnableDisable = TRUE;
    self.flipCount = 0;
    [self updateUI];
    self.resultOfLastFlip.text = @"Start Playing";
}


-(CardMatchingGame *) game
{
    if(!_game)
    {
        _game = [[CardMatchingGame alloc]initWithCardCount:self.cardButtons.count withDeck:[[PlayingCardDeck alloc]init]];
        
    }
    return _game;
}

- (IBAction)aboutButtonAction:(UIButton *)sender
{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"About Us" message:@"Name : Hafiz K.Irshaid\nNajah National University\n Thanks to Stanford University" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alert show];
}

-(void) setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    
    [self updateUI];
}


-(void)  updateUI
{
    for(UIButton *cardButton in self.cardButtons)
    {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.unplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
        
    }
    self.resultOfLastFlip.text = self.game.lastFlipResult;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score:%d",self.game.score];
}

-(void) setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flips:%d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    if(self.startDeal && self.gameEnableDisable == YES)
    {
        //sender.selected  = !sender.isSelected;
        [self.game flipCardIndex:[self.cardButtons indexOfObject:sender] andMode:_matchingMode];
        self.flipCount++;
        [self updateUI];
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Deal" message:@"Please touch Deal Button To start New Game!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
        [alert show];
        
    }
}

@end