//
//  ApplicantListViewController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/20/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "ApplicantListViewController.h"
#import "ApplicantTableViewCell.h"
#import "SVProgressHUD.h"
#import "ConnectionManager.h"
#import "WebServiceConstants.h"
#import "RKDropdownAlert.h"
#import "ViewApplicant.h"
#import "ApplicantDetailsViewController.h"

@interface ApplicantListViewController ()
{
  NSMutableArray *dataArray;
  NSMutableArray *data;
  ViewApplicant *selectedApplicant;
}

@end

@implementation ApplicantListViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  [self.tabBarController.tabBar setHidden:NO];
  [self getApplicantsList];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)showMenu:(id)sender {
  // Dismiss keyboard (optional)
  //
  [self.view endEditing:YES];
  [self.frostedViewController.view endEditing:YES];
  
  // Present the view controller
  //
  [self.frostedViewController presentMenuViewController];
}

-(void)getApplicantsList
{
  [SVProgressHUD show];
  dataArray = [[NSMutableArray alloc]init];
  NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,VIEW_APPLICANT];
  
  [ConnectionManager callGetMethod:url completionBlock:^(BOOL succeeded, id responseData, NSString *errorMsg) {
    
    [SVProgressHUD dismiss];
    
    if (succeeded)
    {
      data = [responseData objectForKey:@"data"];
      NSLog(@"\n\n\nApplication list view data %@ \n\n\n",data);
      for (int i =0; i<data.count; i++) {
        NSDictionary *dict = [data objectAtIndex:i];
//      }
//      for (NSMutableDictionary *dict in data) {
        NSLog(@"\n\n\n%@",dict);
        if ([[dict objectForKey:@"id"] isEqualToString:@"48"]) {
          NSLog(@"caught");
        }
        ViewApplicant *viewApplicant = [ViewApplicant new];
        viewApplicant.viewApplicantId = [dict objectForKey:@"id"];
        viewApplicant.user_id = [dict objectForKey:@"user_id"];
        viewApplicant.name = [dict objectForKey:@"name"];
        viewApplicant.type = [dict objectForKey:@"type"];
        viewApplicant.vwAppdesc = [dict objectForKey:@"desc"];
        viewApplicant.location = [dict objectForKey:@"location"];
        viewApplicant.roleCount = [dict objectForKey:@"roleCount"];
        viewApplicant.applicationCount = [dict objectForKey:@"applicationCount"];
        viewApplicant.castingDate = [dict objectForKey:@"castingDate"];
        viewApplicant.shootingDate = [dict objectForKey:@"shootDate"];
        viewApplicant.industry = [dict objectForKey:@"industry"];
        viewApplicant.casting_director = [dict objectForKey:@"casting_director"];
        viewApplicant.director = [dict objectForKey:@"director"];
        viewApplicant.created = [dict objectForKey:@"created"];
        viewApplicant.modified = [dict objectForKey:@"modified"];
        viewApplicant.application_count = [dict objectForKey:@"application_count"];
        viewApplicant.status = [dict objectForKey:@"status"];
        viewApplicant.roles = [dict objectForKey:@"roles"];
        [dataArray addObject:viewApplicant];
      }
      dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableVw reloadData];
      });
    }
    else
    {
      [RKDropdownAlert title:@"INFORMATION" message:errorMsg];
    }
  }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  ApplicantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplicantTableViewCell"];
  ViewApplicant *vo = [dataArray objectAtIndex:indexPath.row];
  cell.lblName.text = vo.name;
  cell.lblDate.text = vo.castingDate;
  cell.lblType.text = vo.type;
  if ([vo.viewApplicantId isEqual:@"102"]) {
    NSLog(@"caught");
    NSLog(@"%@",vo.viewApplicantId);
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  ViewApplicant *vo = (ViewApplicant*)[dataArray objectAtIndex:indexPath.row];
  selectedApplicant = vo;
  [self performSegueWithIdentifier:@"ApplicantDetailsViewController" sender:nil];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if([segue.identifier isEqualToString:@"ApplicantDetailsViewController"])
  {
    ApplicantDetailsViewController *vc = segue.destinationViewController;
    vc.viewApplicant = selectedApplicant;
    
  }
}

@end
