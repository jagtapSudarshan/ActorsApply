//
//  SubmissionTableViewCell.h
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/26/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubmissionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *userPhotoContainer;
@property (weak, nonatomic) IBOutlet UIImageView *userPhoto;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UILabel *lblCharName;
@property (weak, nonatomic) IBOutlet UILabel *lblGender;
@property (weak, nonatomic) IBOutlet UILabel *lblPaid;
@property (weak, nonatomic) IBOutlet UILabel *lblAgeRange;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;

@property (weak, nonatomic) IBOutlet UITextField *txtApplied;

@end
