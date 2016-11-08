//
//  SubmissionViewController.h
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/5/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
#import "SuperViewController.h"
#import "SubmissionVO.h"

@interface SubmissionViewController : SuperViewController<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic)SubmissionVO *submissionVO;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)showMenu;

@end
