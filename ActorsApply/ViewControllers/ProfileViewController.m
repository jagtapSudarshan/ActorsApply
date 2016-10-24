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
#import "RKDropdownAlert.h"

@interface ProfileViewController ()
{
//    NSMutableArray *profileProjects;
//    NSMutableArray *profileMediaImages;
//    NSMutableArray *profileMediaVideos;
//    NSString *profileImageName;
    
    __weak IBOutlet UILabel *actorLbl;
    __weak IBOutlet UIView *shortListView;
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
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height/2)];
    NSString *roleType = [[NSUserDefaults standardUserDefaults] valueForKey:@"role"];
    if([roleType isEqualToString:@"1"])
    {
        [_profileImageView setBackgroundColor:[UIColor blackColor]];
        [_profileImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", IMAGE_URL, [[NSUserDefaults standardUserDefaults] objectForKey:@"profileImage"]]] placeholderImage:[UIImage imageNamed:@"default_user"]];
        actorLbl.text = @"ACTOR";
    }
    else
    {
        [_profileImageView setBackgroundColor:[UIColor blackColor]];
        [_profileImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", IMAGE_URL, [[NSUserDefaults standardUserDefaults] objectForKey:@"profileImageDirector"]]] placeholderImage:[UIImage imageNamed:@"default_user"]];
        actorLbl.text = _profileName;
    }
    
    self.navigationController.navigationBar.hidden = YES;
    aboutVC = [self.storyboard instantiateViewControllerWithIdentifier:@"about_storyboard"];
    [self.containerView addSubview:aboutVC.view];
    projectVC = [self.storyboard instantiateViewControllerWithIdentifier:@"project_storyboard"];
    projectVC.profileProjects = _profileProjects;
    
    photosVC = [self.storyboard instantiateViewControllerWithIdentifier:@"photos_storyboard"];
    photosVC.profileImages = _profileImages;
    
    videosVC = [self.storyboard instantiateViewControllerWithIdentifier:@"videos_storyboard"];
    videosVC.profileVideos = _profileMediaVideos;
    
//    [self->_profileImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.actorsapply.com/img/blog/%@",_profileImageName]] placeholderImage:nil];
    
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
    
    if([roleType isEqualToString:@"1"])
    {
        [shortListView setHidden:YES];
    }
    else{
        [shortListView setHidden:NO];
        shortListView.layer.borderColor = [UIColor orangeColor].CGColor;
    }
}

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

- (IBAction)shortListedCliked:(id)sender {
    [SVProgressHUD show];
    [ConnectionManager callPutMethod:[NSString stringWithFormat:@"%@%@%@",BASE_URL,SHORTLISTED,_profileId] Data:nil completionBlock:^(BOOL succeeded, id responseData, NSString *errorMsg)
    {
        [SVProgressHUD dismiss];
       if(succeeded)
       {
           [RKDropdownAlert title:@"INFORMATION" message:[responseData valueForKey:@"message"]];
       }
       else{
           [RKDropdownAlert title:@"INFORMATION" message:[responseData valueForKey:@"message"]];
       }
    }];
}

- (IBAction)selectClicked:(id)sender {

}

@end
