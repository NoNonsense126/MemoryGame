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
    int margin = 12;
    int topOffset = 40;
    int border = 4;
    
    CGSize size = [[UIScreen mainScreen] bounds].size;
    int screenHeight = size.height - 2 * margin;
    int screenWidth = size.width - 2 * margin;
    int extent = MIN(screenHeight, screenWidth); //Authored by Andy Mill
    
    int buttonWidth = extent / self.cardsPerRow - border;
    int buttonHeight = extent / self.cardsPerColumn - border;

    
    int x = margin;
    int y = margin + topOffset;
    
    NSMutableArray *stackViews = [NSMutableArray new];
    
    for (int i = 0; i < self.cardsPerColumn; i++) {
        NSMutableArray *displayCards = [NSMutableArray new];
        
        for (int j = 0; j < self.cardsPerRow; j++) {
            DisplayCard *displayCard = [DisplayCard new];
            
            displayCard.frame = CGRectMake(0, 0, buttonWidth, buttonHeight);
            
            displayCard.backgroundColor = [UIColor grayColor];
            displayCard.layer.borderColor = [UIColor blackColor].CGColor;
            displayCard.layer.borderWidth = 1;
            
            [self.displayCards addObject:displayCard];
            [displayCards addObject:displayCard];
        }
        
        UIStackView *horizontalStackView = [[UIStackView alloc] initWithArrangedSubviews:displayCards];
        horizontalStackView.axis = UILayoutConstraintAxisHorizontal;
        horizontalStackView.distribution = UIStackViewDistributionFillEqually;
        [stackViews addObject:horizontalStackView];
    }
    
    UIStackView *superStackView = [[UIStackView alloc] initWithArrangedSubviews:stackViews];
    superStackView.axis = UILayoutConstraintAxisVertical;
    superStackView.distribution = UIStackViewDistributionFillEqually;
    
    superStackView.frame = CGRectMake(x, y, extent, extent);
    [self.view addSubview:superStackView];
    self.cardSubView = superStackView;
}

@end
