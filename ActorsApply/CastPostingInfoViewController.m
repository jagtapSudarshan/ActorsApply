//
//  CastPostingInfoViewController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/18/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "CastPostingInfoViewController.h"
#import "RKDropdownAlert.h"
#import "REFrostedViewController.h"
#import "SVProgressHUD.h"
#import "ConnectionManager.h"
#import "WebServiceConstants.h"
#import "Country.h"
#import "AddRolePostCastingViewController.h"
#import "Industry.h"

typedef enum
{
    industy = 1,
    country
}dropDown;

@interface CastPostingInfoViewController ()
{
    dropDown selectedTextFieldDropDown;
    __weak IBOutlet UITextField *projectNameTxt;
    __weak IBOutlet UISwitch *toggle;
    __weak IBOutlet UITextField *directorTxt;
    __weak IBOutlet UITextField *industryTxt;
    __weak IBOutlet UITextField *countryTxt;
    __weak IBOutlet UITextField *locationTxt;
    __weak IBOutlet UITextView *detailsTextView;
    NSMutableArray *countryArray;
    NSMutableArray *countryObjects;
    NSMutableArray *industryArray;
    NSMutableArray *industryObjects;
    Country *selectedCountry;
    Industry *selectedIndustry;
    __weak IBOutlet UIImageView *dateImageView;
    NSInteger type;
    NSInteger status;
  UIView *opaqueView;
}

@property (weak, nonatomic) IBOutlet UIView *parentView;
@property (weak, nonatomic) IBOutlet UIImageView *iamgeView;
@property (weak, nonatomic) IBOutlet UILabel *castLbl;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *auditionDateLbl;
@property (weak, nonatomic) IBOutlet UIView *datePickerParentView;

@end

@implementation CastPostingInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.auditionDateLbl.hidden = YES;
    int number = [[_selectedCast objectForKey:@"number"] intValue];
    
    switch (number) {
        case 1:
            [_parentView setBackgroundColor:[[UIColor alloc]initWithRed:0.87 green:0.32 blue:0.17 alpha:1]];
            type = 1;
            break;
        case 2:
            [_parentView setBackgroundColor:[[UIColor alloc]initWithRed:0.52 green:0.55 blue:0.78 alpha:1.0f]];
            type = 5;
            break;
        case 3:
            [_parentView setBackgroundColor:[UIColor colorWithRed:0.88 green:0.60 blue:0.18 alpha:1.0f]];
            type = 4;
            break;
        case 4:
            [_parentView setBackgroundColor:[UIColor colorWithRed:0 green:0.48 blue:0.79 alpha:1.0f]];
            type = 3;
            break;
        case 5:
            [_parentView setBackgroundColor:[UIColor colorWithRed:0.74 green:0.13 blue:0.17 alpha:1.0f]];
            type = 7;
            break;
        case 6:
            [_parentView setBackgroundColor:[UIColor colorWithRed:0.91 green:0.5 blue:0.36 alpha:1.0f]];
            type = 8;
            break;
        case 7:
            [_parentView setBackgroundColor:[UIColor colorWithRed:0.46 green:0.43 blue:0.17 alpha:1.0f]];
            type = 6;
            break;
        case 8:
            [_parentView setBackgroundColor:[UIColor colorWithRed:0.52 green:0.37 blue:0.4 alpha:1.0f]];
            type = 2;
            break;
        default:
            break;
    }
    
    countryArray = [NSMutableArray new];
    
    [self callCastingInit];
    
    [_iamgeView setImage:[UIImage imageNamed:[_selectedCast objectForKey:@"imageView"]]];
    [_castLbl setText:[_selectedCast objectForKey:@"name"]];
    _datePickerParentView.hidden = YES;
  
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dateClicked:)];
    dateImageView.userInteractionEnabled = YES;
    dateImageView.tag = 0;
    dateImageView.userInteractionEnabled = YES;
    [dateImageView addGestureRecognizer:tap];
    
    detailsTextView.layer.borderColor = [[UIColor blackColor] CGColor];
    detailsTextView.layer.borderWidth = 1.0f;
  
  

  opaqueView = [[UIView alloc]init];
  opaqueView.frame= self.view.bounds;
  opaqueView.backgroundColor = [UIColor blackColor];
  opaqueView.alpha = 0.8;
  opaqueView.hidden = YES;
  [self.view addSubview:opaqueView];
  UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissOpqueView)];
  [opaqueView addGestureRecognizer:tap1];

}

- (void)pickerChanged:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *convertedDateString = [dateFormatter stringFromDate:[_datePicker date]];
    NSLog(@"formatted date is %@",convertedDateString);
    self.auditionDateLbl.text = convertedDateString;
    self.auditionDateLbl.hidden = NO;
    _datePickerParentView.hidden = YES;
    dateImageView.hidden = NO;
}

- (UIColor *)colorAtPixel:(CGPoint)point inImage:(UIImage *)image {
    
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, image.size.width, image.size.height), point)) {
        return nil;
    }
    
    // Create a 1x1 pixel byte array and bitmap context to draw the pixel into.
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = image.CGImage;
    NSUInteger width = image.size.width;
    NSUInteger height = image.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    CGContextRef context = CGBitmapContextCreate(pixelData, 1, 1, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    // Draw the pixel we are interested in onto the bitmap context
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    
    // Convert color values [0..255] to floats [0.0..1.0]
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     dateImageView.hidden = NO;
    
    UIToolbar *toolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,44)];
    toolbar.barStyle = UIBarStyleDefault;
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(pickerChanged:)];
    [toolbar setItems:[NSArray arrayWithObjects:flexibleSpaceLeft, doneButton, nil]];
    [_datePickerParentView addSubview:toolbar];
    _datePicker.minimumDate = [NSDate date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showMenu
{
    // Dismiss keyboard (optional)
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)didSelectNext
{
    if([projectNameTxt.text isEqualToString:@""])
    {
        [RKDropdownAlert title:@"INFORMATION" message:@"Please enter project name"];
        return;
    }
    else if([directorTxt.text isEqualToString:@""])
    {
        [RKDropdownAlert title:@"INFORMATION" message:@"Please enter director"];
        return;
    }
    else if([industryTxt.text isEqualToString:@""])
    {
        [RKDropdownAlert title:@"INFORMATION" message:@"Please enter industry"];return;
    }
    else if([countryTxt.text isEqualToString:@""])
    {
        [RKDropdownAlert title:@"INFORMATION" message:@"Please enter country"];return;
    }
    else if([locationTxt.text isEqualToString:@""])
    {
        [RKDropdownAlert title:@"INFORMATION" message:@"Please enter location"];return;
    }
    
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
    NSString *AudtionDateStr = self.auditionDateLbl.text;
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithObjectsAndKeys:projectNameTxt.text,@"name",
                                 directorTxt.text,@"casting_director",
                                 directorTxt.text,@"director",
                                 selectedIndustry.industryId,@"industry",
                                 selectedCountry.countryId,@"country",
                                 locationTxt.text,@"location",
                                 [NSNumber numberWithInteger:type],@"type",
                                 userId,@"user_id",
                                 [self getCurrentDate],@"castingDate",
                                 @"1",@"status",
                                 [_selectedCast objectForKey:@"imageView"],@"image",
                                 [_selectedCast objectForKey:@"name"],@"selectedTypeName",
                                 detailsTextView.text,@"desc",AudtionDateStr,@"shootDate",@" ",@"id",@" ",@"modified",@" ",@"created",
                                 nil];
    
    [self performSegueWithIdentifier:@"AddRolePostCastingViewController" sender:data];
}

-(NSString*)getCurrentDate{
  NSDate *todayDate = [NSDate date];
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"yyyy-MM-dd"];
  NSString *convertedDateString = [dateFormatter stringFromDate:todayDate];
  NSLog(@"Today formatted date is %@",convertedDateString);
  return convertedDateString;
}

- (IBAction)didSelectAudtionDate:(UIControl *)sender
{
}

- (IBAction)dateClicked:(id)sender {
    _datePickerParentView.hidden = NO;
    dateImageView.hidden = YES;
  
//  CGRect pickerFrame = CGRectMake(0,250,0,0);
//  UIDatePicker *myPicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
//  [myPicker addTarget:self action:@selector(pickerChanged:)               forControlEvents:UIControlEventValueChanged];
//  UIView* darkView = [[UIView alloc]init];
//  //darkView.frame = CGRectMake(0, 210, 320, 216);
//  darkView.backgroundColor = [UIColor blueColor];
//  UIDatePicker *myPicker   = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.frame.size.width - 40, self.view.frame.size.width, 200)];
//  [myPicker setDatePickerMode:UIDatePickerModeDate];
//  myPicker.backgroundColor = [UIColor whiteColor];
//  [myPicker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
//  [darkView addSubview:myPicker];
//  [opaqueView addSubview:darkView];
//  [opaqueView bringSubviewToFront:darkView];
//  opaqueView.hidden = NO;
//  [self.view addSubview:opaqueView];
//  [self.view bringSubviewToFront:opaqueView];
}

-(void)dismissOpqueView
{
    NSLog(@"%@",_datePicker.date);
    [_datePickerParentView setHidden:YES];
    opaqueView.hidden = YES;
    [opaqueView removeFromSuperview];
}

- (IBAction)backClciked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark - Text field delegate
#pragma mark -
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField == industryTxt)
    {
        [self.view endEditing:YES];

        Industry *industry = [Industry new];
        industry.industryId = @"0";
        industry.name = @"Hindi";
        
        Industry *industry1 = [Industry new];
        industry1.industryId = @"1";
        industry1.name = @"English";
        
        Industry *industry2 = [Industry new];
        industry2.industryId = @"2";
        industry2.name = @"Telugu";
        
        Industry *industry3 = [Industry new];
        industry3.industryId = @"3";
        industry3.name = @"Malyalam";
        
        Industry *industry4 = [Industry new];
        industry4.industryId = @"4";
        industry4.name = @"Tamil";
        
        Industry *industry5 = [Industry new];
        industry5.industryId = @"5";
        industry5.name = @"Punjabi";
        
        Industry *industry6 = [Industry new];
        industry6.industryId = @"6";
        industry6.name = @"Gujrati";
        
        Industry *industry7 = [Industry new];
        industry7.industryId = @"7";
        industry7.name = @"Bengali";
        
        Industry *industry8 = [Industry new];
        industry8.industryId = @"8";
        industry8.name = @"Marathi";
        
        Industry *industry9 = [Industry new];
        industry9.industryId = @"9";
        industry9.name = @"Bhojpuri";
        
        Industry *industry10 = [Industry new];
        industry10.industryId = @"10";
        industry10.name = @"Other";
        
        industryObjects = [[NSMutableArray alloc] initWithObjects:industry,industry1,industry2,industry3,industry4,industry5,industry6,industry7,industry8,industry9,industry10, nil];
        
        industryArray = [[NSMutableArray alloc] initWithObjects:industry.name,industry1.name,industry2.name,industry3.name,industry4.name,industry5.name,industry6.name,industry7.name,industry8.name,industry9.name,industry10.name, nil];
        
        selectedTextFieldDropDown = industy;
        [self DropDownSingle:textField arr_list:industryArray Title:@"Select Industry"];
        return  NO;
    }

    if(textField == countryTxt)
    {
        [self.view endEditing:YES];
        for (Country *country in countryObjects) {
            [countryArray addObject:country.name];
        }
        
        selectedTextFieldDropDown = country ;
        [self DropDownSingle:textField arr_list:countryArray Title:@"Select Country"];
        return  NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

#pragma mark -
#pragma mark - drop down
#pragma mark -

-(void)DropDownSingle:(id)sender arr_list:(NSArray *)arr_list Title:(NSString *)str_title
{
    [Dropobj fadeOut];
    
    [self showPopUpWithTitle:str_title withOption:arr_list xy:CGPointMake(20, (self.view.frame.size.height/2-150)) size:CGSizeMake(self.view.frame.size.width-40, self.view.frame.size.height-40) isMultiple:NO];
}

-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
    
    Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:isMultiple];
    Dropobj.delegate = self;
    [Dropobj showInView:self.view animated:YES];
    
    /*----------------Set DropDown backGroundColor-----------------*/
    [Dropobj SetBackGroundDropDown_R:255.0 G:255.0 B:255.0 alpha:1.0f];
}

- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
    
    /*----------------Get Selected Value[Single selection]-----------------*/
    switch (selectedTextFieldDropDown) {
        case country:
        {
            countryTxt.text = [countryArray  objectAtIndex:anIndex];
            selectedCountry = [countryObjects objectAtIndex:anIndex];
        }
            break;
        case industy:
        {
            industryTxt.text = [industryArray  objectAtIndex:anIndex];
            selectedIndustry = [industryObjects objectAtIndex:anIndex];
        }
            break;
        default:
            break;
    }
}

- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray*)ArryData{
}

- (void)DropDownListViewDidCancel{
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    if ([touch.view isKindOfClass:[UIView class]]) {
        [Dropobj fadeOut];
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

- (void) callCastingInit
{
    [SVProgressHUD show];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,CASTING_INIT];
    
    NSLog(@"%@",url);
    
    [ConnectionManager callGetMethod:url completionBlock:^(BOOL succeeded, id responseData, NSString *errorMsg) {
        
        [SVProgressHUD dismiss];
        
        if (succeeded)
        {
            NSMutableDictionary *countryDict = [responseData objectForKey:@"data"];
            NSMutableArray *countries = [countryDict objectForKey:@"countries"];
            countryObjects = [NSMutableArray new];
            for (NSDictionary *countryDict in countries)
            {
                Country *country = [Country new];
                country.name = [countryDict objectForKey:@"name"];
                country.countryId = [countryDict objectForKey:@"id"];
                country.status = [countryDict objectForKey:@"status"];
                [countryObjects addObject:country];
            }
        }
        else
        {
            [RKDropdownAlert title:@"INFORMATION" message:errorMsg];
        }
    }];
}
- (IBAction)toggleClicked:(id)sender {
    if(toggle.on)
    {
        status = 1;
    }
    else{
        status = 0;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"AddRolePostCastingViewController"])
    {
        AddRolePostCastingViewController *vc = segue.destinationViewController;
        vc.data = (NSMutableDictionary*)sender;
    }
}

@end
