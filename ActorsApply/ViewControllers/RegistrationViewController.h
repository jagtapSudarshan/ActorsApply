//
//  RegistrationViewController.h
//  ActorsApply
//
//  Created by Sandip Mahajan on 10/21/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *actor;
@property (weak, nonatomic) IBOutlet UILabel *director;

@property (weak, nonatomic) IBOutlet UIView *firstNameView;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UIView *lastNameView;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UIView *emailIdView;
@property (weak, nonatomic) IBOutlet UITextField *emailId;
@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIView *retypePasswordView;
@property (weak, nonatomic) IBOutlet UITextField *retypePassword;

@property (weak, nonatomic) IBOutlet UILabel *dateofBirth;
@property (weak, nonatomic) IBOutlet UIButton *role_male;
@property (weak, nonatomic) IBOutlet UIButton *role_female;

@property (weak, nonatomic) IBOutlet UIView *countryView;
@property (weak, nonatomic) IBOutlet UITextField *country;
@property (weak, nonatomic) IBOutlet UIView *contactNumberView;
@property (weak, nonatomic) IBOutlet UITextField *contactNumber;
@property (weak, nonatomic) IBOutlet UIView *referenceByView;
@property (weak, nonatomic) IBOutlet UITextField *referenceBy;

@property (assign) BOOL isFblogin;
@property (strong,nonatomic) NSDictionary *fbData;


@end
