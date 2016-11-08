//
//  HomeViewController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/5/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "HomeViewController.h"
#import "SVProgressHUD.h"
#import "ConnectionManager.h"
#import "WebServiceConstants.h"
#import "AboutViewController.h"
#import "ProjectViewController.h"
#import "PhotosViewController.h"
#import "VideosViewController.h"
#import "ProfileViewController.h"
#import <UIImageView+AFNetworking.h>
#import "RKDropdownAlert.h"
#import "RootViewController.h"
#import "SWRevealViewController.h"
#import "AuditionViewController.h"
#import "CastPostHomeViewController.h"
#import "ApplicantListViewController.h"
#import "UpdateProfileViewController.h"

@interface HomeViewController ()
{
    NSMutableArray *profileMediaImages;
    NSMutableArray *profileMediaVideos;
    NSString *profileImageName;
    NSMutableArray *profileProjects;
    
    AboutViewController   *aboutVC;
    ProjectViewController *projectVC;
    PhotosViewController  *photosVC;
    VideosViewController  *videosVC;
    
    __weak IBOutlet UIButton *viewApplicantBtn;
    __weak IBOutlet UILabel *viewApplicantLabel;
    __weak IBOutlet UIButton *postCostingBtn;
    __weak IBOutlet UILabel *postCastingLabel;
    __weak IBOutlet UILabel *roleLabel;
    __weak IBOutlet UIView *lineView;
    __weak IBOutlet UIImageView *profileImageView;
    __weak IBOutlet UILabel *name;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString* role = [[NSUserDefaults standardUserDefaults] valueForKey:@"role"];
    
    name.text = [[[NSUserDefaults standardUserDefaults] objectForKey:@"Name"] uppercaseString];
    if([role isEqualToString:@"1"])
    {
        lineView.hidden = YES;
        //[viewApplicantLabel sizeToFit];
        //[postCastingLabel sizeToFit];
        NSLog(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"profileImage"]);
        [profileImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[[NSUserDefaults standardUserDefaults] objectForKey:@"profileImage"]]] placeholderImage:nil];
        // [profileImageView setImage:[UIImage imageNamed:@""]];
        [postCostingBtn setBackgroundImage:[UIImage imageNamed:@"auditions"] forState:0];
        [viewApplicantBtn setBackgroundImage:[UIImage imageNamed:@"profile"] forState:0];
        postCastingLabel.text = @"AUDITIONS";
        viewApplicantLabel.text = @"PROFILE";
        roleLabel.text = @"ACTOR";
        
        [postCastingLabel setFont:[UIFont fontWithName:@"Helvetica-Regular" size:17]];
        [viewApplicantLabel setFont:[UIFont fontWithName:@"Helvetica-Regular" size:17]];
    }
    else{
        lineView.hidden = NO;
        [viewApplicantLabel sizeToFit];
        [postCastingLabel sizeToFit];
        [profileImageView setImage:[UIImage imageNamed:@"logo"]];
        profileImageView.contentMode = UIViewContentModeScaleAspectFit;
        profileImageView.contentMode = UIViewContentModeCenter;
        [postCostingBtn setBackgroundImage:[UIImage imageNamed:@"Asset 3"] forState:0];
        [viewApplicantBtn setBackgroundImage:[UIImage imageNamed:@"Asset 4"] forState:0];
        viewApplicantLabel.hidden = YES;
        postCastingLabel.hidden = YES;
        roleLabel.text = @"CASTING DIRECTOR";
        [postCastingLabel setFont:[UIFont fontWithName:@"Helvetica-Regular" size:15]];
        [viewApplicantLabel setFont:[UIFont fontWithName:@"Helvetica-Regular" size:15]];
    }
    
    profileProjects =[[NSMutableArray alloc] init];
    profileMediaImages =[[NSMutableArray alloc] init];
    profileMediaVideos =[[NSMutableArray alloc] init];
    
    if([role isEqualToString:@"1"])
    {
        [self callGetProfileData];
    }
}

-(void)viewDidLayoutSubviews
{
    [self.navigationController.navigationBar setHidden:YES];
}

- (IBAction)profileClick:(id)sender
{
    NSString* role = [[NSUserDefaults standardUserDefaults] valueForKey:@"role"];
    
    if([role isEqualToString:@"1"])
    {
        [self performSegueWithIdentifier:@"profile_segue" sender:self];
      
//      SWRevealViewController *revealController = self.revealViewController;
//      ProfileViewController *profilViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
//      UIViewController *newFrontController = profilViewController;
//      UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newFrontController];
//      [revealController pushFrontViewController:navigationController animated:YES];
    }
    else
    {
//        self.hidesBottomBarWhenPushed = NO;
        [self performSegueWithIdentifier:@"ApplicantListViewController" sender:self];
      
//      SWRevealViewController *revealController = self.revealViewController;
//      ApplicantListViewController *appListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ApplicantListViewController"];
//      UIViewController *newFrontController = appListViewController;
//      UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newFrontController];
//      [revealController pushFrontViewController:navigationController animated:YES];
    }
}

- (IBAction)auditionClick:(id)sender
{
    NSString* role = [[NSUserDefaults standardUserDefaults] valueForKey:@"role"];
    
    if([role isEqualToString:@"1"])
    {
         [self performSegueWithIdentifier:@"AuditionViewController" sender:self];
//      SWRevealViewController *revealController = self.revealViewController;
//      AuditionViewController *auditionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"audition"];
//       UIViewController *newFrontController = auditionViewController;
//      UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newFrontController];
//      [revealController pushFrontViewController:navigationController animated:YES];
    }
    else
    {
//        self.hidesBottomBarWhenPushed = NO;
     [self performSegueWithIdentifier:@"navToCast" sender:self];      
//      SWRevealViewController *revealController = self.revealViewController;
//      CastPostHomeViewController *castPostViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CastPostHomeViewController"];
//      UIViewController *newFrontController = castPostViewController;
//      UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newFrontController];
//      [revealController pushFrontViewController:navigationController animated:YES];
    }
}

- (void) callGetProfileData
{
    [SVProgressHUD show];
    
    NSString *profileUrl = [NSString stringWithFormat:@"%@%@%@",BASE_URL,PROFILE,[[NSUserDefaults standardUserDefaults] objectForKey:@"id"]];
    
    [ConnectionManager callGetMethod:profileUrl completionBlock:^(BOOL succeeded, id responseData, NSString *errorMsg) {
        
        [SVProgressHUD dismiss];
        
        if (succeeded)
        {
            NSArray *projects = [[responseData objectForKey:@"data"] objectForKey:@"projects"];
            
            for (NSDictionary *project in projects)
            {
                NSMutableDictionary *projectDict = [NSMutableDictionary new];
                
                [projectDict setValue:[project valueForKey:@"name"] forKey:@"name"];
                [projectDict setValue:[project valueForKey:@"modified"] forKey:@"modified"];
                [projectDict setValue:[project valueForKey:@"director"] forKey:@"director"];
                [projectDict setValue:[project valueForKey:@"roll"] forKey:@"roll"];
                [projectDict setValue:[project valueForKey:@"id"] forKey:@"id"];
                
                if(![profileProjects containsObject:projectDict])
                    [profileProjects addObject:projectDict];
            }
            
            NSArray *mediaFiles = [[responseData objectForKey:@"data"] objectForKey:@"media"];
            
            //profileMediaImages = [NSMutableArray arrayWithArray:@[@"1444476090.jpg",@"1444476149.jpg",@"1444476530.jpg",@"1444476607.jpg",@"1444477328.jpg",@"1444497136.jpg",@"1444497336.jpg"]];
            
            //profileImageName = @"1444627377.png";
            
            for (NSDictionary *media in mediaFiles)
            {
                if ([[media valueForKey:@"type"] isEqualToString:@"1"])
                {
                    if(![profileMediaImages containsObject:[media valueForKey:@"asset"]])
                        [profileMediaImages addObject:[media valueForKey:@"asset"]];
                    if ([[media valueForKey:@"profile"] isEqualToString:@"1"])
                    {
                        profileImageName = [media valueForKey:@"asset"];
                        [[NSUserDefaults standardUserDefaults] setObject:[media valueForKey:@"asset"] forKey:@"profileImage"];
                        [profileImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", IMAGE_URL, [[NSUserDefaults standardUserDefaults] objectForKey:@"profileImage"]]] placeholderImage:[UIImage imageNamed:@"default_user"]];
                         [[NSUserDefaults standardUserDefaults] setObject:[media valueForKey:@"asset"] forKey:@"profileImageDirector"];
                         profileImageView.contentMode = UIViewContentModeScaleToFill;
                    }
                }
                else
                {
                    if(![profileMediaVideos containsObject:[media valueForKey:@"asset"]])
                        
                        [profileMediaVideos addObject:[media valueForKey:@"asset"]];
                }
            }
            
            //[self performSegueWithIdentifier:@"profile_segue" sender:self];
            
            //aboutVC = [self.storyboard instantiateViewControllerWithIdentifier:@"about_storyboard"];
            
           // [self.containerView addSubview:aboutVC.view];
            
            //projectVC = [self.storyboard instantiateViewControllerWithIdentifier:@"project_storyboard"];
            projectVC.profileProjects = profileProjects;
            
           // photosVC = [self.storyboard instantiateViewControllerWithIdentifier:@"photos_storyboard"];
            photosVC.profileImages = profileMediaImages;
            
          //  videosVC = [self.storyboard instantiateViewControllerWithIdentifier:@"videos_storyboard"];
            videosVC.profileVideos = profileMediaVideos;
            [profileImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL, profileImageName]] placeholderImage:[UIImage imageNamed:@"logo"]];
            
            if(_isFromMenu)
            {
              [self performSegueWithIdentifier:@"profile_segue" sender:self];
            }
        }
        else
        {
            [RKDropdownAlert title:@"INFORMATION" message:errorMsg];
        }
    }];
}

- (IBAction)navToEditProfile:(id)sender {
    [self performSegueWithIdentifier:@"navToEditProfile" sender:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"profile_segue"])
    {
        ProfileViewController *profileVC = segue.destinationViewController;
        
        profileVC.profileImages = profileMediaImages;
        profileVC.profileMediaVideos = profileMediaVideos;
        profileVC.profileProjects = profileProjects;
        profileVC.profileImageName = profileImageName;
        //profileVC.profileImageName = profileImageName;
    }
    else if ([segue.identifier isEqualToString:@"navToEditProfile"])
    {
        UpdateProfileViewController *profileVC = segue.destinationViewController;
        profileVC.profileImages = profileMediaImages;
        profileVC.profileMediaVideos = profileMediaVideos;
        profileVC.profileProjects = profileProjects;
    }
}

- (IBAction)leftSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
        
    }];
}


@end
