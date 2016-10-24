//
//  AddRolePostCastingTableViewCell.h
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/21/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol updateRoleFields <NSObject>

-(void)updateGender : (NSInteger) tag;

-(void)updateTextFields : (NSInteger) tag : (NSString*) text;

@end

@interface AddRolePostCastingTableViewCell : UITableViewCell<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *RoelTextField;

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIImageView *femaleIcon;

@property (weak, nonatomic) IBOutlet id<updateRoleFields> delegate;

@property (weak, nonatomic) IBOutlet UISwitch *switchAgeGroup;
@property (weak, nonatomic) IBOutlet UISwitch *switchExp;
@property (weak, nonatomic) IBOutlet UIImageView *maleIcon;
@property (weak, nonatomic) IBOutlet UITextField *roleName;

@property (weak, nonatomic) IBOutlet UITextField *desc;
@property (weak, nonatomic) IBOutlet UITextField *minAge;
@property (weak, nonatomic) IBOutlet UITextField *maxAge;
@end
