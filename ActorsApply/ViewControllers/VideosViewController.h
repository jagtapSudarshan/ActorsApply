//
//  VideosViewController.h
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/5/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"
@interface VideosViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic) NSMutableArray *profileVideos;

@end
