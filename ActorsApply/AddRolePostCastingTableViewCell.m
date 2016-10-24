//
//  AddRolePostCastingTableViewCell.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/21/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "AddRolePostCastingTableViewCell.h"

@implementation AddRolePostCastingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   
    UITapGestureRecognizer *maleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectGender:)];
    _maleIcon.userInteractionEnabled = YES;
    maleTap.view.tag = 1;
    [_maleIcon addGestureRecognizer:maleTap];
    
    UITapGestureRecognizer *femaleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectGender:)];
    _femaleIcon.userInteractionEnabled = YES;
    femaleTap.view.tag = 2;
    [_femaleIcon addGestureRecognizer:femaleTap];
}

-(void) selectGender : (UITapGestureRecognizer*) gesture
{
    [self.delegate updateGender : gesture.view.tag];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if(textField.tag == 1)
        [self.delegate updateTextFields:textField.tag : _minAge.text];
    if(textField.tag == 2)
        [self.delegate updateTextFields:textField.tag : _maxAge.text];
    if(textField.tag == 3)
        [self.delegate updateTextFields:textField.tag : _desc.text];
    if(textField.tag == 4)
        [self.delegate updateTextFields:textField.tag : _RoelTextField.text];

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}


@end
