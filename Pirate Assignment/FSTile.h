//
//  FSTile.h
//  Pirate Assignment
//
//  Created by Floyd Schauer on 03.09.14.
//  Copyright (c) 2014 fllood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSWeapon.h"
#import "FSArmor.h"

@interface FSTile : NSObject

@property CGPoint position;

@property BOOL bossOnTile;
@property BOOL characterOnTile;
@property FSWeapon *WeaponOnTile;
@property FSArmor *ArmorOnTile;
@property UIImage *background;
@property NSString *story;

@end
