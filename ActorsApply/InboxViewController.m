//
//  InboxViewController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/20/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "InboxViewController.h"
#import "InboxTableViewCell.h"
#import "ConnectionManager.h"
#import "WebServiceConstants.h"
#import "SVProgressHUD.h"
#import "RKDropdownAlert.h"
#import "Inbox.h"
#import "InboxDetailsViewController.h"

@interface InboxViewController ()
{
    NSMutableArray *inboxArray;
}
@end

@implementation InboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden = YES;
    
    inboxArray = [NSMutableArray new];
    
    [self getInboxData];
}

- (void) getInboxData
{
    [SVProgressHUD show];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,INBOX];
    
    [ConnectionManager callGetMethod:url completionBlock:^(BOOL succeeded, id responseData, NSString *errorMsg) {
        
        [SVProgressHUD dismiss];
        
        
        if (succeeded)
        {
            NSArray *inboxContents = [responseData valueForKey:@"data"];
            
            for (NSDictionary *inboxDict in inboxContents)
            {
                Inbox *inbox = [Inbox new];
                
                inbox.dateCreated = [inboxDict valueForKey:@"created"];
                inbox.desc = [inboxDict valueForKey:@"desc"];
                inbox.from = [inboxDict valueForKey:@"from"];
                inbox.from_id = [inboxDict valueForKey:@"from_id"];
                inbox.id = [inboxDict valueForKey:@"id"];
                inbox.invitation_reply = [inboxDict valueForKey:@"invitation_reply"];
                inbox.invite = [inboxDict valueForKey:@"invite"];
                inbox.is_delete = [[inboxDict valueForKey:@"is_delete"] boolValue];
                inbox.parent_id = [inboxDict valueForKey:@"parent_id"];
                inbox.project_id = [inboxDict valueForKey:@"project_id"];
                inbox.sent_delete = [inboxDict valueForKey:@"sent_delete"];
                inbox.read = [inboxDict valueForKey:@"read"];
                inbox.subject = [inboxDict valueForKey:@"subject"];
                inbox.to_id = [inboxDict valueForKey:@"to_id"];
                [inboxArray addObject:inbox];
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
    return [inboxArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InboxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InboxTableViewCell"];
    Inbox *inbox = [inboxArray objectAtIndex:indexPath.row];
    cell.lblName.text = inbox.from;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    NSDate *date = [dateFormat dateFromString:inbox.dateCreated];
    
    NSDateFormatter *dateStringFormat = [[NSDateFormatter alloc] init];
    [dateStringFormat setDateFormat:@"dd MMM"];
    [dateStringFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];

    cell.lblDate.text = [dateStringFormat stringFromDate:date];
    cell.lblDesc.text = inbox.desc;
    cell.lblAuditions.text = inbox.subject;
    //cell.lblName.text = inbox.from;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Inbox *inbox = [inboxArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"InboxDetailsViewController" sender:inbox];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"InboxDetailsViewController"])
    {
        InboxDetailsViewController *vc = segue.destinationViewController;
        vc.inbox = (Inbox*)sender;
    }
}


@end
