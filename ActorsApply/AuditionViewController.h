//
//  AuditionViewController.h
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/11/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
#import "SuperViewController.h"
@interface AuditionViewController : SuperViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
