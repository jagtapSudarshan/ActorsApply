//
//  UpdateProfileViewController.h
//  ActorsApply
//
//  Created by Sandip Mahajan on 11/3/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateProfileViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic)NSMutableArray *profileImages;
@property (nonatomic)NSMutableArray *profileMediaVideos;
@property (nonatomic)NSMutableArray *profileProjects;

@end
