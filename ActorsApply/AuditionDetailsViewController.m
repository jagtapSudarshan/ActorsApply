//
//  AuditionDetailsViewController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/12/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "AuditionDetailsViewController.h"
#import "RKDropdownAlert.h"
#import "WebServiceConstants.h"
#import "SVProgressHUD.h"
#import "ConnectionManager.h"

@interface AuditionDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation AuditionDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(![_audition.type isEqual:(id)[NSNull null]])
    {
        self.lblFilm.text = [self castingType:[_audition.type integerValue]];//audition.name;
    }
    
    if(![_audition.type isEqual:(id)[NSNull null]])
    {
        [_imageView setImage:[UIImage imageNamed:[self getImageFromType:[_audition.type integerValue]]]];
    }
    
    [self setAuditionData];
}

- (void) setAuditionData
{
  
  if (self->_audition.name == nil || self->_audition.name == (id)[NSNull null]) {

  } else {

     self->_lblName.text = self->_audition.name;
  }
  
  if (self->_audition.gender == nil || self->_audition.gender == (id)[NSNull null]) {
  
  }else{
      if([self->_audition.gender isEqualToString:@"1"])
      {
          self->_lblGender.text = @"Male";
      }
      else{
          self->_lblGender.text = @"Female";
      }
  }
    
  if (self->_audition.desc == nil || self->_audition.desc == (id)[NSNull null]) {
  
  }else{
     self->_lblDesc.text = self->_audition.desc;
  }
  
  NSString *minAge,*maxAge;
    
  NSMutableArray* roleArray =  _audition.role;
    
    if([roleArray count] > 0)
    {
        NSMutableDictionary *data = [roleArray objectAtIndex:0];
        if (data == nil) {
            minAge = @" ";
        }else{
            minAge = [data objectForKey:@"minAge"];
        }
        if (data == nil) {
            maxAge = @" ";
        }else{
            maxAge = [data objectForKey:@"maxAge"];
        }
    }
  self->_lblAge.text = [NSString stringWithFormat:@"%@ - %@",minAge,maxAge];
 
    [self->_lblDesc sizeToFit];
}

- (IBAction)didSelectBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)didSelectRole
{
   // [RKDropdownAlert title:@"INFORMATION" message:@"Not Implemented"];
    [SVProgressHUD show];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,APPLY_AUDITION];
    
    NSLog(@"%@",url);
    NSDictionary *requestData;
    
    if([_audition.role count] > 0)
    {
        requestData = [[NSDictionary alloc] initWithObjectsAndKeys:[[_audition.role objectAtIndex:0] valueForKey:@"id"] ,@"role_id",
                                     [[_audition.role objectAtIndex:0] valueForKey:@"project_id"],@"project_id",
                                     _audition.userId,@"user_id",
                                     @"",@"asset_id",
                                     @"",@"asset_id2",
                                     @"0",@"shortlisted",
                                     nil];
    }
    else{
        [RKDropdownAlert title:@"SUCCESS" message:@"NO role for apply"];
    }
    
    [ConnectionManager callPostMethod:url Data:requestData completionBlock:^(BOOL succeeded, id responseData, NSString *errorMsg) {
        
        [SVProgressHUD dismiss];
        
        if (succeeded)
        {
             [RKDropdownAlert title:@"SUCCESS" message:[responseData valueForKey:@"message"]];
        }
        else
        {
            [RKDropdownAlert title:@"INFORMATION" message:errorMsg];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
