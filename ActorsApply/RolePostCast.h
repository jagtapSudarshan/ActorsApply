//
//  RolePostCast.h
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/21/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RolePostCast : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *minAge;
@property (nonatomic) NSString *maxAge;
@property (assign) BOOL isAgeGroup;
@property (assign) BOOL isExp;
@property (nonatomic) NSString *desc;
@property (assign) BOOL gender;

@end
