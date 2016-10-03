//
//  AuditionDetailsViewController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/12/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "AuditionDetailsViewController.h"
#import "RKDropdownAlert.h"

@interface AuditionDetailsViewController ()

@end

@implementation AuditionDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
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
  self->_lblGender.text = self->_audition.gender;
  }
  
  self->_lblFilm.text = @"Film";//self->_audition.name;
  
  if (self->_audition.desc == nil || self->_audition.desc == (id)[NSNull null]) {
  
  }else{
     self->_lblDesc.text = self->_audition.desc;
  }
  
  NSString *minAge,*maxAge;
  if (self->_audition.minAge == nil || self->_audition.minAge == (id)[NSNull null]) {
    minAge = @" ";
  }else{
    minAge =self->_audition.minAge;
  }
  if (self->_audition.maxAge == nil || self->_audition.maxAge == (id)[NSNull null]) {
    maxAge = @" ";
  }else{
    maxAge =self->_audition.maxAge;
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
    [RKDropdownAlert title:@"INFORMATION" message:@"Not Implemented"];
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
