//
//  RecomendedActorsCollectionViewCell.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/20/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "RecomendedActorsCollectionViewCell.h"

@implementation RecomendedActorsCollectionViewCell

- (void)awakeFromNib
{
    self.imageViewActor.layer.masksToBounds = YES;
    self.imageViewActor.layer.cornerRadius = self.imageViewActor.frame.size.width / 2;
}


@end