//
//  TutorialTableViewCell.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/23/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "TutorialTableViewCell.h"
#import <UIImageView+AFNetworking.h>
#import "WebServiceConstants.h"

@implementation TutorialTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setTutorial:(Tutorial *)tutorial
{
    [self.tutorialImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", IMAGE_URL, tutorial.image]] placeholderImage:nil];
    self.lblTitle.text = tutorial.title;
}

@end
