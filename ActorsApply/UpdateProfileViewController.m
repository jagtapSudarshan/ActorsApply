//
//  UpdateProfileViewController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 11/3/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "UpdateProfileViewController.h"
#import "UpdateProjectsViewController.h"
#import "UpdateImageViewController.h"

@interface UpdateProfileViewController ()
{
      NSMutableArray *listArray;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation UpdateProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //listArray = [[NSMutableArray alloc] initWithObjects:@"About",@"Projects",@"Photos",@"Videos", nil];
    listArray = [[NSMutableArray alloc] initWithObjects:@"About", nil];
    [self.tableView reloadData];
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
    return [listArray count];
}

- (IBAction)backClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSString *name = [listArray objectAtIndex:indexPath.row];
    UILabel *label = (UILabel*)[cell viewWithTag:1];
    label.text = name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:@"navToEditAbout" sender:self];
            break;
        case 1:
            [self performSegueWithIdentifier:@"navToProjects" sender:self];
            break;
        case 2:
            [self performSegueWithIdentifier:@"navToImages" sender:self];
            break;
        case 3:
            [self performSegueWithIdentifier:@"navToVideos" sender:self];
            break;
        default:
            break;
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"navToProjects"])
    {
        UpdateProjectsViewController *vc = segue.destinationViewController;
        vc.profileProjects = _profileProjects;
    }
    else if ([segue.identifier isEqualToString:@"navToImages"])
    {
        UpdateImageViewController *vc = segue.destinationViewController;
        vc.profileImages = _profileImages;
    }
    else if ([segue.identifier isEqualToString:@"navToVideos"])
    {
        UpdateProjectsViewController *vc = segue.destinationViewController;
        vc.profileImages = _profileMediaVideos;
    }
}

@end
