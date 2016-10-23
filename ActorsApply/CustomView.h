//
//  SuperViewController.h
//  ActorsApply
//
//  Created by Sudarshan on 10/1/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomView : UIView

@end

@interface Header : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *toogleButton;
@property(nonatomic,copy)NSString *title;
- (void)setTitle:(NSString *)title;
@end

@interface Footer : UIView
@property (weak, nonatomic) IBOutlet UIButton *tab1;
@property (weak, nonatomic) IBOutlet UIButton *tab2;
@property (weak, nonatomic) IBOutlet UIButton *tab3;


@end

