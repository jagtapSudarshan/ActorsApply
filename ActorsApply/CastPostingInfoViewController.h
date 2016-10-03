//
//  CastPostingInfoViewController.h
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/18/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListView.h"
#import "SuperViewController.h"
@interface CastPostingInfoViewController : SuperViewController<kDropDownListViewDelegate,UITextViewDelegate>
{
    DropDownListView *Dropobj;
}
@property(strong,nonatomic) NSMutableDictionary* selectedCast;

- (IBAction)didSelectNext;

- (IBAction)didSelectAudtionDate:(UIControl *)sender;

@end
