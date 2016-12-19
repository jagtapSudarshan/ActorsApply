//
//  OTPViewController.m
//  ActorsApply
//
//  Created by Sudarshan on 10/23/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "OTPViewController.h"
#import "ConnectionManager.h"
#import "WebServiceConstants.h"
#import "RKDropdownAlert.h"

@interface OTPViewController ()
{
    NSString *idStr;
}
@property (weak, nonatomic) IBOutlet UITextField *otpTextField;

@end

@implementation OTPViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    NSLog(@"data:::%@",_dict);
    [self getOTP];
}

-(void)getOTP
{
    [ConnectionManager callGetMethod:[NSString stringWithFormat:@"%@%@/%@",BASE_URL,GET_OTP,[_dict valueForKey:@"phone"]] completionBlock:^(BOOL succeeded, id responseData, NSString *errorMsg)
     {
         if(succeeded)
         {
             idStr = [[responseData valueForKey:@"data"] valueForKey:@"id"];
             
             //[_dict setValue:[[responseData objectForKey:@"data"] valueForKey:@"otp"] forKey:@"otp"];
             [RKDropdownAlert title:@"INFORMATION" message:[responseData valueForKey:@"message"]];
         }
         else{
             [RKDropdownAlert title:@"INFORMATION" message:[responseData valueForKey:@"message"]];
         }
     }];
}

- (IBAction)verfy:(id)sender {
    
    if(_otpTextField.text.length == 0)
    {
        [RKDropdownAlert title:@"INFORMATION" message:@"Please enter OTP"];
        return;
    }
    
    [_dict setValue:_otpTextField.text forKey:@"otp"];
    
    NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:
                   idStr,@"id",
                   _otpTextField.text,@"otp",
                   nil];
    
    [ConnectionManager callPostMethod:[NSString stringWithFormat:@"%@%@",BASE_URL,VERIFY_OTP] Data:data completionBlock:^(BOOL succeeded, id responseData, NSString *errorMsg)
     {
         if(succeeded)
         {
              //[RKDropdownAlert title:@"INFORMATION" message:[responseData valueForKey:@"message"]];
//             if(_isFromFB)
//             {
//                 [self performSegueWithIdentifier:@"navToHome" sender:nil];
//             }
//             else{
                 [self performSegueWithIdentifier:@"login" sender:nil];
           //  }
         }
         else{
             // login screen.
             [self performSegueWithIdentifier:@"login" sender:nil];
         }
     }];
}

- (IBAction)resendOTP:(id)sender {
    [self getOTP];
}

@end
