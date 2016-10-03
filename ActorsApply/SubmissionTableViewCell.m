//
//  SubmissionTableViewCell.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/26/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "SubmissionTableViewCell.h"

@implementation SubmissionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.userPhoto.layer.masksToBounds = YES;
    self.userPhoto.layer.cornerRadius = self.userPhoto.frame.size.width / 2;
    
    self.userPhotoContainer.layer.masksToBounds = YES;
    self.userPhotoContainer.layer.cornerRadius = self.userPhotoContainer.frame.size.width / 2;
    
    self.txtApplied.layer.borderColor = [[UIColor orangeColor] CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
