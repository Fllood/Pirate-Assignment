//
//  FSFactory.h
//  Pirate Assignment
//
//  Created by Floyd Schauer on 03.09.14.
//  Copyright (c) 2014 fllood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSFactory : NSObject

@property NSMutableArray *tiles;
@property NSMutableArray *weapons;
@property NSMutableArray *armors;
@property NSMutableArray *events;

-(void) makeTiles;
-(void) makeWeapons;
-(void) makeArmors;
-(void) makeEvents;

@end
