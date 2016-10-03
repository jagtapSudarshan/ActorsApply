//
//  ProfileViewController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/5/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "ProfileViewController.h"
#import "AboutViewController.h"
#import "ProjectViewController.h"
#import "PhotosViewController.h"
#import "VideosViewController.h"
#import "ConnectionManager.h"
#import "WebServiceConstants.h"
#import "SVProgressHUD.h"
#import <UIImageView+AFNetworking.h>

@interface ProfileViewController ()
{
//    NSMutableArray *profileProjects;
//    NSMutableArray *profileMediaImages;
//    NSMutableArray *profileMediaVideos;
//    NSString *profileImageName;
    
    AboutViewController   *aboutVC;
    ProjectViewController *projectVC;
    PhotosViewController  *photosVC;
    VideosViewController  *videosVC;
    
}
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.delegate = self;
    
//    profileProjects =[[NSMutableArray alloc] init];
//    profileMediaImages =[[NSMutableArray alloc] init];
//    profileMediaVideos =[[NSMutableArray alloc] init];
    
   // [self callGetProfileData];
    
    self.navigationController.navigationBar.hidden = YES;
    
  
    aboutVC = [self.storyboard instantiateViewControllerWithIdentifier:@"about_storyboard"];
    [self.containerView addSubview:aboutVC.view];
    
    projectVC = [self.storyboard instantiateViewControllerWithIdentifier:@"project_storyboard"];
    projectVC.profileProjects = _profileProjects;
    
    photosVC = [self.storyboard instantiateViewControllerWithIdentifier:@"photos_storyboard"];
    photosVC.profileImages = _profileImages;
    
    videosVC = [self.storyboard instantiateViewControllerWithIdentifier:@"videos_storyboard"];
    videosVC.profileVideos = _profileMediaVideos;
    
    
    [self->_profileImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.actorsapply.com/img/blog/%@",_profileImageName]] placeholderImage:nil];
    
//    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"about_storyboard"];
//    [self.containerView addSubview:vc.view];
    
    UISwipeGestureRecognizer *swipeLeftGuesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [swipeLeftGuesture setDirection:UISwipeGestureRecognizerDirectionLeft];
    swipeLeftGuesture.delegate = self;
    
    UISwipeGestureRecognizer *swipeRightGuesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [swipeRightGuesture setDirection:UISwipeGestureRecognizerDirectionRight];
    swipeRightGuesture.delegate = self;
    
    [self.containerView addGestureRecognizer:swipeLeftGuesture];
    [self.containerView addGestureRecognizer:swipeRightGuesture];
}

//- (void) callGetProfileData
//{
//    NSString *profileUrl = [NSString stringWithFormat:@"%@%@%@",BASE_URL,PROFILE,[[NSUserDefaults standardUserDefaults] objectForKey:@"id"]];
//    
//    [ConnectionManager callGetMethod:profileUrl completionBlock:^(BOOL succeeded, id responseData, NSString *errorMsg) {
//        
//        [SVProgressHUD dismiss];
//        
//        if (succeeded)
//        {
//            
//            NSArray *projects = [[responseData objectForKey:@"data"] objectForKey:@"projects"];
//            
//            for (NSDictionary *project in projects)
//            {
//                NSMutableDictionary *projectDict = [NSMutableDictionary new];
//                
//                [projectDict setValue:[project valueForKey:@"name"] forKey:@"name"];
//                [projectDict setValue:[project valueForKey:@"modified"] forKey:@"modified"];
//                [projectDict setValue:[project valueForKey:@"director"] forKey:@"director"];
//                
//                [_profileProjects addObject:projectDict];
//            }
//            
//            
//            NSArray *mediaFiles = [[responseData objectForKey:@"data"] objectForKey:@"media"];
//            
//            //profileMediaImages = [NSMutableArray arrayWithArray:@[@"1444476090.jpg",@"1444476149.jpg",@"1444476530.jpg",@"1444476607.jpg",@"1444477328.jpg",@"1444497136.jpg",@"1444497336.jpg"]];
//            
//            //profileImageName = @"1444627377.png";
//            
//            for (NSDictionary *media in mediaFiles)
//            {
//                if ([[media valueForKey:@"type"] isEqualToString:@"1"])
//                {
//                    
//                    
//                     [_profileMediaImages addObject:[media valueForKey:@"asset"]];
//                     
//                     if ([[media valueForKey:@"profile"] isEqualToString:@"1"])
//                     {
//                     _profileImageName = [media valueForKey:@"asset"];
//                     }
//                }
//                else
//                {
//                    [_profileMediaVideos addObject:[media valueForKey:@"asset"]];
//                }
//            }
//            
//            
//            //[self performSegueWithIdentifier:@"profile_segue" sender:self];
//            
//            aboutVC = [self.storyboard instantiateViewControllerWithIdentifier:@"about_storyboard"];
//            
//            
//            [self.containerView addSubview:aboutVC.view];
//            
//            projectVC = [self.storyboard instantiateViewControllerWithIdentifier:@"project_storyboard"];
//            projectVC.profileProjects = _profileProjects;
//            
//            photosVC = [self.storyboard instantiateViewControllerWithIdentifier:@"photos_storyboard"];
//            photosVC.profileImages = _profileMediaImages;
//            
//            videosVC = [self.storyboard instantiateViewControllerWithIdentifier:@"videos_storyboard"];
//            videosVC.profileVideos = _profileMediaVideos;
//            
//            
//            [self->_profileImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.actorsapply.com/img/blog/%@",profileImageName]] placeholderImage:nil];
//            
//        }
//        else
//        {
//            
//        }
//        
//    }];
//}

- (void) handleSwipe:(UISwipeGestureRecognizer *)swipeGesture
{
    UIView * view = [self getLastView];
    if (view.tag == 1 && swipeGesture.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        [self projectClicked:nil];
    }
    else if (view.tag == 2 && swipeGesture.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        [self photosClicked:nil];
    }
    else if (view.tag == 2 && swipeGesture.direction == UISwipeGestureRecognizerDirectionRight)
    {
        [self aboutClicked:nil];
    }
    else if (view.tag == 3 && swipeGesture.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        [self videosClicked:nil];
    }
    else if (view.tag == 3 && swipeGesture.direction == UISwipeGestureRecognizerDirectionRight)
    {
        [self projectClicked:nil];
    }
    else if (view.tag == 4 && swipeGesture.direction == UISwipeGestureRecognizerDirectionRight)
    {
        [self photosClicked:nil];
    }
}

-(UIView*) getLastView {
    NSArray *views = [self.containerView subviews];
    return views[0];
}

-(void)viewDidLayoutSubviews
{
    // The scrollview needs to know the content size for it to work correctly
    self.scrollView.contentSize = CGSizeMake(
                                             self.view.frame.size.width,
                                             1500.0
                                             );
}

- (IBAction)showMenu:(id)sender {
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    [self.frostedViewController presentMenuViewController];
}


- (IBAction)aboutClicked:(id)sender {
    self.scrollView.delegate = self;
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"about_storyboard"];
    [self deleteAllViews];
    [self.containerView addSubview:vc.view];
    [_about setTitleColor:[UIColor colorWithRed:216.0/255.0 green:79.0/255.0 blue:42.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_project setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_photos setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_videos setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

- (IBAction)projectClicked:(id)sender {
    self.scrollView.delegate = nil;
    //UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"project_storyboard"];
    [self deleteAllViews];
    [self.containerView addSubview:projectVC.view];
    [_about setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_project setTitleColor:[UIColor colorWithRed:216.0/255.0 green:79.0/255.0 blue:42.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_photos setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_videos setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

- (IBAction)photosClicked:(id)sender {
    //UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"photos_storyboard"];
    [self deleteAllViews];
    [self.containerView addSubview:photosVC.view];
    [_about setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_project setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_photos setTitleColor:[UIColor colorWithRed:216.0/255.0 green:79.0/255.0 blue:42.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_videos setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

- (IBAction)videosClicked:(id)sender {
    //UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"videos_storyboard"];
    [self deleteAllViews];
    [self.containerView addSubview:videosVC.view];
    [_about setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_project setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_photos setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_videos setTitleColor:[UIColor colorWithRed:216.0/255.0 green:79.0/255.0 blue:42.0/255.0 alpha:1.0] forState:UIControlStateNormal];
}

-(void) deleteAllViews {
    NSArray *viewsToRemove = [self.containerView subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
}
@end
