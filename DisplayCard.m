//
//  DisplayCard.m
//  MemoryGame
//
//  Created by Wong You Jing on 25/01/2016.
//  Copyright © 2016 NoNonsense. All rights reserved.
//

#import "DisplayCard.h"

@implementation DisplayCard

- (instancetype) init {
    self = [super init];
    
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:) ];
        
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageNamed:@"back"];
        [self addGestureRecognizer:tap];
        self.revealed = NO;
    }
    return self;
}

- (void) handleTap:(UITapGestureRecognizer *)recognizer{
    if (self.revealed) {
        return;
    }
    
    if (self.revealed == NO) {
        [self revealCard];
    }
    [self.delegate cardWasTapped:self];
}

-(void) revealCard {
//    self.image = [UIImage imageNamed:self.cardImage];
    self.revealed = YES;
    UIImage *toImage = [UIImage imageNamed:self.cardImage];
    [UIImageView transitionWithView:self
                      duration:0.3f
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        self.image = toImage;
                    } completion:nil];
}

-(void) hideCard {
    self.image = [UIImage imageNamed:@"back"];
    self.revealed = NO;
}


@end
