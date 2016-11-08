//
//  SubmissionViewController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/5/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "SubmissionViewController.h"
#import "SubmissionTableViewCell.h"
#import "ConnectionManager.h"
#import "WebServiceConstants.h"
#import "RKDropdownAlert.h"
#import "SubmissionRole.h"
#import "SVProgressHUD.h"

@interface SubmissionViewController ()
{
    __weak IBOutlet UILabel *submissionName;
    __weak IBOutlet UILabel *type;
    __weak IBOutlet UIImageView *typeImageView;
    __weak IBOutlet UILabel *castingDate;
    __weak IBOutlet UILabel *castingDirector;
    __weak IBOutlet UILabel *location;
    __weak IBOutlet UILabel *desc;
    __weak IBOutlet UILabel *castIngDateName;
    __weak IBOutlet UILabel *castIngDirectorName;
    __weak IBOutlet UILabel *locationName;
    __weak IBOutlet UILabel *sescName;
    __weak IBOutlet UILabel *hMidLine;
    __weak IBOutlet UILabel *vMideLine;
    NSMutableArray *submissionRoles;
    __weak IBOutlet UILabel *vTwoMideLine;
}

@end

@implementation SubmissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:YES];
    submissionRoles = [NSMutableArray new];
    submissionName.text = [[NSString stringWithFormat:@"%@ (%@ ROLE)",_submissionVO.name,_submissionVO.roleCount] uppercaseString];
    submissionName.numberOfLines = 0;
    submissionName.lineBreakMode = UILineBreakModeWordWrap;
    NSInteger typeCat = [_submissionVO.type integerValue] + 1;
    type.text = [self castingType:typeCat];
    [typeImageView setImage:[UIImage imageNamed:[self getImageFromType:typeCat]]];
    
    location.text = _submissionVO.location;
    desc.text = _submissionVO.desc;
    castingDate.text = _submissionVO.date;
    castingDirector.text = _submissionVO.director;
    //castIngDateName.text = _submissionVO.date;
    //castIngDirectorName.text = _submissionVO.director;
    //locationName.text = _submissionVO.location;
    //sescName.text = _submissionVO.desc;
    desc.numberOfLines = 0;
    desc.lineBreakMode = UILineBreakModeWordWrap;
}

- (IBAction)showMenu
{
    // Dismiss keyboard (optional)
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_submissionVO.roles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SubmissionTableViewCell";
    SubmissionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.lblCharName.text = [[_submissionVO.roles objectAtIndex:indexPath.row] valueForKey:@"name"];
    
    UILabel *roleName = (UILabel*)[cell viewWithTag:1];
    roleName.text = [[_submissionVO.roles objectAtIndex:indexPath.row] valueForKey:@"name"];
    
    if([[[_submissionVO.roles objectAtIndex:indexPath.row] valueForKey:@"gender"] integerValue] == 1)
    {
        cell.lblGender.text = @"Male";
    }
    else{
        cell.lblGender.text = @"Female";
    }
    
    cell.lblAgeRange.text = [NSString stringWithFormat:@"%@-%@",[[_submissionVO.roles objectAtIndex:indexPath.row] valueForKey:@"minAge"],[[_submissionVO.roles objectAtIndex:indexPath.row] valueForKey:@"maxAge"]];
    cell.lblDesc.text = [[_submissionVO.roles objectAtIndex:indexPath.row] valueForKey:@"desc"];
    cell.lblDesc.numberOfLines = 0;
    cell.lblDesc.lineBreakMode = UILineBreakModeWordWrap;

    return cell;
}

@end
