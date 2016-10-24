//
//  AddRolePostCastingViewController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/21/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "AddRolePostCastingViewController.h"
#import "AddRolePostCastingTableViewCell.h"
#import "RolePostCast.h"
#import "ConnectionManager.h"
#import "SVProgressHUD.h"
#import "WebServiceConstants.h"
#import "RKDropdownAlert.h"

@interface AddRolePostCastingViewController ()<updateRoleFields>
{
  __weak IBOutlet UILabel *type;
  NSMutableArray *roles;
  __weak IBOutlet UILabel *projectName;
  __weak IBOutlet UIImageView *selecteTypeImage;
  NSInteger genderType;
  NSString* minAge;
  NSString* maxAge;
  NSString* description;
  RolePostCast *rolePost;
  NSMutableArray *roleArray;
}

@end

@implementation AddRolePostCastingViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  roles = [NSMutableArray new];
  roleArray = [NSMutableArray new];
  
  projectName.text = [_data objectForKey:@"name"];
  selecteTypeImage.image = [UIImage imageNamed:[_data objectForKey:@"image"]];
  type.text = [_data objectForKey:@"selectedTypeName"];
  
  rolePost = [RolePostCast new];
  // Do any additional setup after loading the view.
}

- (IBAction)didSelectAdd
{
  if([roles count] == 0)
  {
    rolePost = [RolePostCast new];
    [roles addObject:rolePost];
  }
  else
  {
    NSMutableDictionary *roleData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"role 1", @"name",
                                     @"1", @"gender",
                                     [_data objectForKey:@"type"], @"type",
                                     rolePost.minAge, @"minAge",
                                     rolePost.maxAge, @"maxAge",
                                     rolePost.desc, @"desc",
                                     @"2016-09-18", @"created",
                                     [_data objectForKey:@"location"],@"location",
                                     nil];
    [roleArray addObject:roleData];
    [roles addObject:rolePost];
  }
  [self.tableView reloadData];
}

- (IBAction)backClciked:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [roles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  AddRolePostCastingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddRolePostCastingTableViewCell"];
  cell.delegate = self;
  cell.minAge.tag = 1;
  cell.maxAge.tag = 2;
  cell.desc.tag = 3;
  cell.roleName.tag = 4;
  return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  //[self performSegueWithIdentifier:@"ApplicantDetailsViewController" sender:self];
}

#pragma mark - Get role data cell data.

-(void)updateGender : (NSInteger) tag;
{
  rolePost.gender = tag;
}

-(void)updateTextFields : (NSInteger) tag : (NSString*) text
{
  if(tag == 1)
    rolePost.minAge = text;
  if(tag == 2)
    rolePost.maxAge = text;
  if(tag == 3)
    rolePost.desc = text;
   if(tag == 4)
    rolePost.name = text;
}

- (IBAction)postCastingClicked:(id)sender {
    
    if(rolePost.name.length == 0)
    {
        [RKDropdownAlert title:@"INFORMATION" message:@"Please enter role name"];
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@"0" forKey:@"applicationCount"];
    [params setValue:[self.data valueForKey:@"castingDate"] forKey:@"castingDate"];
    [params setValue:[self.data valueForKey:@"casting_director"] forKey:@"casting_director"];
    [params setValue:@" " forKey:@"created"];
    NSString *desc = [self.data valueForKey:@"desc"];
    if (desc.length==0) {
        desc = @" ";
    }
    [params setValue:desc forKey:@"desc"];
    [params setValue:[self.data valueForKey:@"director"] forKey:@"director"];
    NSString *iddesc = [self.data valueForKey:@"id"];
    if (iddesc.length==0) {
        iddesc = @" ";
    }
    [params setValue:iddesc forKey:@"id"];
    [params setValue:@"0" forKey:@"industry"];
    [params setValue:[self.data valueForKey:@"location"] forKey:@"location"];
    NSString *modifieddesc = [self.data valueForKey:@"modified"];
    if (modifieddesc.length==0) {
        modifieddesc = @" ";
    }
    [params setValue:modifieddesc forKey:@"modified"];
    [params setValue:[self.data valueForKey:@"name"] forKey:@"name"];
    [params setValue:[self.data valueForKey:@"shootDate"] forKey:@"shootDate"];
    [params setValue:[self.data valueForKey:@"status"] forKey:@"status"];
    [params setValue:[self.data valueForKey:@"type"] forKey:@"type"];
    [params setValue:[self.data valueForKey:@"user_id"] forKey:@"user_id"];
    NSString *cont = [NSString stringWithFormat:@"%lu",(unsigned long)roles.count];
    [params setValue:cont forKey:@"roleCount"];
    
    NSMutableArray *paramsRolesArray = [[NSMutableArray alloc]init];
    for (int i =0; i<roles.count; i++) {
        RolePostCast *rp = (RolePostCast*)[roles objectAtIndex:i];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setValue:@" " forKey:@"created"];
        [dict setValue:rp.desc forKey:@"desc"];
        if (rp.gender) {
            [dict setValue:@"1" forKey:@"gender"];
        }else{
            [dict setValue:@"0" forKey:@"gender"];
        }
        [dict setValue:[self.data valueForKey:@"location"] forKey:@"location"];
        [dict setValue:rp.maxAge forKey:@"maxAge"];
        [dict setValue:rp.minAge forKey:@"minAge"];
        [dict setValue:modifieddesc forKey:@"modified"];
        [dict setValue:rolePost.name forKey:@"name"];
        [dict setValue:[self.data valueForKey:@"status"] forKey:@"status"];
        [dict setValue:[self.data valueForKey:@"type"] forKey:@"type"];
        [paramsRolesArray addObject:dict];
    }
    [params setValue:paramsRolesArray forKey:@"roles"];
    
    [SVProgressHUD show];
    
    [ConnectionManager callPostMethod:[NSString stringWithFormat:@"%@%@",BASE_URL,CASTING_POST] Data:params completionBlock:^(BOOL succeeded, id responseData, NSString *errorMsg) {
        
        [SVProgressHUD dismiss];
        
        if(succeeded)
        {
            [RKDropdownAlert title:@"INFORMATION" message:[responseData valueForKey:@"message"]];
            [self tab2Selected:nil];
        }
        else{
            
            [RKDropdownAlert title:@"INFORMATION" message:errorMsg];
        }
    }];
}

@end
