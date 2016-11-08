//
//  UpdateProjectsViewController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 11/4/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "UpdateProjectsViewController.h"
#import "ConnectionManager.h"
#import "WebServiceConstants.h"
#import "SVProgressHUD.h"
#import "RKDropdownAlert.h"

@interface UpdateProjectsViewController ()
{
    NSMutableArray *projectsData;
    __weak IBOutlet UITextField *projectName;
    __weak IBOutlet UITextField *role;
    __weak IBOutlet UITextField *description;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation UpdateProjectsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    projectsData = [[NSMutableArray alloc] init];
    projectsData = _profileProjects;
    [_tableView reloadData];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [projectsData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSDictionary *dict = [projectsData objectAtIndex:indexPath.row];
    UILabel *label = (UILabel*)[cell viewWithTag:1];
    label.text = [dict valueForKey:@"name"];
    UILabel *subTitle = (UILabel*)[cell viewWithTag:2];
    subTitle.text = [NSString stringWithFormat:@"as %@",[dict valueForKey:@"roll"]];
    UIButton *deleteBtn = (UIButton*)[cell viewWithTag:3];
    [deleteBtn addTarget:self action:@selector(deleteProject:) forControlEvents:UIControlEventTouchUpInside];
    deleteBtn.tag = [[dict valueForKey:@"id"] integerValue];
    return cell;
}

- (IBAction)backClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)deleteProject : (id) sender
{
    [SVProgressHUD show];
    
    UIButton *deleteButton = (UIButton*)sender;
    
    [ConnectionManager callDeleteMethod:[NSString stringWithFormat:@"%@%@/%ld",BASE_URL,DELETE_PROJECTS,(long)deleteButton.tag] completionBlock:^(BOOL succeeded, id responseData, NSString *errorMsg) {
        [SVProgressHUD dismiss];
        
        if (succeeded) {
            [self.navigationController popViewControllerAnimated:YES];
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *path = [documentsDirectory stringByAppendingPathComponent:@"loginUserData.plist"];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            
            NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
            
            if ([fileManager fileExistsAtPath: path]) {
                data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
            } else {
                // If the file doesn’t exist, create an empty dictionary
                data = [[NSMutableDictionary alloc] init];
            }
            
            for (int cnt = 0; cnt < [projectsData count]; cnt++) {
                if([[[projectsData objectAtIndex:cnt] valueForKey:@"id"] integerValue] == deleteButton.tag)
                {
                    [projectsData removeObjectAtIndex:cnt];
                    [_tableView reloadData];
                }
            }
            
            [RKDropdownAlert title:@"INFORMATION" message:[responseData objectForKey:@"message"]];
        }
        else{
            [RKDropdownAlert title:@"INFORMATION" message:errorMsg];
        }
    }];
}


- (IBAction)saveClicked:(id)sender {
    
    NSString *error = [self validateProject : projectName.text : role.text];
    if(error == nil)
    {
        [SVProgressHUD show];
        NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
        NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:projectName.text,@"name",
                              role.text,@"roll",
                              description.text,@"desc",
                              userId,@"id",nil];
        
        NSMutableArray *requestData = [NSMutableArray new];
        [requestData addObject:data];
        
        [ConnectionManager callPutProjectMethod:[NSString stringWithFormat:@"%@%@",BASE_URL,UPDATE_PROJECTS] Data:data completionBlock:^(BOOL succeeded, id responseData, NSString *errorMsg) {
            
            [SVProgressHUD dismiss];
            
            if (succeeded) {
                [self.navigationController popViewControllerAnimated:YES];
                
                [RKDropdownAlert title:@"INFORMATION" message:[responseData objectForKey:@"message"]];
            }
            else{
                [RKDropdownAlert title:@"INFORMATION" message:errorMsg];
            }
        }];
    }
    else{
      [RKDropdownAlert title:@"INFORMATION" message:error];
    }
}

- (IBAction)addProjectClciked:(id)sender {
    [self performSegueWithIdentifier:@"navToAddProject" sender:nil];
}

-(NSString*)validateProject : (NSString*) projectText : (NSString*) roleText
{
    if(projectText == nil)
        return @"Please enter project name.";
    else if(projectText == nil)
        return @"Please enter role.";
    
    return nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
