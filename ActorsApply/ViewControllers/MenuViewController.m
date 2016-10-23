//
//  MenuViewController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/5/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "MenuViewController.h"
#import "RKDropdownAlert.h"
#import "AppDelegate.h"
#import "WebViewController.h"
#import "RootViewController.h"
#import "ProjectViewController.h"
#import "AboutViewController.h"
#import "NavigationController.h"
#import "AuditionViewController.h"
#import <UIImageView+AFNetworking.h>
#import "TutorialsViewController.h"
#import "ProfileViewController.h"
#import "InboxViewController.h"
#import "SubmissionViewController.h"
#import "WebServiceConstants.h"
#import "UIImageView+BetterFace.h"
#import "UpgradeViewController.h"

@interface MenuViewController ()

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _name.text = [[[NSUserDefaults standardUserDefaults] objectForKey:@"Name"] uppercaseString];
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"profileImage"]);
    
    _profileImage.needsBetterFace = YES;
    _profileImage.fast = YES;
    
    [_profileImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", IMAGE_URL, [[NSUserDefaults standardUserDefaults] objectForKey:@"profileImage"]]] placeholderImage:[UIImage imageNamed:@"default_user"]];
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _profileImage.layer.cornerRadius = _profileImage.frame.size.width / 2;
    _profileImage.clipsToBounds = YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NavigationController *tabBarCtrl = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];

    if (indexPath.row == 1) {
        AuditionViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"audition"];
        tabBarCtrl.viewControllers = @[homeViewController];
      }
    else if (indexPath.row == 2) {
        SubmissionViewController *submissionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SubmissionViewController"];
         tabBarCtrl.viewControllers = @[submissionViewController];
    }
    else if (indexPath.row == 3) {
        ProfileViewController *profileViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
        tabBarCtrl.viewControllers = @[profileViewController];
    }
    else if (indexPath.row == 4) {
        InboxViewController *inboxViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"InboxViewController"];
        tabBarCtrl.viewControllers = @[inboxViewController];
    }
    else if (indexPath.row == 5) {
        TutorialsViewController *tutorialsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TutorialsViewController"];
        tabBarCtrl.viewControllers = @[tutorialsViewController];
    }
    else if (indexPath.row == 6) {
        UpgradeViewController *upgradeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UpgradeViewController"];
        tabBarCtrl.viewControllers = @[upgradeViewController];
    }
    else if(indexPath.row == 7 || indexPath.row == 8 || indexPath.row == 9) {
        WebViewController *webViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
        
        NSString *url;
        if(indexPath.row == 7) {
            url = PRIVACY_URL;
        }
        else if(indexPath.row == 8) {
            url = TERMS_URL;
        }
        else if(indexPath.row == 9) {
            url = ABOUT_URL;
        }
        webViewController.url = url;
        tabBarCtrl.viewControllers = @[webViewController];
    }
    else if(indexPath.row == 10) {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log out" message:@"Are you sure,you want to Logout?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
      [alert show];
    }
    else {
        [RKDropdownAlert title:@"INFORMATION" message:@"Not Implemented"];
    }
    
    self.frostedViewController.contentViewController = tabBarCtrl;
    [self.frostedViewController hideMenuViewController];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  [self.view.window setRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"signincontroller"]];
}


@end
