//
//  FSEvent.h
//  Pirate Assignment
//
//  Created by Floyd Schauer on 15.09.14.
//  Copyright (c) 2014 fllood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSWeapon.h"
#import "FSArmor.h"


@interface FSEvent : NSObject

@property (strong, nonatomic) NSString *text;
@property (nonatomic) CGPoint position;
@property (strong, nonatomic) FSWeapon *weapon;
@property (strong, nonatomic) FSArmor *armor;
@property (nonatomic) int healthBoost;

@end
