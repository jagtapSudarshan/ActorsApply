//
//  InboxDetailsViewController.h
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/20/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Inbox.h"
#import "SuperViewController.h"
@interface InboxDetailsViewController : SuperViewController

@property(strong,nonatomic)Inbox *inbox;

@property (weak, nonatomic) IBOutlet UILabel *fromLbl;
@property (weak, nonatomic) IBOutlet UILabel *toLbl;
@property (weak, nonatomic) IBOutlet UILabel *subjectLbl;
@property (weak, nonatomic) IBOutlet UILabel *descLbl;

@end
