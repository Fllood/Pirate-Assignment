//
//  FSViewController.h
//  Pirate Assignment
//
//  Created by Floyd Schauer on 03.09.14.
//  Copyright (c) 2014 fllood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSFactory.h"
#import "FSCharacter.h"
#import "FSBoss.h"

@interface FSViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *healthLabel;
@property (strong, nonatomic) IBOutlet UILabel *armorLabel;
@property (strong, nonatomic) IBOutlet UILabel *damageLabel;
@property (strong, nonatomic) IBOutlet UILabel *weaponNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *armorNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *bossHealthLabel;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *tileCollection;
@property (strong, nonatomic) IBOutlet UIImageView *borderImage;
@property (strong, nonatomic) FSFactory *myFactory;
@property (strong, nonatomic) FSCharacter *myCharacter;
@property (strong, nonatomic) FSBoss *myBoss;

@property (strong, nonatomic) IBOutlet UILabel *storyLabel;

- (IBAction)upButton:(UIButton *)sender;
- (IBAction)downButton:(UIButton *)sender;
- (IBAction)leftButton:(UIButton *)sender;
- (IBAction)rightButton:(UIButton *)sender;
- (IBAction)resetButton:(UIButton *)sender;
- (IBAction)actionButton:(UIButton *)sender;

-(void)drawTiles;
-(void)updateLabels;
-(void)nextMove;
-(BOOL)nearBoss;

@end
