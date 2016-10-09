//
//  RecomendedActorsCollectionViewCell.h
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/20/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
@interface RecomendedActorsCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet AsyncImageView *imageViewActor;
@property (weak, nonatomic) IBOutlet UILabel *lblName;

@end
