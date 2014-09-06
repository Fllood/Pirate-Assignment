//
//  FSViewController.m
//  Pirate Assignment
//
//  Created by Floyd Schauer on 03.09.14.
//  Copyright (c) 2014 fllood. All rights reserved.
//

#import "FSViewController.h"
#import "FSCharacter.h"
#import "FSFactory.h"
#import "FSTile.h"

@interface FSViewController ()

@end

@implementation FSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Order the tiles based on their x position
    self.tileCollection = [self.tileCollection sortedArrayUsingComparator:^NSComparisonResult(id label1, id label2) {
        if ([label1 frame].origin.x < [label2 frame].origin.x) return NSOrderedAscending;
        else if ([label1 frame].origin.x > [label2 frame].origin.x) return NSOrderedDescending;
        else return NSOrderedSame;
    }];
    
    // Order the tiles based on their y position
    self.tileCollection = [self.tileCollection sortedArrayUsingComparator:^NSComparisonResult(id label1, id label2) {
        if ([label1 frame].origin.y < [label2 frame].origin.y) return NSOrderedAscending;
        else if ([label1 frame].origin.y > [label2 frame].origin.y) return NSOrderedDescending;
        else return NSOrderedSame;
    }];
    
    
    self.myCharacter = [[FSCharacter alloc] init];
    self.myCharacter.name = @"Hulk";
    self.myCharacter.health = 100;
    self.myCharacter.position = CGPointMake(0, 0);
    self.myCharacter.facingRight = YES;
    
    self.myFactory = [[FSFactory alloc]init];
    [self.myFactory makeTiles];
    [self.myFactory makeWeapons];
    [self.myFactory makeArmors];
    
    
    self.borderImage.image = [UIImage imageNamed:@"rahmen.png"];
    
    [self drawTiles];
    
}

-(void)drawTiles{
    for (NSInteger i = 0; i < [self.tileCollection count]; i++) {
        FSTile *tile = [self.myFactory.tiles objectAtIndex:i];
        UIImageView *imageView = [self.tileCollection objectAtIndex:i];
        if (self.myCharacter.position.x + self.myCharacter.position.y * 4  == i ) {
            if (self.myCharacter.facingRight) {
                imageView.image = [UIImage imageNamed:@"beach_pirate_right.jpg"];
            }else{
                imageView.image = [UIImage imageNamed:@"beach_pirate_left.jpg"];
            }
            
        }else imageView.image = tile.background;
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)upButton:(UIButton *)sender {
    if(self.myCharacter.position.y > 0){
        self.myCharacter.position = CGPointMake(self.myCharacter.position.x, self.myCharacter.position.y - 1);
    }
    [self drawTiles];
}

- (IBAction)downButton:(UIButton *)sender {
    if(self.myCharacter.position.y < 2){
        self.myCharacter.position = CGPointMake(self.myCharacter.position.x, self.myCharacter.position.y + 1);
    }
    [self drawTiles];
}

- (IBAction)leftButton:(UIButton *)sender {
    if(self.myCharacter.position.x > 0){
        self.myCharacter.position = CGPointMake(self.myCharacter.position.x - 1 , self.myCharacter.position.y);
        self.myCharacter.facingRight = NO;
    }
    [self drawTiles];
}

- (IBAction)rightButton:(UIButton *)sender {
    if(self.myCharacter.position.x < 3){
        self.myCharacter.position = CGPointMake(self.myCharacter.position.x + 1 , self.myCharacter.position.y);
        self.myCharacter.facingRight = YES;
    }
    [self drawTiles];
}

- (IBAction)resetButton:(UIButton *)sender {
}

- (IBAction)actionButton:(UIButton *)sender {
}
@end
