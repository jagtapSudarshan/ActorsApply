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
#import "NavigationController.h"
#import "WebServiceConstants.h"

@interface SuperViewController ()

@end

static int tab_value = TAB_2;

@implementation SuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    home = [UIImage imageNamed:@"icon_2"];
    homeSelected = [UIImage imageNamed:@"icon_2_selected"];
    submission = [UIImage imageNamed:@"icon_1"];
    submissionSelected = [UIImage imageNamed:@"icon_1_selected"];
    inboxImage = [UIImage imageNamed:@"icon_3"];
    inboxSelected = [UIImage imageNamed:@"icon_3_selected"];
    
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ){
        
        NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"CustomView_iPhone" owner:self options:nil];
        
        for (UIView *view in nibObjects) {
            
            if ([view isKindOfClass:[Footer class]]) {
                
                self.footer = (Footer *)view;
                
                [self.view addSubview:self.footer];
            }
            //      else if ([view isKindOfClass:[Header class]]){
            //
            //        self.header = (Header *)view;
            //
            //        [self.view addSubview:self.header];
            //      }
        }
    }
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.header.toogleButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    // Do any additional setup after loading the view.
    
    if (tab_value == TAB_1)
    {
        self.submission_image.image = submissionSelected;
        self.homeImage.image = home;
        self.imbox_image.image = inboxImage;
    }
    else if (tab_value == TAB_2)
    {
        self.submission_image.image = submission;
        self.homeImage.image = homeSelected;
        self.imbox_image.image = inboxImage;
    }
    else if (tab_value == TAB_3)
    {
        self.submission_image.image = submission;
        self.homeImage.image = home;
        self.imbox_image.image = inboxSelected;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tab1Selected:(UIButton*)sender {
    NSString* role = [[NSUserDefaults standardUserDefaults] valueForKey:@"role"];
    if([role isEqualToString:@"1"] && tab_value != TAB_1)
    {
        tab_value = TAB_1;
        
        NavigationController *tabBarCtrl = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
        SubmissionViewController *submissionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SubmissionViewController"];
        tabBarCtrl.viewControllers = @[submissionViewController];
        self.frostedViewController.contentViewController = tabBarCtrl;
    }
}

- (IBAction)tab2Selected:(UIButton*)sender {
    if (tab_value != TAB_2)
    {
        tab_value = TAB_2;
        
        NavigationController *tabBarCtrl = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
        HomeViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Home"];
        tabBarCtrl.viewControllers = @[homeViewController];
        self.frostedViewController.contentViewController = tabBarCtrl;
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)tab3Selected:(UIButton*)sender {
    if(tab_value != TAB_3)
    {
        tab_value = TAB_3;
        
        NavigationController *tabBarCtrl = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
        InboxViewController *inboxViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"InboxViewController"];
        tabBarCtrl.viewControllers = @[inboxViewController];
        self.frostedViewController.contentViewController = tabBarCtrl;
    }
}

-(NSString*)getImageFromType : (NSInteger) value
{
    switch (value) {
        case 1:
            return @"PNG";
            break;
        case 2:
             return @"PNG-29";
            break;
        case 3:
            return @"PNG-9";
            break;
        case 4:
            return @"PNG-13";
            break;
        case 5:
            return @"PNG-5";
            break;
        case 6:
            return @"PNG-25";
            break;
        case 7:
            return @"PNG-17";
            break;
        case 8:
            return @"PNG-21";
            break;
        default:
            break;
    }
    return nil;
}

-(NSString*)castingType : (NSInteger) value
{
    switch (value) {
        case 1:
            return @"Film";
            break;
        case 2:
            return @"Short Films";
            break;
        case 3:
            return @"TVC";
            break;
        case 4:
            return @"TV Show";
            break;
        case 5:
            return @"Print";
            break;
        case 6:
            return  @"Theatre";
            break;
        case 7:
            return  @"Film Series";
            break;
        case 8:
            return @"Music Video";
            break;
        default:
            break;
    }
    return nil;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)showMenu
{
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}

@end
