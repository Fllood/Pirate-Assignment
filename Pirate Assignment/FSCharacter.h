//
//  FSCharacter.h
//  Pirate Assignment
//
//  Created by Floyd Schauer on 03.09.14.
//  Copyright (c) 2014 fllood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSWeapon.h"
#import "FSArmor.h"

@interface FSCharacter : NSObject

@property CGPoint position;

@property int health;
@property int damage;

@property FSWeapon *weapon;
@property FSArmor *armor;

@property NSString *name;

@property BOOL facingRight;

@end
