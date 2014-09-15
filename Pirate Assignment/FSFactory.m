//
//  FSFactory.m
//  Pirate Assignment
//
//  Created by Floyd Schauer on 03.09.14.
//  Copyright (c) 2014 fllood. All rights reserved.
//

#import "FSFactory.h"
#import "FSTile.h"
#import "FSWeapon.h"
#import "FSArmor.h"
#import "FSEvent.h"

@implementation FSFactory

-(void) makeTiles
{
    self.tiles = [[NSMutableArray alloc] init];
    for (int i=0; i<4; i++) {
        for (int j=0; j<3; j++) {
            FSTile *myTile = [[FSTile alloc]init];
            myTile.position = CGPointMake(i, j);
            myTile.background = [UIImage imageNamed:@"beach.jpg"];
            if (i==3 && j==2) {
                myTile.bossOnTile = YES;
            }else{
                myTile.bossOnTile = NO;
            }
            if (i==0 && j==0) {
                myTile.characterOnTile = YES;
            }else{
                myTile.characterOnTile = NO;
            }
            [self.tiles addObject:myTile];
        }
    }
}

-(void) makeWeapons
{
    self.weapons = [[NSMutableArray alloc] init];
    
    FSWeapon *sword = [[FSWeapon alloc] init];
    sword.name = @"Sword";
    sword.damage = 5;
    
    FSWeapon *fist = [[FSWeapon alloc]init];
    fist.name = @"Fist";
    fist.damage = 2;
    
    FSWeapon *pistol = [[FSWeapon alloc]init];
    pistol.name = @"Pistol";
    pistol.damage = 10;
    
    FSWeapon *cannon = [[FSWeapon alloc]init];
    cannon.name = @"Cannon";
    cannon.damage = 20;
    
    [self.weapons addObject:fist];
    [self.weapons addObject:sword];
    [self.weapons addObject:pistol];
    [self.weapons addObject:cannon];
}


-(void) makeArmors
{
    self.armors = [[NSMutableArray alloc] init];
    
    FSArmor *leather = [[FSArmor alloc]init];
    leather.name = @"Leather Armor";
    leather.damageReduction = 1;
    
    FSArmor *iron = [[FSArmor alloc]init];
    iron.name = @"Iron Armor";
    iron.damageReduction = 3;
    
    FSArmor *steel = [[FSArmor alloc]init];
    steel.name = @"Steel Armor";
    steel.damageReduction = 5;
    
    [self.armors addObject:leather];
    [self.armors addObject:iron];
    [self.armors addObject:steel];
}

-(void) makeEvents
{
    self.events = [[NSMutableArray alloc] init];
    
    FSEvent *foundSword = [[FSEvent alloc] init];
    foundSword.text = @"You are stumbling across a beautiful sword! Press Action to use it!";
    foundSword.weapon = [[self.weapons filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name like 'Sword'"]] firstObject];
    foundSword.position = CGPointMake(0, 2);
    
    [self.events addObject:foundSword];
    
    FSEvent *foundPistol = [[FSEvent alloc] init];
    foundPistol.text = @"Oh, there is a pistol burried in the sand! Press Action to use it!";
    foundPistol.weapon = [[self.weapons filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name like 'Pistol'"]] firstObject];
    foundPistol.position = CGPointMake(1, 1);
    
    [self.events addObject:foundPistol];
    
    FSEvent *foundCannon = [[FSEvent alloc] init];
    foundCannon.text = @"You see a magnificient cannon shimmering in the distance! Press Action to use it!";
    foundCannon.weapon = [[self.weapons filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name like 'Cannon'"]] firstObject];
    foundCannon.position = CGPointMake(3, 0);
    
    [self.events addObject:foundCannon];
    
    FSEvent *foundIronArmor = [[FSEvent alloc] init];
    foundIronArmor.text = @"There is a nice rigid iron armor! Press Action to use it!";
    foundIronArmor.armor = [[self.armors filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name like 'Iron Armor'"]] firstObject];
    foundCannon.position = CGPointMake(2, 0);
    
    [self.events addObject:foundIronArmor];
    
    FSEvent *foundSteelArmor = [[FSEvent alloc] init];
    foundSteelArmor.text = @"You find an armor made out of steel! Press Action to use it!";
    foundSteelArmor.armor = [[self.armors filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name like 'Steel Armor'"]] firstObject];
    foundSteelArmor.position = CGPointMake(3, 1);
    
    [self.events addObject:foundSteelArmor];

}

@end
