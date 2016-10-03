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

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        UITableViewCell *cell  = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        
        UILabel *lblName12 = [cell.contentView viewWithTag:1];
        UILabel *lblEmail = [cell viewWithTag:2];
        UIImageView *imageView = [cell viewWithTag:3];
        
        imageView.layer.cornerRadius = imageView.frame.size.width/2;
        
        NSString *urlStr = @"http://www.actorsapply.com/img/blog/";
        
        [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",urlStr,[[NSUserDefaults standardUserDefaults] objectForKey:@"profileImage"]]] placeholderImage:[UIImage imageNamed:@"default_user"]];
        
        lblName12.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"Name"];
        
        lblEmail.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"emailId"];
        
        return cell;
    }
    else
    {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [self.frostedViewController hideMenuViewController];
//    index = indexPath.row;
//    if(indexPath.row == 11) {
//        // Handle logout
//        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"rootController"];
//        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//        delegate.window.rootViewController = vc;
//    }
//    else if(indexPath.row == 8 || indexPath.row == 9 || indexPath.row == 10) {
//        [self performSegueWithIdentifier:@"web_segue" sender:self];
//    }
//    else
//    {
//        [RKDropdownAlert title:@"INFORMATION" message:@"Not Implemented"];
//       // self.frostedViewController.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"about_storyboard"];
//    }
    
//    UITableViewCell *cell  = [super tableView:tableView cellForRowAtIndexPath:indexPath];
//    [cell.contentView setBackgroundColor:[UIColor colorWithRed:215/255 green:80/255 blue:43/255 alpha:1.0]];
    
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
    else {
        [RKDropdownAlert title:@"INFORMATION" message:@"Not Implemented"];
    }
    
    self.frostedViewController.contentViewController = tabBarCtrl;
    [self.frostedViewController hideMenuViewController];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *url;
    if(index == 8) {
        url = @"http://shraddhakapoor.blogspot.in/";
    }
    else if(index == 9) {
        url = @"http://shraddhakapoor.blogspot.in/p/filmography.html";
    }
    else if(index == 10) {
        url = @"http://shraddhakapoor.blogspot.in/p/about.html";
    }
    WebViewController *vc = segue.destinationViewController;
    vc.url = url;
}

@end
