//
//  AuditionDetailsViewController.h
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/12/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Audition.h"
#import "SuperViewController.h"

@interface AuditionDetailsViewController : SuperViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblFilm;
@property (weak, nonatomic) IBOutlet UILabel *lblGender;
@property (weak, nonatomic) IBOutlet UILabel *lblAge;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UIButton *roleBtn;

@property (nonatomic) Audition *audition;

- (IBAction)didSelectRole;
- (IBAction)didSelectBack;
@end
