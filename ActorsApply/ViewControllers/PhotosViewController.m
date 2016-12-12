//
//  PhotosViewController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/5/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "PhotosViewController.h"
#import "ProfilePhotosCollectionViewCell.h"
#import "ConnectionManager.h"
#import "UIImageView+AFNetworking.h"
#import "WebServiceConstants.h"

@interface PhotosViewController ()

@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.photosCollectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self->_profileImages count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ProfilePhotosCollectionViewCell";
    ProfilePhotosCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@",@"http://www.actorsapply.com/app/webroot/img/photos/",[self->_profileImages objectAtIndex:indexPath.row]];
    
    [cell.imageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
    
    return cell;
}

@end
