//
//  SuperViewController.m
//  ActorsApply
//
//  Created by Sudarshan on 10/1/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "SuperViewController.h"
#import "SWRevealViewController.h"
#import "SubmissionViewController.h"
#import "InboxViewController.h"
#import "HomeViewController.h"
@interface SuperViewController ()

@end

@implementation SuperViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ){
    
    NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"CustomView_iPhone" owner:self options:nil];
    
    for (UIView *view in nibObjects) {
      
      if ([view isKindOfClass:[Footer class]]) {
        
        self.footer = (Footer *)view;
        
        [self.view addSubview:self.footer];
      }
      else if ([view isKindOfClass:[Header class]]){
        
        self.header = (Header *)view;
        
        [self.view addSubview:self.header];
      }
    }
  }
  SWRevealViewController *revealViewController = self.revealViewController;
  if ( revealViewController )
  {
    [self.header.toogleButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
  }
  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
- (IBAction)tab1Selected:(id)sender {
  SWRevealViewController *revealViewController = self.revealViewController;
  if ( revealViewController ){
    SubmissionViewController *frontViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SubmissionViewController"];
    [self.revealViewController pushFrontViewController:frontViewController animated:YES];
  }else{
    
  }
  
}

- (IBAction)tab2Selected:(id)sender {
  SWRevealViewController *revealViewController = self.revealViewController;
  if ( revealViewController ){
    HomeViewController *frontViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Home"];
    [self.revealViewController pushFrontViewController:frontViewController animated:YES];
  }else{
    
  }
}
- (IBAction)tab3Selected:(id)sender {
  SWRevealViewController *revealViewController = self.revealViewController;
  if ( revealViewController ){
    InboxViewController *frontViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"InboxViewController"];
    [self.revealViewController pushFrontViewController:frontViewController animated:YES];
  }else{
    
  }
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
