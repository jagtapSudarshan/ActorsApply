//
//  DirectorMenuController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 10/14/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "DirectorMenuController.h"
#import "UIImageView+AFNetworking.h"
#import "WebServiceConstants.h"
#import "UIImageView+BetterFace.h"
#import "NavigationController.h"
#import "CastPostHomeViewController.h"
#import "ApplicantListViewController.h"
#import "WebViewController.h"
#import "AppDelegate.h"

@interface DirectorMenuController ()

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@end

@implementation DirectorMenuController

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
    _profileImage.layer.masksToBounds = YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NavigationController *tabBarCtrl = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    
    if (indexPath.row == 1) {
        CastPostHomeViewController *castPostHomeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CastPostHomeViewController"];
        tabBarCtrl.viewControllers = @[castPostHomeViewController];
    }
    else if (indexPath.row == 2) {
        ApplicantListViewController *applicantListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ApplicantListViewController"];
        tabBarCtrl.viewControllers = @[applicantListViewController];
    }
    else if (indexPath.row == 3) {
        
    }
    else if(indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6) {
        WebViewController *webViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
        NSString *url;
        if(indexPath.row == 4) {
            url = PRIVACY_URL;
        }
        else if(indexPath.row == 5) {
            url = TERMS_URL;
        }
        else if(indexPath.row == 6) {
            url = ABOUT_URL;
        }
        webViewController.url = url;
        tabBarCtrl.viewControllers = @[webViewController];
    }
    else if(indexPath.row == 7)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log out" message:@"Are you sure,you want to Logout?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [alert show];
    }
    
    self.frostedViewController.contentViewController = tabBarCtrl;
    [self.frostedViewController hideMenuViewController];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"authorization"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"profileImage"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"profileImageDirector"];
        
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.window setRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"signincontroller"]];
    }
}

@end
