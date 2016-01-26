//
//  RootViewController.m
//  MemoryGame
//
//  Created by Wong You Jing on 25/01/2016.
//  Copyright © 2016 NoNonsense. All rights reserved.
//

#import "RootViewController.h"
#import "DisplayCard.h"

@interface RootViewController ()

@property NSMutableArray *displayCards;
@property (weak, nonatomic) IBOutlet UIView *cardSubView;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cardsPerRow = 4;
    self.cardsPerColumn = 4;
    
    
    [self showInstructionOnFirstEntry];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self drawBoard];
}

- (void) handleTap:(UITapGestureRecognizer *)recognizer{
    [recognizer.view removeFromSuperview];
}

# pragma mark - Helper Methods

- (void) showInstructionOnFirstEntry {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if (![userDefaults boolForKey:@"firstLaunch"]) {
        [userDefaults setBool:YES forKey:@"firstLaunch"];
        UIImageView *splash = [[UIImageView alloc] initWithFrame:self.view.frame];
        splash.image = [UIImage imageNamed:@"splashscreen@1x"];
        [self.view addSubview:splash];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:) ];
        
        splash.userInteractionEnabled = YES;
        
        [splash addGestureRecognizer:tap];
    }
}

- (void) drawBoard{
    //create button array
    self.displayCards = [NSMutableArray new];
    
    CGFloat totalWidth = self.cardSubView.frame.size.width;
    [[self.cardSubView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSInteger intLeftMargin = 10;
    NSInteger intTopMargin  = 30;
    NSInteger intSpacing = 10;
    NSInteger intXTile;
    NSInteger intYTile;
    
    NSInteger width;
    NSInteger height;
    
    width = ((totalWidth - (intLeftMargin))/self.cardsPerRow) - intSpacing;
    height = width * (3.5 / 2.5);
    
    for (int row = 0; row < self.cardsPerRow; row++) {
        for (int col = 0; col < self.cardsPerColumn; col++) {
            intXTile = (row * (width + intSpacing)) + intLeftMargin;
            intYTile = (col * (height + intSpacing)) + intTopMargin;
            DisplayCard *displayCard = [DisplayCard new];
            displayCard.frame =CGRectMake(intXTile, intYTile, width, height);
            displayCard.backgroundColor = [UIColor whiteColor];


            [self.cardSubView addSubview:displayCard];
            [self.displayCards addObject:displayCard];
        }
    }
}

@end
