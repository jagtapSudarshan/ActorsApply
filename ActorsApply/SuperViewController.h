//
//  SuperViewController.h
//  ActorsApply
//
//  Created by Sudarshan on 10/1/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomView.h"

@interface SuperViewController : UIViewController
@property (nonatomic, strong) Header *header;
@property (nonatomic, strong) Footer *footer;
- (IBAction)tab1Selected:(id)sender;
- (IBAction)tab2Selected:(id)sender;
- (IBAction)tab3Selected:(id)sender;
@end
