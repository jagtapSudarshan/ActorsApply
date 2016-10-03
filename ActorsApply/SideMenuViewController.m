//
//  SideMenuViewController.m
//  Massma
//
//  Created by Bhushan Shivaji Mahajan on 05/02/16.
//  Copyright © 2016 Bhushan Shivaji Mahajan. All rights reserved.
//

#import "SideMenuViewController.h"
#import "MFSideMenu.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface SideMenuViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *imageParentView;
@end

@implementation SideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    textArr=[[NSMutableArray alloc]initWithObjects:@"Update Your KYC",@"My Inbox",@"Add Product",@"Suggestion Corner",@"Notices",@"Massma Notices",@"Rules & Regulations",@"Massma Magazines",@"Offers",@"Post Requirements",@"Technical Data", nil];
    imgNameArr=[[NSMutableArray alloc]initWithObjects:@"edit",@"mail",@"add_product",@"feed_back",@"notice",@"notice",@"calender",@"icon_magazine",@"offers_icon",@"post_icon",@"technical_icon", nil];
    identifierNameArr=[[NSMutableArray alloc]initWithObjects:@"KYC",@"inbox",@"Product",@"Suggestion",@"Notices",@"MassmaNotices",@"Rules",@"Magazines" ,@"Offers" ,@"Post", @"Technical", nil];
    //identifierNameArr=[[NSMutableArray alloc]initWithObjects:@"Home",@"editPic",@"Home",@"Home",@"Home","LogOut",nil];
    selectedIndex=0;
    imgPic.layer.cornerRadius=40.f;
    imgPic.layer.masksToBounds=YES;
    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
    self.homeVc=[navigationController.viewControllers objectAtIndex:0];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    [imgPic setUserInteractionEnabled:YES];
    [imgPic addGestureRecognizer:singleTap];
    imgPic.layer.cornerRadius = 55.0f;
    
    //[self.imageView setImage:[UIImage imageNamed:@"koala_"]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navToRootController) name:@"Root" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeImage) name:@"ChangeImage" object:nil];

}

-(void)viewWillAppear:(BOOL)animated
{
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",IMAGE_BASE_URL,[[NSUserDefaults standardUserDefaults] objectForKey:@"logoImage"],@".png"]];
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    UIImage *img = [[UIImage alloc] initWithData:data];
//    imgPic.image = img;
    [self changeImage];
}

-(void)changeImage
{
    NSString *imgName=[[NSUserDefaults standardUserDefaults]valueForKey:@"company_logo"];
    [imgPic setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",BASE_URL,COMPANY_LOGO_PATH,imgName]] placeholderImage:imgPic.image];
}

-(void)tapDetected
{
    ChnageLogoViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ChangeLogo"];
    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
    NSArray *controllers = [NSArray arrayWithObjects:[navigationController.viewControllers objectAtIndex:0],vc,nil];
    navigationController.viewControllers = controllers;
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
}

-(void) navToRootController
{
	
	[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLogin"];

    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - UITableViewDataSource
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [textArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [(UILabel *) [cell viewWithTag:1] setText:[textArr objectAtIndex:indexPath.row]];
    UIImageView *img=[cell viewWithTag:2];
    
   //  UIImage *icon = [UIImage imageWithIcon:[imgNameArr objectAtIndex:indexPath.row] backgroundColor:[UIColor whiteColor] iconColor:[UIColor colorWithRed:34.f/255.f green:140.f/255.f blue:245.f/255.f alpha:1.f] fontSize:50];
    [img setImage:[UIImage imageNamed:[imgNameArr objectAtIndex:indexPath.row]]];
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifer=[identifierNameArr objectAtIndex:indexPath.row];
    if ([identifer isEqualToString:@"KYC"]) {
        
        UpdateKYCViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"KYC"];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObjects:[navigationController.viewControllers objectAtIndex:0],vc,nil];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }
    else if ([identifer isEqualToString:@"Product"]) {
        AddProductViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"Product"];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObjects:[navigationController.viewControllers objectAtIndex:0],vc,nil];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }
    else if ([identifer isEqualToString:@"Suggestion"]) {
        AddProductViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"Suggestion"];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObjects:[navigationController.viewControllers objectAtIndex:0],vc,nil];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }
    else if ([identifer isEqualToString:@"Notices"]) {
        WebviewViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"webView"];
        vc.identifier = notice;
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObjects:[navigationController.viewControllers objectAtIndex:0],vc,nil];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }
    else if ([identifer isEqualToString:@"Rules"]) {
        WebviewViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"webView"];
        vc.identifier = rules;
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObjects:[navigationController.viewControllers objectAtIndex:0],vc,nil];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }
    else if ([identifer isEqualToString:@"Magazines"]) {
        WebviewViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"webView"];
        vc.identifier = magzine;
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObjects:[navigationController.viewControllers objectAtIndex:0],vc,nil];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }
    else if ([identifer isEqualToString:@"Offers"]) {
        OffersViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"offers"];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObjects:[navigationController.viewControllers objectAtIndex:0],vc,nil];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }
    else if ([identifer isEqualToString:@"Post"]) {
        POSTViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"post"];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObjects:[navigationController.viewControllers objectAtIndex:0],vc,nil];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }
    else if ([identifer isEqualToString:@"Technical"]) {
        TechnicalDataViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"technical"];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObjects:[navigationController.viewControllers objectAtIndex:0],vc,nil];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }
	else if ([identifer isEqualToString:@"MassmaNotices"]) {
		MassmaNoticesViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"GoToMassmaNotice"];
		UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
		NSArray *controllers = [NSArray arrayWithObjects:[navigationController.viewControllers objectAtIndex:0],vc,nil];
		navigationController.viewControllers = controllers;
		[self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
	}
	else if ([identifer isEqualToString:@"inbox"]) {
		InboxViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"GoToInbox"];
		UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
		NSArray *controllers = [NSArray arrayWithObjects:[navigationController.viewControllers objectAtIndex:0],vc,nil];
		navigationController.viewControllers = controllers;
		[self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
	}
    else
    {
        /// UIViewController *demoViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifer];
        
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
        selectedIndex=(int)indexPath.row;
        [tbl reloadData];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:self.homeVc];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
        
    }
}

@end
