//
//  InboxTableViewCell.h
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/20/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Inbox.h"

@interface InboxTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblRound;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAuditions;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *auditionCall;

@property (weak, nonatomic) Inbox *inbox;

@end