//
//  RootViewController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/5/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void) awakeFromNib
{
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    NSString* role = [[NSUserDefaults standardUserDefaults] valueForKey:@"role"];
    
    if([role isEqualToString:@"1"])
    {
        self.menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"menuController"];
    }
    else
    {
        self.menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"directorMenuController"];
    }
}

@end
