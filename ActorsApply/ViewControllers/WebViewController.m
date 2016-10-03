//
//  WebViewController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/5/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void) viewDidAppear:(BOOL)animated {
    NSURL *fullURL = [NSURL URLWithString:self.url];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:fullURL];
    [_viewWeb loadRequest:requestObj];
}

- (IBAction)moveBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
