//
//  TutorialTableViewCell.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/23/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "TutorialTableViewCell.h"
#import <UIImageView+AFNetworking.h>

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
     NSString *urlStr = @"http://www.actorsapply.com/app/webroot/img/photos/";
    
    [self.tutorialImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",urlStr,tutorial.image]] placeholderImage:nil];
    self.lblTitle.text = tutorial.title;
}

@end
