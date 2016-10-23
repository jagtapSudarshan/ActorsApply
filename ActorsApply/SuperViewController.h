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
{
    UIImage* home;
    UIImage* homeSelected;
    UIImage* submission;
    UIImage* submissionSelected;
    UIImage* inboxImage;
    UIImage* inboxSelected;
}


@property (nonatomic, strong) Header *header;
@property (nonatomic, strong) Footer *footer;

@property (weak, nonatomic) IBOutlet UIImageView *homeImage;
@property (weak, nonatomic) IBOutlet UIImageView *imbox_image;
@property (weak, nonatomic) IBOutlet UIImageView *submission_image;


- (IBAction)tab1Selected:(id)sender;
- (IBAction)tab2Selected:(id)sender;
- (IBAction)tab3Selected:(id)sender;

-(NSString*)getImageFromType : (NSInteger) value;
-(NSString*)castingType : (NSInteger) value;


- (IBAction)showMenu;
@end
