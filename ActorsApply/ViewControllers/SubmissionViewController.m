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
    //[self.tableView reloadData];
    submissionName.hidden = YES;
    type.hidden = YES;
    typeImageView.hidden = YES;
    location.hidden = YES;
    desc.hidden = YES;
    castingDate.hidden = YES;
    castingDirector.hidden = YES;
    castIngDateName.hidden = YES;
    castIngDirectorName.hidden = YES;
    locationName.hidden = YES;
    sescName.hidden = YES;
    hMidLine.hidden = YES;
    vMideLine.hidden = YES;
    vTwoMideLine.hidden = YES;
    _tableView.hidden = YES;
    
    [self getSubmission];
}

- (IBAction)showMenu
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [submissionRoles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SubmissionTableViewCell";
    
    SubmissionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    return cell;
}

-(void)getSubmission
{
    [SVProgressHUD show];
    [ConnectionManager callGetMethod:[NSString stringWithFormat:@"%@%@",BASE_URL,GET_SUBMISSSION] completionBlock:^(BOOL succeeded, id responseData, NSString *errorMsg) {
        
        [SVProgressHUD dismiss];
        
        if(succeeded)
        {
            NSMutableArray *response = [responseData valueForKey:@"data"];
            if([response count] > 0)
            {
                submissionName.hidden = NO;
                type.hidden = NO;
                typeImageView.hidden = NO;
                location.hidden = NO;
                desc.hidden = NO;
                castingDate.hidden = NO;
                castingDirector.hidden = NO;
                castIngDateName.hidden = NO;
                castIngDirectorName.hidden = NO;
                locationName.hidden = NO;
                sescName.hidden = NO;
                hMidLine.hidden = NO;
                vMideLine.hidden = NO;
                vTwoMideLine.hidden = NO;
                _tableView.hidden = NO;
                submissionName.text = [response valueForKey:@"name"];
                NSInteger typeValue = [[response valueForKey:@"type"] integerValue];
                type.text = [self castingType:typeValue];
                [typeImageView setImage:[UIImage imageNamed:[self getImageFromType:typeValue]]];
                location.text = [response valueForKey:@"location"];
                desc.text = [response valueForKey:@"desc"];
                castingDate.text = [response valueForKey:@"castingDate"];
                castingDirector.text = [response valueForKey:@"shootDate"];
                
                NSMutableArray *roles = [response valueForKey:@"roles"];
                
                for (NSDictionary *data in roles) {
                    SubmissionRole *subRole = [[SubmissionRole alloc] init];
                    subRole.characterName = [data valueForKey:@"name"];
                    subRole.gender = [data valueForKey:@"gender"];
                    subRole.ageRange = [NSString stringWithFormat:@"%@ - %@",[data valueForKey:@"minAge"],[data valueForKey:@"maxAge"]];
                    subRole.desc = [data valueForKey:@"desc"];
                    [submissionRoles addObject:subRole];
                }
                
                [_tableView reloadData];
            }
            else{
                submissionName.hidden = YES;
                type.hidden = YES;
                typeImageView.hidden = YES;
                location.hidden = YES;
                desc.hidden = YES;
                castingDate.hidden = YES;
                castingDirector.hidden = YES;
                castIngDateName.hidden = YES;
                castIngDirectorName.hidden = YES;
                locationName.hidden = YES;
                sescName.hidden = YES;
                hMidLine.hidden = YES;
                vMideLine.hidden = YES;
                vTwoMideLine.hidden = YES;
                 _tableView.hidden = YES;
                [RKDropdownAlert title:@"INFORMATION" message:@"No submissions available."];
            }
        }
        else
        {
            submissionName.hidden = YES;
            type.hidden = YES;
            typeImageView.hidden = YES;
            location.hidden = YES;
            desc.hidden = YES;
            castingDate.hidden = YES;
            castingDirector.hidden = YES;
            castIngDateName.hidden = YES;
            castIngDirectorName.hidden = YES;
            locationName.hidden = YES;
            sescName.hidden = YES;
            hMidLine.hidden = YES;
            vMideLine.hidden = YES;
            vTwoMideLine.hidden = YES;
            _tableView.hidden = YES;
            [RKDropdownAlert title:@"INFORMATION" message:errorMsg];
        }
    }];
}

@end
