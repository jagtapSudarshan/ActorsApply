//
//  SideMenuViewController.m
//  MFSideMenuDemo
//
//  Created by Michael Frederick on 3/19/12.

#import "SideMenuViewController.h"
#import "MFSideMenu.h"
#import "AuditionViewController.h"
#import "ProfileViewController.h"
#import "SubmissionViewController.h"
#import "TutorialsViewController.h"
#import "RKDropdownAlert.h"
#import "HomeViewController.h"
#import "InboxViewController.h"
#import "UIImageView+AFNetworking.h"
#import "SubmissionListViewController.h"
#import "SWRevealViewController.h"
#import "HomeViewController.h"


@implementation SideMenuViewController
{
    NSMutableArray *textArr;
    NSMutableArray *imgNameArr;
    NSMutableArray *identifierNameArr;
    __weak IBOutlet UITableView *tableView;
    __weak IBOutlet UIImageView *imgPic;
    __weak IBOutlet UILabel *email;
    __weak IBOutlet UILabel *name;
    NSInteger selecteTab;
  NSInteger _presentedRow;
}

#pragma mark -
#pragma mark - UITableViewDataSource

-(void)viewDidLoad
{
    [super viewDidLoad];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    NSString *roleType = [[NSUserDefaults standardUserDefaults] valueForKey:@"role"];
    if([roleType isEqualToString:@"1"])
    {
         textArr=[[NSMutableArray alloc]initWithObjects:@"Audition",@"Submission",@"Profile",@"Inbox",@"Tutorial",@"Logout", nil];
        imgNameArr=[[NSMutableArray alloc]initWithObjects:@"Audition",@"Submission",@"Profile",@"Inbox",@"Tutorial", nil];
        identifierNameArr=[[NSMutableArray alloc]initWithObjects:@"Audition",@"Submission",@"Profile",@"Inbox",@"Tutorial",@"Logout", nil];
    }
    else{
         textArr=[[NSMutableArray alloc]initWithObjects:@"Post Casting",@"View Applicant",@"Shortlisted",@"Privacy Policy",@"Terms of Use",@"Logout", nil];
        imgNameArr=[[NSMutableArray alloc]initWithObjects:@"Audition",@"Submission",@"Profile", nil];
        identifierNameArr=[[NSMutableArray alloc]initWithObjects:@"Post Casting",@"View Applicant",@"Shortlisted",@"Privacy Policy",@"Terms of Use",@"Logout", nil];
    }
   
    NSString *urlStr = @"http://www.actorsapply.com/img/blog/";
    [imgPic setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",urlStr,[[NSUserDefaults standardUserDefaults] objectForKey:@"profileImage"]]] placeholderImage:[UIImage imageNamed:@"default_user"]];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Section %ld", (long)section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [identifierNameArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [(UILabel *) [cell viewWithTag:1] setText:[textArr objectAtIndex:indexPath.row]];
    UIImageView *img = (UIImageView*)[cell viewWithTag:2];
    //[img setImage:[UIImage imageNamed:[imgNameArr objectAtIndex:indexPath.row]]];
    return cell;
}

//#pragma mark -
//#pragma mark - UITableViewDelegate
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    NSString *identifier = [identifierNameArr objectAtIndex:indexPath.row];
//    SubmissionViewController *submissionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SubmissionViewController"];
//    InboxViewController *inboxViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"InboxViewController"];
//    AuditionViewController *auditionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"audition"];
//    
//    if ([identifier isEqualToString:@"Audition"]) {
//        AuditionViewController *auditionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"audition"];
//        UITabBarController *tabBarController = self.menuContainerViewController.centerViewController;
//        UINavigationController *navigationController = (UINavigationController *)tabBarController.selectedViewController;
//        NSArray *controllers = [NSArray arrayWithObjects:auditionViewController,submissionViewController,inboxViewController,nil];
//        tabBarController.viewControllers = controllers;
//        //[navigationController.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"icon_2"]];
//        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
//    }
//    else if ([identifier isEqualToString:@"Submission"]) {
//        selecteTab = 0;
//        //SubmissionViewController *submissionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SubmissionViewController"];
//        UITabBarController *navigationController = self.menuContainerViewController.centerViewController;
//        NSArray *controllers = [NSArray arrayWithObjects:auditionViewController,submissionViewController,inboxViewController,nil];
//        //[navigationController.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"icon_1"]];
//        navigationController.viewControllers = controllers;
//        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
//    }
//    else if ([identifier isEqualToString:@"Profile"]) {
//        selecteTab = 1;
//        //ProfileViewController *profileViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
//        UITabBarController *navigationController = self.menuContainerViewController.centerViewController;
//        NSArray *controllers = [NSArray arrayWithObjects:submissionViewController,auditionViewController,inboxViewController,nil];
//        navigationController.viewControllers = controllers;
//        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
//    }
//    else if ([identifier isEqualToString:@"Inbox"]) {
//        selecteTab = 2;
//        InboxViewController *inboxViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"InboxViewController"];
//        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
//        NSArray *controllers = [NSArray arrayWithObjects:[navigationController.viewControllers objectAtIndex:0],inboxViewController,nil];
//        navigationController.viewControllers = controllers;
//        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
//    }
//    else if ([identifier isEqualToString:@"Tutorial"]) {
//        selecteTab = 1;
//        TutorialsViewController *tutorialsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TutorialsViewController"];
//        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
//       // [navigationController.tabBarController.tabBarItem setSelectedImage:[UIImage imageNamed:@"icon_1"]];
//        NSArray *controllers = [NSArray arrayWithObjects:[navigationController.viewControllers objectAtIndex:0],tutorialsViewController,nil];
//        navigationController.viewControllers = controllers;
//        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
//    }
//    else {
//        [RKDropdownAlert title:@"INFORMATION" message:@"Not Implemented"];
//    }
//    
////    HomeViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Home"];
////    UITabBarController *tabBarController = self.menuContainerViewController.centerViewController;
////    UINavigationController *navigationController = (UINavigationController *)tabBarController.selectedViewController;
////    NSArray *controllers = [NSArray arrayWithObject:homeViewController];
////    navigationController.viewControllers = controllers;
//    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  SWRevealViewController *revealController = self.revealViewController;

  NSInteger row = indexPath.row;
//  if ( row == _presentedRow )
//  {
//    [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
//    return;
//  }

  UIViewController *newFrontController = nil;
  
  if (row == 0)
  {
    AuditionViewController *auditionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"audition"];
    newFrontController = auditionViewController;
  }
  else if (row == 1)
  {
    SubmissionListViewController *submissionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SubmissionListViewController"];
    newFrontController = submissionViewController;
  }
  else if (row == 2)
  {
    ProfileViewController *profileViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    newFrontController = profileViewController;
  }
  else if (row == 3)
  {
    InboxViewController *inboxViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"InboxViewController"];
    newFrontController = inboxViewController;
  }
  else if (row == 4)
  {
    TutorialsViewController *tutorialsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TutorialsViewController"];
    newFrontController = tutorialsViewController;
  }
  
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newFrontController];
  [revealController pushFrontViewController:navigationController animated:YES];
  
  _presentedRow = row;  // <- store the presented row
}

@end
