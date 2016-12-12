//
//  SubmissionListViewController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 11/6/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "SubmissionListViewController.h"
#import "ConnectionManager.h"
#import "WebServiceConstants.h"
#import "RKDropdownAlert.h"
#import "SubmissionRole.h"
#import "SVProgressHUD.h"
#import "SubmissionVO.h"
#import "SubmissionViewController.h"

@interface SubmissionListViewController ()
{
    NSMutableArray *submissionData;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SubmissionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    submissionData = [NSMutableArray new];
    [self getSubmission];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showMenu:(id)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [submissionData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    SubmissionVO *submissionVO = [submissionData objectAtIndex:indexPath.row];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    [format setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    NSDate *date = [format dateFromString:submissionVO.date];
    [format setDateFormat:@"dd MMM yyyy"];
    
    UILabel *nameLabel = [cell viewWithTag:2];
    nameLabel.numberOfLines = 0;
    nameLabel.lineBreakMode = UILineBreakModeWordWrap;
    nameLabel.text = [[NSString stringWithFormat:@"%@ (%@ ROLE)",submissionVO.name,submissionVO.roleCount] uppercaseString];
    
    UILabel *dateLabel = [cell viewWithTag:3];
    dateLabel.text = [format stringFromDate:date];
    
    UILabel *filmLabel = [cell viewWithTag:4];
    NSInteger type = [submissionVO.type integerValue] + 1;
    if(![submissionVO.type isEqual:(id)[NSNull null]])
    {
        filmLabel.text = [self castingType:type];//audition.name;
    }
    
    UIImageView *catingTypeImage = [cell viewWithTag:1];
    if(![submissionVO.type isEqual:(id)[NSNull null]])
    {
        [catingTypeImage setImage:[UIImage imageNamed:[self getImageFromType:type]]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubmissionVO *vo = [submissionData objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"navToSubmissionDetails" sender:vo];
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
                NSMutableArray *data = [responseData objectForKey:@"data"];
                
                for (int cnt = 0; cnt < [data count]; cnt++) {
                    NSMutableDictionary *dic = [data objectAtIndex:cnt];
                    SubmissionVO *vo = [SubmissionVO new];
                    vo.name = [dic valueForKey:@"name"];
                    vo.location = [dic valueForKey:@"location"];
                    vo.director = [dic valueForKey:@"casting_director"];
                    vo.desc = [dic valueForKey:@"desc"];
                    vo.type = [dic valueForKey:@"type"];
                    vo.roles = [dic valueForKey:@"roles"];
                    vo.roleCount = [NSString stringWithFormat:@"%lu",(unsigned long)[vo.roles count]];
                    
                    if([vo.roles count] > 0)
                    {
                        vo.date = [[vo.roles objectAtIndex:0] valueForKey:@"created"];
                    }
                    
                    [submissionData addObject:vo];
                }
                [_tableView reloadData];
            }
            else{
                [RKDropdownAlert title:@"INFORMATION" message:@"No submissions available."];
            }
        }
        else
        {
            [RKDropdownAlert title:@"INFORMATION" message:errorMsg];
        }
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"navToSubmissionDetails"])
    {
        SubmissionViewController *vc = segue.destinationViewController;
        vc.submissionVO = (SubmissionVO*)sender;
    }
}


@end
