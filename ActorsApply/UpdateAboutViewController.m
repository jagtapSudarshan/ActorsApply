//
//  UpdateAboutViewController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 11/3/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "UpdateAboutViewController.h"
#import "ConnectionManager.h"
#import "WebServiceConstants.h"
#import "SVProgressHUD.h"
#import "RKDropdownAlert.h"

@interface UpdateAboutViewController ()
@property (weak, nonatomic) IBOutlet UITextField *fName;
@property (weak, nonatomic) IBOutlet UITextField *lName;
@property (weak, nonatomic) IBOutlet UITextField *emailId;
@property (weak, nonatomic) IBOutlet UITextField *contactNumber;
@property (weak, nonatomic) IBOutlet UITextField *country;

@end

@implementation UpdateAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSData *fetchUserData = [[NSUserDefaults standardUserDefaults] objectForKey:@"userData"];
    NSMutableDictionary *savedStock  = [NSKeyedUnarchiver unarchiveObjectWithData:fetchUserData];
    
    _fName.text = [savedStock objectForKey:@"firstName"];
    _lName.text =  [savedStock objectForKey:@"lastName"];
    _contactNumber.text =  [savedStock objectForKey:@"phone"];
    _emailId.text =  [savedStock objectForKey:@"emailId"];
    _country.text =  [savedStock objectForKey:@"country"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveClicked:(id)sender {
    
    [SVProgressHUD show];
    
    NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:_fName.text,@"firstName",
                          _lName.text,@"lastName",
                          _country.text,@"country",
                          _contactNumber.text,@"phone",nil];
    
    [ConnectionManager callPostMethod:[NSString stringWithFormat:@"%@%@",BASE_URL,UPDATE_USER_PROFILE] Data:data completionBlock:^(BOOL succeeded, id responseData, NSString *errorMsg) {
        
         [SVProgressHUD dismiss];
        
        if (succeeded) {
            [self.navigationController popViewControllerAnimated:YES];
            
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
            [data setObject:_fName.text forKey:@"firstName"];
            [data setObject:_lName.text forKey:@"lastName"];
            [data setObject:_contactNumber.text forKey:@"phone"];
            [data setObject:_emailId.text forKey:@"emailId"];
            [data setObject:_country.text forKey:@"country"];
            [data writeToFile: path atomically:YES];

            [RKDropdownAlert title:@"INFORMATION" message:[responseData objectForKey:@"message"]];
        }
        else{
            [RKDropdownAlert title:@"INFORMATION" message:errorMsg];
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
