//
//  LaunchViewController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/5/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "LaunchViewController.h"
#import "HomeViewController.h"
#import "NavigationController.h"
#import "MenuViewController.h"
#import "MFSideMenu.h"

@interface LaunchViewController ()
{
    NSMutableArray *textArr;
    NSMutableArray *imgNameArr;
    NSMutableArray *identifierNameArr;
}

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    textArr=[[NSMutableArray alloc]initWithObjects:@"Audition",@"Submission",@"Profile",@"Inbox",@"Tutorial", nil];
    imgNameArr=[[NSMutableArray alloc]initWithObjects:@"Audition",@"Submission",@"Profile",@"Inbox",@"Tutorial", nil];
    identifierNameArr=[[NSMutableArray alloc]initWithObjects:@"Audition",@"Submission",@"Profile",@"Inbox",@"Tutorial", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)auditionClicked:(id)sender {
    
   
}

- (IBAction)castingClicked:(id)sender
{
     [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"role"];
     [self performSegueWithIdentifier:@"navToTab" sender:[NSNumber numberWithBool:NO]];
}

#pragma mark -- MFSide menu

- (HomeViewController *)homerController {
    return [self.storyboard instantiateViewControllerWithIdentifier:@"Home"];
}

- (UINavigationController *)navigationController {
    return [[UINavigationController alloc]
            initWithRootViewController:[self homerController]];
}



@end
