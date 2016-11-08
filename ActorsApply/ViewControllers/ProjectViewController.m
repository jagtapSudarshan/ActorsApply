//
//  ProjectViewController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/5/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "ProjectViewController.h"
#import "ProfileProjectsTableViewCell.h"

@interface ProjectViewController ()

@end

@implementation ProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self->_profileProjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileProjectsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileProjectsTableViewCell"];
    
    NSDictionary *projectDict = [self->_profileProjects objectAtIndex:indexPath.row];
    
    cell.lblName.text = [projectDict valueForKey:@"name"];
    cell.lblSub.text = [projectDict valueForKey:@"director"];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [format setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    NSDate *date = [format dateFromString:[projectDict valueForKey:@"modified"]];
    [format setDateFormat:@"dd EEE yyyy"];
    
    cell.lblDate.text =  [format stringFromDate:date];
    
    //cell.videoThumbView.image = [UIImage imageNamed:@"video_1"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
