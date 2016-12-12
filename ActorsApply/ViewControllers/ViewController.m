//
//  ViewController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/5/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "ViewController.h"
#import "RKDropdownAlert.h"
#import "ConnectionManager.h"
#import "WebServiceConstants.h"
#import "SVProgressHUD.h"
#import "MenuViewController.h"
#import "MFSideMenu.h"
#import "MFSideMenuContainerViewController.h"
#import "HomeViewController.h"
#import "NavigationController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.emailView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.emailView.layer.borderWidth = 1.0f;
    self.passwordView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.passwordView.layer.borderWidth = 1.0f;
    self.signupView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.signupView.layer.borderWidth = 1.0f;
    
    //Actor
    
    _emailText.text = @"ankurbhatias@gmail.com";
    _passwordText.text = @"HiGPxCeo";
    
 //   _emailText.text = @"vidhi.lal51@gmail.com";
 //   _passwordText.text = @"vidhi189";

    //Casting
    
//    _emailText.text = @"jigna126@gmail.com";
//    _passwordText.text = @"castingjigna";
//    
//    _emailText.text = @"apulakhia@gmail.com";
//    _passwordText.text = @"haseena";

//    _emailText.text = @"bharatjha35@gmail.com";
//    _passwordText.text = @"bharat123";
  
//  _emailText.text = @"gaurav.gauravs@gmail.com";
//  _passwordText.text = @"password";
  
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginClicked:(id)sender {
    if(_emailText.text == nil && _passwordText.text == nil)
    {
        [RKDropdownAlert title:@"INFORMATION" message:@"Please enter email and password"];
        return;
    }
    else if(![self validateEmailWithString:_emailText.text])
    {
        [RKDropdownAlert title:@"INFORMATION" message:@"Please enter valid email"];
        return;
    }
    
    NSDictionary *requestData = [[NSDictionary alloc] initWithObjectsAndKeys:_emailText.text,@"loginId",
                                 _passwordText.text,@"password",
                                 nil];
    
    [SVProgressHUD show];
    
    [ConnectionManager callLoginPostMethod:[NSString stringWithFormat:@"%@%@",BASE_URL,LOGIN] Data:requestData completionBlock:^(BOOL succeeded, id responseData, NSString *errorMsg) {
        
        [SVProgressHUD dismiss];
        
        if(succeeded)
        {
            NSDictionary *userData = [[responseData valueForKey:@"data"] valueForKey:@"user"];
            
            [[NSUserDefaults standardUserDefaults] setObject:[responseData objectForKey:@"authorization"] forKey:@"authorization"];
            NSLog(@"[[NSUserDefaults standardUserDefaults]:::%@::::",[[NSUserDefaults standardUserDefaults] objectForKey:@"emailId"]);
            [[NSUserDefaults standardUserDefaults] setObject:[userData objectForKey:@"emailId"] forKey:@"emailId"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@ %@",[userData objectForKey:@"firstName"],[userData objectForKey:@"lastName"]]  forKey:@"Name"];
            [[NSUserDefaults standardUserDefaults] setObject:[userData objectForKey:@"id"] forKey:@"id"];
            NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
            [data setObject:[userData objectForKey:@"firstName"] forKey:@"firstName"];
            [data setObject:[userData objectForKey:@"lastName"] forKey:@"lastName"];
            [data setObject:[userData objectForKey:@"phone"] forKey:@"phone"];
            [data setObject:[userData objectForKey:@"emailId"] forKey:@"emailId"];
            [data setObject:[userData objectForKey:@"country"] forKey:@"country"];
            NSArray *array = [[responseData valueForKey:@"data"] valueForKey:@"projects"];
            [data setObject:array forKey:@"projects"];

            NSData *myData = [NSKeyedArchiver archivedDataWithRootObject:data];
            [[NSUserDefaults standardUserDefaults] setObject:myData forKey:@"userData"];
 
            if([[userData objectForKey:@"usertype"] integerValue] == 1)
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"role"];
            }
            else{
               [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"role"];
            }
            
            NSArray *mediaFiles = [[responseData objectForKey:@"data"] objectForKey:@"media"];
            for (NSDictionary *media in mediaFiles)
            {
                if ([[media valueForKey:@"profile"] isEqualToString:@"1"])
                {
                    [[NSUserDefaults standardUserDefaults] setObject:[media valueForKey:@"asset"] forKey:@"profileImage"];
                }
            }
            
            NavigationController *contentController = [self.storyboard instantiateViewControllerWithIdentifier:@"rootController"];
            self.view.window.rootViewController = contentController;
        }
        else{
            
            [RKDropdownAlert title:@"INFORMATION" message:errorMsg];
        }
    }];
}

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (IBAction)FBLOGIN:(id)sender {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logOut];
    login.loginBehavior = FBSDKLoginBehaviorSystemAccount;
    
    [login
     logInWithReadPermissions: @[@"public_profile",@"user_birthday",@"user_photos",@"user_about_me"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
     {
         if (error)
         {
             // Process error
             if(error.code == 308)
             {
                 [RKDropdownAlert title:@"INFORMATION" message:@"Unable to login Facebook"];
                 return;
             }
             
         } else if (result.isCancelled) {
             
             // Handle cancellations.
         }
         else
         {
             [self fetchUserInfo];
         }
     }];
}

-(void)fetchUserInfo
{
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
          
                                           parameters:@{@"fields": @"picture.type(large), email,id,first_name,last_name, gender, birthday"}]
         
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             
             if (!error)
             {
                 NSData *jsondata = [NSJSONSerialization dataWithJSONObject:result
                                                                    options:kNilOptions
                                                                      error:&error];
                 NSDictionary* resultDict = [NSJSONSerialization JSONObjectWithData:jsondata
                                                                            options:kNilOptions
                                                                              error:&error];
                 
                 NSDictionary* requestDict=[[NSDictionary alloc] initWithObjectsAndKeys:
                                           // @"FB", @"login_type",
                                            [resultDict objectForKey:@"first_name"], @"first_name",
                                            [resultDict objectForKey:@"last_name"], @"last_name",
                                            [resultDict objectForKey:@"gender"],@"gender",
                                            [resultDict objectForKey:@"id"],@"fb_id",
                                            [[[resultDict objectForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"],@"profile_photo",
                                            [resultDict objectForKey:@"birthday"],@"birthday",
                                            [[FBSDKAccessToken currentAccessToken] tokenString],@"fb_token",
                                            nil];
                 
                 [[NSUserDefaults standardUserDefaults] setValue:[resultDict objectForKey:@"id"] forKey:@"fbid"];
                 
                 [SVProgressHUD show];
                 
                 [ConnectionManager callLoginPostMethod:[NSString stringWithFormat:@"%@%@",BASE_URL,LOGIN] Data:requestDict completionBlock:^(BOOL succeeded, id responseData, NSString *errorMsg) {
                     [SVProgressHUD dismiss];
                     
                     if (succeeded)
                     {
                         if(responseData != nil)
                         {
                             if([[responseData objectForKey:@"status"] isEqualToString:@"success"])
                             {
                                //[RKDropdownAlert title:@"INFORMATION" message:errorMsg];
                             }
                             else
                             {
                                 [RKDropdownAlert title:@"INFORMATION" message:errorMsg];
                             }
                         }
                         else{
                             [RKDropdownAlert title:@"INFORMATION" message:errorMsg];
                         }
                     }
                     else
                     {
                         
                        [RKDropdownAlert title:@"INFORMATION" message:errorMsg];
                     }
                 }];
             }
             else
             {
                 [RKDropdownAlert title:@"INFORMATION" message:[error localizedDescription]];
             }
         }];
    }
    else
    {
         [SVProgressHUD dismiss];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
