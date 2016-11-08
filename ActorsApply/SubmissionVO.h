//
//  SubmissionVO.h
//  ActorsApply
//
//  Created by Sandip Mahajan on 11/6/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubmissionVO : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *type;
@property (nonatomic) NSString *date;
@property (nonatomic) NSString *roleCount;
@property (nonatomic) NSString *filmType;
@property (nonatomic) NSString *director;
@property (nonatomic) NSString *location;
@property (nonatomic) NSString *desc;
@property (nonatomic) NSMutableArray *roles;

@end
