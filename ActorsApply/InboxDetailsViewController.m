//
//  InboxDetailsViewController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/20/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "InboxDetailsViewController.h"

@interface InboxDetailsViewController ()

@end

@implementation InboxDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _fromLbl.text = _inbox.from;
    _toLbl.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"Name"];
    _subjectLbl.text = _inbox.subject;
    _descLbl.text = _inbox.desc;
    [_descLbl sizeToFit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backClicked
{
    // Dismiss keyboard (optional)
    [self.navigationController popViewControllerAnimated:YES];
}

@end
