//
//  ActorList.h
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/28/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActorAsset : NSObject
@property (nonatomic) NSString *actorAsset_id;
@property (nonatomic) NSString *actorAsset_user_id;
@property (nonatomic) NSString *actorAsset_thumb;
@property (nonatomic) NSString *actorAsset_actual_name;
@property (nonatomic) NSString *actorAsset_type;
@property (nonatomic) NSString *actorAsset_profile;
@property (nonatomic) NSString *actorAsset_status;
@property (nonatomic) NSString *actorAsset_created;
@property (nonatomic) NSString *actorAsset_modified;
@property (nonatomic) NSString *asset;

@end

@interface ActorList : NSObject

@property (nonatomic) NSString *actorid;
@property (nonatomic) NSString *role_id;
@property (nonatomic) NSString *project_id;
@property (nonatomic) NSString *user_id;
@property (nonatomic) NSString *asset_id;
@property (nonatomic) NSString *asset_id2;
@property (nonatomic) NSString *shortlisted;
@property (nonatomic) NSString *status;
@property (nonatomic) NSString *created;
@property (nonatomic) NSString *modified;
@property (nonatomic) ActorAsset *asset;
@property (nonatomic) ActorAsset *asset2;

@end

