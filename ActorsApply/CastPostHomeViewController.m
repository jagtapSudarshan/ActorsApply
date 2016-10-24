//
//  CastPostHomeViewController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/18/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "CastPostHomeViewController.h"
#import "RKDropdownAlert.h"
#import "REFrostedViewController.h"
#import "CastPostingInfoViewController.h"

@interface CastPostHomeViewController ()
{
    NSInteger *count;
}
@property (weak, nonatomic) IBOutlet UIImageView *tvcImageView;
@property (weak, nonatomic) IBOutlet UIImageView *tvShowImageView;
@property (weak, nonatomic) IBOutlet UIImageView *filmSeriesImageView;
@property (weak, nonatomic) IBOutlet UIImageView *musicVideoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *theatreImageView;
@property (weak, nonatomic) IBOutlet UIImageView *shortImageView;
@property (weak, nonatomic) IBOutlet UIImageView *filmImageView;
@property (weak, nonatomic) IBOutlet UIImageView *printImageView;

@end

@implementation CastPostHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:YES];
    // Do any additional setup after loading the view.
    
    NSArray *array = [[NSArray alloc] initWithObjects:_filmImageView,_shortImageView,_tvcImageView,_tvShowImageView,_printImageView,_theatreImageView,_filmSeriesImageView,_musicVideoImageView,nil];
   
    //for (int i = 0; i < [array count]; i++) {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicked:)];
    tap.view.tag = 1;
    UIImageView* imageView = [array objectAtIndex:0];
    imageView.userInteractionEnabled = YES;
    imageView.tag = 1;
    [[array objectAtIndex:0] addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicked:)];
    tap1.view.tag = 2;
    UIImageView* imageView1 = [array objectAtIndex:1];
    imageView1.userInteractionEnabled = YES;
    imageView1.tag = 2;
    [[array objectAtIndex:1] addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicked:)];
    tap2.view.tag = 3;
    UIImageView* imageView2 = [array objectAtIndex:2];
    imageView2.userInteractionEnabled = YES;
    imageView2.tag = 3;
    [[array objectAtIndex:2] addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicked:)];
    tap3.view.tag = 4;
    UIImageView* imageView3 = [array objectAtIndex:3];
    imageView3.userInteractionEnabled = YES;
    imageView3.tag = 4;
    [[array objectAtIndex:3] addGestureRecognizer:tap3];
    
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicked:)];
    tap4.view.tag = 5;
    UIImageView* imageView4 = [array objectAtIndex:4];
    imageView4.userInteractionEnabled = YES;
    imageView4.tag = 5;
    [[array objectAtIndex:4] addGestureRecognizer:tap4];
    
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicked:)];
    tap5.view.tag = 6;
    UIImageView* imageView5 = [array objectAtIndex:5];
    imageView5.userInteractionEnabled = YES;
    imageView5.tag = 6;
    [[array objectAtIndex:5] addGestureRecognizer:tap5];
    
    UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicked:)];
    tap6.view.tag = 7;
    UIImageView* imageView6 = [array objectAtIndex:6];
    imageView6.userInteractionEnabled = YES;
    imageView6.tag = 7;
    [[array objectAtIndex:6] addGestureRecognizer:tap6];
    
    UITapGestureRecognizer *tap7 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicked:)];
    tap7.view.tag = 8;
    UIImageView* imageView7 = [array objectAtIndex:7];
    imageView7.userInteractionEnabled = YES;
    imageView7.tag = 8;
    [[array objectAtIndex:7] addGestureRecognizer:tap7];
   // }
}

-(void)imageClicked : (UITapGestureRecognizer*) gesture
{
    NSLog(@"TAG::%ld",gesture.view.tag);
    
    NSString *imageView;
    NSString *castName;
    NSInteger number;
    switch (gesture.view.tag) {
        case 1:
            imageView = @"PNG";
            castName = @"Film";
            number = 1;
            break;
        case 2:
            imageView = @"PNG-29";
            castName = @"Short Films";
            number = 2;
            break;
        case 3:
            imageView = @"PNG-9";
            castName = @"TVC";
            number = 3;
            break;
        case 4:
            imageView = @"PNG-13";
            castName = @"TV Show";
            number = 4;
            break;
        case 5:
            imageView = @"PNG-5";
            castName = @"Print";
            number = 5;
            break;
        case 6:
            imageView = @"PNG-25";
            castName = @"Theatre";
            number = 6;
            break;
        case 7:
            imageView = @"PNG-17";
            castName = @"Video Series";
            number = 7;
            break;
        case 8:
            imageView = @"PNG-21";
            castName = @"Music Video";
            number = 8;
            break;
        default:
            break;
    }
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:imageView,@"imageView",
                          castName,@"name",
                          [NSNumber numberWithInteger:number], @"number",nil];
    
    [self performSegueWithIdentifier:@"navToCastForm" sender:dict];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showMenu
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    CastPostingInfoViewController *vc = segue.destinationViewController;
    vc.selectedCast = (NSMutableDictionary*)sender;
}


@end
