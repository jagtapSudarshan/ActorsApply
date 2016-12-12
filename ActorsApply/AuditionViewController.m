//
//  AuditionViewController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/11/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "AuditionViewController.h"
#import "ConnectionManager.h"
#import "SVProgressHUD.h"
#import "WebServiceConstants.h"
#import "RKDropdownAlert.h"
#import "Audition.h"
#import "AuditionDetailsViewController.h"

@interface AuditionViewController ()
{
    NSMutableArray *auditionsList;
}
@end

@implementation AuditionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     auditionsList = [NSMutableArray new];
    
    [self.navigationController.navigationBar setHidden:YES];
    [self callGetAUDITION];
}

- (void) callGetAUDITION
{
    [SVProgressHUD show];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,AUDITION];
    
    NSLog(@"%@",url);
    
    [ConnectionManager callGetMethod:url completionBlock:^(BOOL succeeded, id responseData, NSString *errorMsg) {
        
        [SVProgressHUD dismiss];
        
        if (succeeded)
        {
            NSArray *auditions = [responseData objectForKey:@"data"];
            
            for (NSDictionary *auditionDict in auditions)
            {
                Audition *audition = [Audition new];
                
                audition.dateCreated = [auditionDict valueForKey:@"created"];
                audition.desc = [auditionDict valueForKey:@"desc"];
               
                audition.auditionID = [auditionDict valueForKey:@"id"];
                audition.location = [auditionDict valueForKey:@"location"];
                audition.maxAge = [auditionDict valueForKey:@"maxAge"];
                audition.minAge = [auditionDict valueForKey:@"minAge"];
                
                audition.name = [auditionDict valueForKey:@"name"];
                audition.project_id = [auditionDict valueForKey:@"project_id"];
                audition.status = [auditionDict valueForKey:@"status"];
                audition.type = [auditionDict valueForKey:@"type"];
                audition.role = [auditionDict valueForKey:@"roles"];
                audition.userId = [auditionDict valueForKey:@"user_id"];
                
                if([audition.role count] > 0)
                {
                   audition.dateModified = [[audition.role objectAtIndex:0] valueForKey:@"created"];
                   audition.gender = [[audition.role objectAtIndex:0] valueForKey:@"gender"];
                }
                
                [auditionsList addObject:audition];
            }
            
            [self.tableView reloadData];
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
    
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [auditionsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    Audition *audition = [auditionsList objectAtIndex:indexPath.row];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [format setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    NSDate *date = [format dateFromString:audition.dateModified];
    [format setDateFormat:@"dd MMM yyyy"];
    
    UILabel *nameLabel = [cell viewWithTag:1];
    nameLabel.text = [[NSString stringWithFormat:@"%@ (%lu ROLE)",audition.name,(unsigned long)audition.role.count] uppercaseString];
    
    UILabel *dateLabel = [cell viewWithTag:2];
    dateLabel.text = [format stringFromDate:date];
    
    UILabel *filmLabel = [cell viewWithTag:3];
    
    if(![audition.type isEqual:(id)[NSNull null]])
    {
        filmLabel.text = [self castingType:[audition.type integerValue]];//audition.name;
    }
    
    UIImageView *catingTypeImage = [cell viewWithTag:4];
    if(![audition.type isEqual:(id)[NSNull null]])
    {
        [catingTypeImage setImage:[UIImage imageNamed:[self getImageFromType:[audition.type integerValue]]]];
    }
    
//    UIImageView *verified = [cell viewWithTag:5];
//    [verified setImage:[UIImage imageNamed:@"verified.png"]];
    
    //cell.videoThumbView.image = [UIImage imageNamed:@"video_1"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Audition *audition = [auditionsList objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"AuditionDetailsViewController" sender:audition];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"AuditionDetailsViewController"])
    {
        AuditionDetailsViewController *audtionDetailsVC = segue.destinationViewController;
        audtionDetailsVC.audition = (Audition *)sender;
        
    }
    
}


@end
