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
    fist.name = @"fist";
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

@end
