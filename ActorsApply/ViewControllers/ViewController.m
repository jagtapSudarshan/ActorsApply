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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.emailView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.emailView.layer.borderWidth = 1.0f;
    self.passwordView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.passwordView.layer.borderWidth = 1.0f;
    self.signupView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.signupView.layer.borderWidth = 1.0f;
    
//    _emailText.text = @"ankurbhatias@gmail.com";
//    _passwordText.text = @"ankurabir2015";
    
//    _emailText.text = @"paritosh@biz4solutions.com";
//    _passwordText.text = @"registration";

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
            
            [[NSUserDefaults standardUserDefaults] setObject:[userData objectForKey:@"emailId"] forKey:@"emailId"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@ %@",[userData objectForKey:@"firstName"],[userData objectForKey:@"lastName"]]  forKey:@"Name"];
            [[NSUserDefaults standardUserDefaults] setObject:[userData objectForKey:@"id"] forKey:@"id"];
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *path = [documentsDirectory stringByAppendingPathComponent:@"loginUserData.plist"];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            
            NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
            
            if ([fileManager fileExistsAtPath: path]) {
                data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
            } else {
                // If the file doesn’t exist, create an empty dictionary
                data = [[NSMutableDictionary alloc] init];
            }
            
            //To insert the data into the plist
            [data setObject:[userData objectForKey:@"firstName"] forKey:@"firstName"];
            [data setObject:[userData objectForKey:@"lastName"] forKey:@"lastName"];
            [data setObject:[userData objectForKey:@"phone"] forKey:@"phone"];
            [data setObject:[userData objectForKey:@"emailId"] forKey:@"emailId"];
            [data setObject:[userData objectForKey:@"country"] forKey:@"country"];
            
            NSArray *array = [[responseData valueForKey:@"data"] valueForKey:@"projects"];
            [data setObject:array forKey:@"projects"];
            [data writeToFile: path atomically:YES];
            
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

@end
