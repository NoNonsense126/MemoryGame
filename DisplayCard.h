//
//  DisplayCard.h
//  MemoryGame
//
//  Created by Wong You Jing on 25/01/2016.
//  Copyright © 2016 NoNonsense. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DisplayCardDelegate <NSObject>

@optional
-(void) cardWasTapped:(id)sender;

@end

@interface DisplayCard : UIImageView

@property NSString *cardImage;

@property BOOL revealed;

@property id <DisplayCardDelegate> delegate;

-(void) revealCard;

-(void) hideCard;

@end
