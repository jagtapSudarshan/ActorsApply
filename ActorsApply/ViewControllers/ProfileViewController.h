//
//  ProfileViewController.h
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/5/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
#import "SuperViewController.h"

@interface ProfileViewController : SuperViewController<UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *about;
@property (weak, nonatomic) IBOutlet UIButton *project;
@property (weak, nonatomic) IBOutlet UIButton *photos;
@property (weak, nonatomic) IBOutlet UIButton *videos;
@property (assign) BOOL isDirectorProfile;

@property (nonatomic) NSMutableArray *profileImages;
//@property (nonatomic)NSMutableArray *profileMediaImages;
@property (nonatomic)NSMutableArray *profileMediaVideos;
@property (nonatomic)NSString *profileImageName;
@property (nonatomic)NSMutableArray *profileProjects;

//@property (nonatomic) NSString *profileImageName;

- (IBAction)moveBack;

@end
