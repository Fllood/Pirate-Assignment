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
#import "FSEvent.h"

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
    
    self.myBoss = [[FSBoss alloc] init];
    self.myBoss.name = @"Octopus";
    self.myBoss.health = 100;
    self.myBoss.damage = 10;
    self.myBoss.position = CGPointMake(3, 2);
    
    
    self.myFactory = [[FSFactory alloc]init];
    [self.myFactory makeTiles];
    [self.myFactory makeWeapons];
    [self.myFactory makeArmors];
    [self.myFactory makeEvents];
    
    self.myCharacter.armor = [self.myFactory.armors objectAtIndex:0];
    self.myCharacter.weapon = [self.myFactory.weapons objectAtIndex:0];
    
    
    self.borderImage.image = [UIImage imageNamed:@"rahmen.png"];
    
    [self nextMove];
    
}

-(void)drawTiles
{
    for (NSInteger i = 0; i < [self.tileCollection count]; i++) {
        FSTile *tile = [self.myFactory.tiles objectAtIndex:i];
        UIImageView *imageView = [self.tileCollection objectAtIndex:i];
        if (self.myCharacter.position.x + self.myCharacter.position.y * 4  == i ) {
            if (self.myCharacter.facingRight) {
                imageView.image = [UIImage imageNamed:@"beach_pirate_right.jpg"];
            }else{
                imageView.image = [UIImage imageNamed:@"beach_pirate_left.jpg"];
            }
            
        }else if(self.myBoss.position.x + self.myBoss.position.y * 4  == i && self.myBoss.health > 0){
            imageView.image = [UIImage imageNamed:@"octopus.jpg"];
        }
        else imageView.image = tile.background;
        
    }
}

-(void)updateLabels
{
    self.healthLabel.text = [NSString stringWithFormat:@"%i", self.myCharacter.health];
    
    self.armorLabel.text = [NSString stringWithFormat:@"%i",self.myCharacter.armor.damageReduction];
    self.armorNameLabel.text = self.myCharacter.armor.name;
    
    self.damageLabel.text = [NSString stringWithFormat:@"%i",self.myCharacter.weapon.damage];
    self.weaponNameLabel.text = self.myCharacter.weapon.name;
    
    self.bossHealthLabel.text = [NSString stringWithFormat:@"%i",self.myBoss.health];
}

-(void)nextMove
{
    [self updateLabels];
    [self drawTiles];
    BOOL eventFound = NO;
    for (FSEvent *event in self.myFactory.events) {
        if (event.position.x == self.myCharacter.position.x && event.position.y == self.myCharacter.position.y && !(self.myCharacter.weapon.damage == event.weapon.damage) && !(self.myCharacter.armor.damageReduction == event.armor.damageReduction)) {
            self.storyLabel.text = event.text;
            eventFound = YES;
        }
    }
    if (!eventFound) {
        if (self.myBoss != nil) {
            if (self.myBoss.health < 1) {
                self.storyLabel.text = @"You have won the battle against the powerful octupus!";
                self.myBoss = nil;
                self.bossHealthLabel.text = [NSString stringWithFormat:@"%i",0];
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Congratulations!" message:@"You are the ruler of the universe!" delegate:nil cancelButtonTitle:@"Return to board" otherButtonTitles: nil];
                [alertView show];
            }else if (self.myCharacter.health <1){
                self.healthLabel.text = [NSString stringWithFormat:@"%i",0];
                self.storyLabel.text = @"Oh no, you died in the battle with the octupus!";
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"You suck!" message:@"Game over!" delegate:nil cancelButtonTitle:@"Reset" otherButtonTitles: nil];
                [alertView show];
                [self resetButton:nil];
            }else{
                if (self.nearBoss) {
                    self.storyLabel.text = @"You are in reach of the octupus! Press action to attack him!";
                }else{
                    self.storyLabel.text = @"Go on and get near the fearless octupus!";
                }
            }
        }else{
            self.storyLabel.text = @"You have won the battle against the powerful octupus!";
        }
    }
}

-(BOOL)nearBoss
{
    if ((abs(self.myCharacter.position.x - self.myBoss.position.x)==1 && abs(self.myCharacter.position.y - self.myBoss.position.y)==0 )|| (abs(self.myCharacter.position.x - self.myBoss.position.x)==0 && abs(self.myCharacter.position.y - self.myBoss.position.y)==1) ) {
        return YES;
    }else return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)upButton:(UIButton *)sender {
    if(self.myCharacter.position.y > 0 && (!(self.myBoss.position.x == self.myCharacter.position.x && self.myBoss.position.y == self.myCharacter.position.y - 1)|| self.myBoss == nil)){
        self.myCharacter.position = CGPointMake(self.myCharacter.position.x, self.myCharacter.position.y - 1);
    }
    [self nextMove];
}

- (IBAction)downButton:(UIButton *)sender {
    if(self.myCharacter.position.y < 2 && (!(self.myBoss.position.x == self.myCharacter.position.x && self.myBoss.position.y == self.myCharacter.position.y + 1)|| self.myBoss == nil)){
        self.myCharacter.position = CGPointMake(self.myCharacter.position.x, self.myCharacter.position.y + 1);
    }
    [self nextMove];
}

- (IBAction)leftButton:(UIButton *)sender {
    self.myCharacter.facingRight = NO;
    if(self.myCharacter.position.x > 0 && (!(self.myBoss.position.x == self.myCharacter.position.x - 1 && self.myBoss.position.y == self.myCharacter.position.y)|| self.myBoss == nil)){
        self.myCharacter.position = CGPointMake(self.myCharacter.position.x - 1 , self.myCharacter.position.y);
    }
    [self nextMove];
}

- (IBAction)rightButton:(UIButton *)sender {
    self.myCharacter.facingRight = YES;
    if(self.myCharacter.position.x < 3 && (!(self.myBoss.position.x == self.myCharacter.position.x + 1 && self.myBoss.position.y == self.myCharacter.position.y)|| self.myBoss == nil)){
        self.myCharacter.position = CGPointMake(self.myCharacter.position.x + 1 , self.myCharacter.position.y);
    }
    [self nextMove];
}

- (IBAction)resetButton:(UIButton *)sender {
    self.myCharacter = nil;
    self.myFactory = nil;
    self.myBoss = nil;
    [self viewDidLoad];
}

- (IBAction)actionButton:(UIButton *)sender {
    
    BOOL eventFound = NO;
    for (FSEvent *event in self.myFactory.events) {
        if (event.position.x == self.myCharacter.position.x && event.position.y == self.myCharacter.position.y && !(self.myCharacter.weapon.damage == event.weapon.damage) && !(self.myCharacter.armor.damageReduction == event.armor.damageReduction)) {
            eventFound = YES;
            if (event.weapon != nil) {
                self.myCharacter.weapon = event.weapon;
                self.weaponNameLabel.text = event.weapon.name;
                self.damageLabel.text = [NSString stringWithFormat:@"%i",event.weapon.damage];
            }
            if (event.armor != nil) {
                self.myCharacter.armor = event.armor;
                self.armorNameLabel.text = event.armor.name;
                self.armorLabel.text = [NSString stringWithFormat:@"%i",event.armor.damageReduction];
            }
            if (event.healthBoost != 0) {
                self.myCharacter.health += event.healthBoost;
            }
            [self nextMove];
        }
    }
    if (self.nearBoss && !eventFound) {
        self.myBoss.health -= self.myCharacter.weapon.damage;
        self.myCharacter.health -= self.myBoss.damage - self.myCharacter.armor.damageReduction;
        [self nextMove];
    }
}
@end
