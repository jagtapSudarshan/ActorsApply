//
//  UploadVideoViewController.h
//  ActorsApply
//
//  Created by Kalpesh Mahajan on 20/11/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadVideoViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>

@property (nonatomic)NSMutableArray *profileVideos;

@end
