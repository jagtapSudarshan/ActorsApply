//
//  SideMenuViewController.h
//  Massma
//
//  Created by Bhushan Shivaji Mahajan on 05/02/16.
//  Copyright © 2016 Bhushan Shivaji Mahajan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *textArr;
    NSMutableArray  *imgNameArr;
    NSMutableArray *identifierNameArr;
    int selectedIndex;
    __weak IBOutlet UITableView *tbl;
    __weak IBOutlet UIImageView *imgPic;
    __weak IBOutlet UIView *imageParentView;
    NSDictionary *userDetail;
}
@property (nonatomic,strong)HomeViewController *homeVc;
@end
