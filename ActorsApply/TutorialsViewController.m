//
//  TutorialsViewController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/23/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "TutorialsViewController.h"
#import "TutorialTableViewCell.h"
#import "ConnectionManager.h"
#import "SVProgressHUD.h"
#import "WebServiceConstants.h"
#import "RKDropdownAlert.h"
#import "Tutorial.h"
#import "REFrostedViewController.h"

@interface TutorialsViewController ()
{
    NSMutableArray *tutorialsArray;
}
@end

@implementation TutorialsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    tutorialsArray = [NSMutableArray new];
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self getTutorialsData];
}

- (void) getTutorialsData
{
    [SVProgressHUD show];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,TUTORIAL_LIST];
    
    NSLog(@"%@",url);
    
    [ConnectionManager callGetMethod:url completionBlock:^(BOOL succeeded, id responseData, NSString *errorMsg) {
        
        [SVProgressHUD dismiss];
        
        if (succeeded)
        {
            NSArray *tutorials = [responseData objectForKey:@"data"];
            
            for (NSDictionary *tutorialDict in tutorials)
            {
                Tutorial *tutorial = [[Tutorial alloc] init];
                
                tutorial.dateCreated = [tutorialDict valueForKey:@"created"];
                
                tutorial.tutorialID = [tutorialDict valueForKey:@"id"];
                tutorial.image = [tutorialDict valueForKey:@"image"];
                tutorial.in_rss = [tutorialDict valueForKey:@"in_rss"];
                tutorial.meta_description = [tutorialDict valueForKey:@"meta_description"];
                tutorial.meta_keywords = [tutorialDict valueForKey:@"meta_keywords"];
                tutorial.meta_title = [tutorialDict valueForKey:@"meta_title"];
                tutorial.dateModified = [tutorialDict valueForKey:@"modified"];
                tutorial.published = [tutorialDict valueForKey:@"published"];
                tutorial.slug = [tutorialDict valueForKey:@"slug"];
                tutorial.sticky = [tutorialDict valueForKey:@"sticky"];
                tutorial.summary = [tutorialDict valueForKey:@"summary"];
                tutorial.title = [tutorialDict valueForKey:@"title"];
                
                [tutorialsArray addObject:tutorial];
            }
            
        }
        else
        {
            [RKDropdownAlert title:@"INFORMATION" message:errorMsg];
        }
        
        [self->_tableView reloadData];
        
    }];
}

- (IBAction)showMenu:(id)sender {
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    [self.frostedViewController presentMenuViewController];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tutorialsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TutorialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TutorialTableViewCell"];
    
    cell.tutorial = [tutorialsArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[self performSegueWithIdentifier:@"ApplicantDetailsViewController" sender:self];
}

@end
