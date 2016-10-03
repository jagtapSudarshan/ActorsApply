//
//  TutorialTableViewCell.h
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/23/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tutorial.h"

@interface TutorialTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *tutorialImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblWatched;

@property (nonatomic) Tutorial *tutorial;
@end
