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
    }
    
    return self;
}

- (void) handleTap:(UITapGestureRecognizer *)recognizer{
    NSLog(@"clicked");
    if (self.image == [UIImage imageNamed:@"back"]) {
        self.image = self.cardImage;
    } else {
        self.image = [UIImage imageNamed:@"back"];
    }
}

@end
