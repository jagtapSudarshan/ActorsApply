//
//  ViewApplicant.h
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/28/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ViewApplicant : NSObject

@property (nonatomic) NSString *viewApplicantId;
@property (nonatomic) NSString *user_id;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *type;
@property (nonatomic) NSString *vwAppdesc;
@property (nonatomic) NSString *location;
@property (nonatomic) NSString *roleCount;
@property (nonatomic) NSString *applicationCount;
@property (nonatomic) NSString *castingDate;
@property (nonatomic) NSString *shootingDate;
@property (nonatomic) NSString *industry;
@property (nonatomic) NSString *casting_director;
@property (nonatomic) NSString *director;
@property (nonatomic) NSString *status;
@property (nonatomic) NSString *application_count;
@property (nonatomic) NSString *created;
@property (nonatomic) NSString *modified;
@property (nonatomic) NSMutableArray *roles;

@end
