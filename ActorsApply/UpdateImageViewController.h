//
//  UpdateImageViewController.h
//  ActorsApply
//
//  Created by Sandip Mahajan on 11/4/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateImageViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>

@property (nonatomic)NSMutableArray *profileImages;

@end
