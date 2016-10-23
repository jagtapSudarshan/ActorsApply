//
//  UpgradeViewController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 10/21/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "UpgradeViewController.h"

@interface UpgradeViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) NSArray *imagesData;

@end

@implementation UpgradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBorder:_monthView : [UIColor darkGrayColor]];
    [self setBorder:_annualView : [UIColor colorWithRed:216.0/255.0 green:79.0/255.0 blue:42.0/255.0 alpha:1.0]];
    
    self.imagesData = @[@"upgrade_slide_1.png", @"upgrade_slide_2.png", @"upgrade_slide_3.png", @"upgrade_slide_4.png", @"upgrade_slide_5.png"];
    
    self.pageControl.numberOfPages = self.imagesData.count;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self setupScrollViewImages];
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame) * self.imagesData.count, CGRectGetHeight(_scrollView.frame));
}


#pragma mark - ScrollView delegate



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger pageIndex = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    self.pageControl.currentPage = pageIndex;
}

- (void) setBorder : (UIView*) view : (UIColor*) color{
    view.layer.borderColor = color.CGColor;
    view.layer.borderWidth = 1.0f;
}

- (void)setupScrollViewImages
{
    [self.imagesData enumerateObjectsUsingBlock:^(NSString *imageName, NSUInteger idx, BOOL *stop) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_scrollView.frame) * idx, 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame))];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.image = [UIImage imageNamed:imageName];
        [_scrollView addSubview:imageView];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
