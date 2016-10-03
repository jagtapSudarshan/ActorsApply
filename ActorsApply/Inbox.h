//
//  Inbox.h
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/21/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Inbox : NSObject

@property (nonatomic) NSString *dateCreated;
@property (nonatomic) NSString *desc;
@property (nonatomic) NSString *actual_file;
@property (nonatomic) NSString *application_id;
@property (nonatomic) NSString *attacment;
@property (nonatomic) NSString *eventDate;
@property (nonatomic) NSString *from;
@property (nonatomic) NSString *from_id;
@property (nonatomic) NSString *id;
@property (nonatomic) NSString *invitation_reply;
@property (nonatomic) NSString *invite;
@property (nonatomic) BOOL is_delete;
@property (nonatomic) NSString *parent_id;
@property (nonatomic) NSString *project_id;
@property (nonatomic) NSString *read;
@property (nonatomic) NSString *role_id;
@property (nonatomic) NSString *sent_delete;
@property (nonatomic) NSString *subject;
@property (nonatomic) NSString *to_id;
@property (nonatomic) NSString *venue;


@end
