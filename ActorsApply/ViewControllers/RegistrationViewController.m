//
//  RegistrationViewController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 10/21/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "RegistrationViewController.h"
#import "ConnectionManager.h"
#import "RKDropdownAlert.h"
#import "WebServiceConstants.h"
#import "OTPViewController.h"

@interface RegistrationViewController ()
{
    NSString *userType;
    NSDictionary *requestData;
}

@property (weak, nonatomic) IBOutlet UIView *pickeParentView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBorder:_firstNameView];
    [self setBorder:_lastNameView];
    [self setBorder:_emailIdView];
    [self setBorder:_passwordView];
    [self setBorder:_retypePasswordView];
    [self setBorder:_countryView];
    [self setBorder:_contactNumberView];
    [self setBorder:_referenceByView];
    _role_male.selected = YES;
    userType = @"1";
  
  _pickeParentView.hidden = YES;
  
  UIToolbar *toolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,44)];
  toolbar.barStyle = UIBarStyleDefault;
  UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
  UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(pickerChanged:)];
  [toolbar setItems:[NSArray arrayWithObjects:flexibleSpaceLeft, doneButton, nil]];
  [_pickeParentView addSubview:toolbar];
  _datePicker.minimumDate = [NSDate date];
}

- (void) setBorder : (UIView*) view{
    view.layer.borderColor = [UIColor darkGrayColor].CGColor;
    view.layer.borderWidth = 1.0f;
    view.layer.borderColor = [UIColor darkGrayColor].CGColor;
}

- (void)pickerChanged:(id)sender
{
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"yyyy-MM-dd"];
  NSString *convertedDateString = [dateFormatter stringFromDate:[_datePicker date]];
  NSLog(@"formatted date is %@",convertedDateString);
  self.dateofBirth.text = convertedDateString;
  _pickeParentView.hidden = YES;
  _datePicker.hidden = NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)dateOfBirthAction:(id)sender {
  _pickeParentView.hidden = NO;
    
}

- (IBAction)roleAction:(UIButton*)sender {
    
    if(sender.tag == 1) {
        _role_male.selected = YES;
        _role_female.selected = NO;
    }
    else if(sender.tag == 2) {
        _role_male.selected = NO;
        _role_female.selected = YES;
    }
}

- (IBAction)typeAction:(UIButton*)sender {
    
    if(sender.tag == 1) {
        _actor.textColor = [UIColor colorWithRed:216.0/255.0 green:79.0/255.0 blue:42.0/255.0 alpha:1.0];
        _director.textColor = [UIColor blackColor];
        userType = @"1";
    }
    else if(sender.tag == 2) {
        _director.textColor = [UIColor colorWithRed:216.0/255.0 green:79.0/255.0 blue:42.0/255.0 alpha:1.0];
        _actor.textColor = [UIColor blackColor];
        userType = @"2";
    }
}

- (IBAction)submit:(id)sender {
  
  NSString *message = [self isValid:_firstName.text :_lastName.text :_emailId.text :_password.text :_retypePassword.text :_country.text :_contactNumber.text];
  
  if(message.length != 0 || message != nil)
  {
    [RKDropdownAlert title:@"INFORMATION" message:message];
    return;
  }
  
  NSString *gender;
  
  if(_role_male.selected)
  {
     gender = @"1";
  }
  else{
    gender = @"2";
  }
  
  
  requestData = [[NSDictionary alloc] initWithObjectsAndKeys:_firstName.text,@"firstName",
                               _lastName.text,@"lastName",
                               _emailId.text,@"emailId",
                               _password.text,@"password2",
                               _country.text,@"country",
                               _contactNumber.text,@"phone",
                               gender,@"gender",
                               self.dateofBirth.text,@"dob",
                               _referenceBy.text,@"referred",
                               @"123",@"otp",
                               userType,@"usertype",
                               nil];
  
  if(message.length == 0)
  {
      [self performSegueWithIdentifier:@"otp" sender:nil];
  }
}


-(NSString*)isValid : (NSString*)fName : (NSString*)lName : (NSString*)email : (NSString*)password : (NSString*)confirmPassword : (NSString*)country : (NSString*)contactNumber
{
  if(fName.length == 0)
  {
    return @"Please enter first name";
  }
  else if (lName.length == 0)
  {
    return @"Please enter last name";
  }
  else if(email.length == 0)
  {
    return @"Please enter email";
  }
  else if(![self validateEmailWithString:email])
  {
    return @"Please enter valid email";
  }
  else if(password.length == 0)
  {
    return @"Please enter password";
  }
  else if(password.length < 4)
  {
      return @"Password must contain at least 4 characters";
  }
  else if(![confirmPassword isEqualToString:password])
  {
    return @"Confirm password should be same as password";
  }
  else if(country.length == 0)
  {
    return @"Please enter country";
  }
  else if(contactNumber.length == 0)
  {
    return @"Please enter contact number";
  }
  else if(_dateofBirth.text.length == 0)
  {
      return @"Please enter birth date";
  }
  return nil;
}

- (BOOL)validateEmailWithString:(NSString*)email
{
  NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
  NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
  return [emailTest evaluateWithObject:email];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"otp"])
    {
        OTPViewController *vc = segue.destinationViewController;
        vc.dict = [requestData mutableCopy];
    }
}


@end
