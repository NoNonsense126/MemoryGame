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
    [self populateCardArray];
    [self showInstructionOnFirstEntry];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self shuffleAndDraw];
}
- (IBAction)onShuffleTapped:(UIButton *)sender {
    [self shuffleAndDraw];
}

- (void) handleTap:(UITapGestureRecognizer *)recognizer{
    [recognizer.view removeFromSuperview];
}

# pragma mark - Helper Methods

-(void)populateCardArray{
    self.displayCards = [NSMutableArray new];
    
    for (int row = 0; row < self.cardsPerRow; row++) {
        for (int col = 0; col < self.cardsPerColumn; col++) {
            DisplayCard *displayCard = [DisplayCard new];
            [self.displayCards addObject:displayCard];
        }
    }
}

-(void)shuffleAndDraw{
    
    NSArray* imageNameArray = @[@"10_of_clubs", @"10_of_diamonds", @"10_of_hearts", @"10_of_spades", @"2_of_clubs", @"2_of_diamonds", @"2_of_hearts", @"2_of_spades", @"3_of_clubs", @"3_of_diamonds", @"3_of_hearts", @"3_of_spades", @"4_of_clubs", @"4_of_diamonds", @"4_of_hearts", @"4_of_spades", @"5_of_clubs", @"5_of_diamonds", @"5_of_hearts", @"5_of_spades", @"6_of_clubs", @"6_of_diamonds", @"6_of_hearts", @"6_of_spades", @"7_of_clubs", @"7_of_diamonds", @"7_of_hearts", @"7_of_spades", @"8_of_clubs", @"8_of_diamonds", @"8_of_hearts", @"8_of_spades", @"9_of_clubs", @"9_of_diamonds", @"9_of_hearts", @"9_of_spades", @"ace_of_clubs", @"ace_of_diamonds", @"ace_of_hearts", @"ace_of_spades",  @"jack_of_clubs",  @"jack_of_diamonds", @"jack_of_hearts", @"jack_of_spades",  @"king_of_clubs", @"king_of_diamonds", @"king_of_hearts",  @"king_of_spades", @"queen_of_clubs", @"queen_of_diamonds", @"queen_of_hearts", @"queen_of_spades"];
                                
    // pull out array / 2 card names

    NSMutableArray *imagesToServe = [NSMutableArray new];
    while (imagesToServe.count < self.displayCards.count / 2){
        NSUInteger randomIndex = arc4random_uniform((u_int32_t)imageNameArray.count - 1);
        NSString *imageName = [imageNameArray objectAtIndex:randomIndex];
        if (![imagesToServe containsObject:imageName]){
            [imagesToServe addObject:imageName];
        }
    }

    // assign image to 2 cards
    for (int i = 0; i < imagesToServe.count; i++){
        ((DisplayCard *)self.displayCards[2*i]).image = [UIImage imageNamed:imagesToServe[i]];
        ((DisplayCard *)self.displayCards[2*i+1]).image = [UIImage imageNamed:imagesToServe[i]];
    }
    
    // shuffle card array
    NSUInteger count = self.displayCards.count;
    for (NSUInteger i = 0; i < count - 1; i++){
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t) remainingCount);
        [self.displayCards exchangeObjectAtIndex:i
                               withObjectAtIndex:exchangeIndex];
    }
    
    // draw
    [self drawBoard];

}

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
            DisplayCard *displayCard = self.displayCards[row * self.cardsPerRow + col];
            displayCard.frame =CGRectMake(intXTile, intYTile, width, height);
            displayCard.backgroundColor = [UIColor whiteColor];


            [self.cardSubView addSubview:displayCard];

        }
    }
}

@end
