//
//  ActorsListViewController.h
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/20/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"
@interface ActorsListViewController : SuperViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collectionRecomended;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionActors;

@end