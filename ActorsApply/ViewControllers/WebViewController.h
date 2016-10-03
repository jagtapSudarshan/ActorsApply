//
//  WebViewController.h
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/5/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"
@interface WebViewController : SuperViewController<UIWebViewDelegate>

@property(nonatomic, retain) NSString *url;
@property (weak, nonatomic) IBOutlet UIWebView *viewWeb;

- (IBAction)moveBack;
@end
