//
//  SuperViewController.h
//  ActorsApply
//
//  Created by Sudarshan on 10/1/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "CustomView.h"
#import <QuartzCore/QuartzCore.h>
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
@implementation CustomView

@end

@implementation Footer

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupView];
        
    }
    return self;
}

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        [self setupView];
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [self setupView];
    
}

- (void)setupView {
    
    float y;
    float width;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
//        float screenHeight =[self screenSize].height;
//        y = screenHeight - self.frame.size.height;
        self.frame = CGRectMake(0, 718, 1024, 50);
        
    }else{
        float screenHeight =[self screenSize].height;
        y = screenHeight - self.frame.size.height;
        width = [self screenSize].width;
        CGRect footerFrame = self.frame;
        footerFrame.origin.x = 0;
        footerFrame.origin.y = y;
        footerFrame.size.width = width;
        self.frame = footerFrame;
    }
}

- (CGSize)screenSize
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        return CGSizeMake(screenSize.height, screenSize.width);
    } else {
        return screenSize;
    }
}

@end


@implementation Header

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        
    }
    return self;
}

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        [self setupView];
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [self setupView];
    
}

- (void)setupView {
    
    //float y;
    float width;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
//        float screenHeight =[self screenSize].height;
//        y = screenHeight - self.frame.size.height;
        self.frame = CGRectMake(0, 0, 1024, 50);
        
    }else{
//        float screenHeight =[self screenSize].height;
//        y = screenHeight - self.frame.size.height;
        width = [self screenSize].width;
        CGRect footerFrame = self.frame;
        footerFrame.origin.x = 0;
        footerFrame.origin.y = 20;
        footerFrame.size.width = width;
        footerFrame.size.height = 48;
        self.frame = footerFrame;
    }
}

- (CGSize)screenSize
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        return CGSizeMake(screenSize.height, screenSize.width);
    } else {
        return screenSize;
    }
}

- (void)setTitle:(NSString *)title {
    
    if ([title length] > 0) {
        
        self.titleLabel.text = title;
    }
    
    
}

@end

