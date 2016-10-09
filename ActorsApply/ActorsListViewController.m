//
//  ActorsListViewController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/20/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "ActorsListViewController.h"
#import "ActorsCollectionViewCell.h"
#import "RecomendedActorsCollectionViewCell.h"
#import "WebServiceConstants.h"
#import "ConnectionManager.h"
#import "SVProgressHUD.h"
#import "ActorList.h"
#import "RKDropdownAlert.h"
#import <QuartzCore/QuartzCore.h>
#import "AboutViewController.h"
#import "ProjectViewController.h"
#import "PhotosViewController.h"
#import "VideosViewController.h"
#import "ProfileViewController.h"
#import "SWRevealViewController.h"
@interface ActorsListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
  NSMutableArray *data;
  NSMutableArray *responseArray;
  AboutViewController   *aboutVC;
  ProjectViewController *projectVC;
  PhotosViewController  *photosVC;
  VideosViewController  *videosVC;
  NSMutableArray *profileMediaImages;
  NSMutableArray *profileMediaVideos;
  NSString *profileImageName;
  NSMutableArray *profileProjects;
  
}
@end

@implementation ActorsListViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.collectionActors.delegate = self;
  self.collectionActors.dataSource = self;
  [self getActorsList];
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (IBAction)backClcicked:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}

- (UIEdgeInsets)collectionView:(UICollectionView *) collectionView
                        layout:(UICollectionViewLayout *) collectionViewLayout
        insetForSectionAtIndex:(NSInteger) section {
  
  return UIEdgeInsetsMake(01, 01, 01, 1); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *) collectionView
                   layout:(UICollectionViewLayout *) collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger) section {
  return 1.0;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  //  return responseArray.count;
  return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  if (collectionView == self.collectionRecomended)
  {
    RecomendedActorsCollectionViewCell *cell = (RecomendedActorsCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"RecomendedActorsCollectionViewCell" forIndexPath:indexPath];
    return cell;
  }
  else if (collectionView == self.collectionActors)
  {
    ActorsCollectionViewCell *cell = (ActorsCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"ActorsCollectionViewCell" forIndexPath:indexPath];
    NSString *imageUrl = @"http://www.actorsapply.com/app/webroot/img/photos/";
    ActorList *al = [responseArray objectAtIndex:indexPath.row];
    NSString *img = al.asset.asset;
    imageUrl =[NSString stringWithFormat:@"%@%@",imageUrl,img ];
    cell.imgVw.layer.cornerRadius=40;
    //        cell.imgVw.layer.cornerRadius = cell.imgVw.frame.size.width / 2;
    cell.imgVw.clipsToBounds = true;
    cell.imgVw.showActivityIndicator = YES;
    cell.imgVw.imageURL = [NSURL URLWithString:imageUrl];
    cell.imgVw.contentMode = UIViewContentModeScaleAspectFit;
    return cell;
  }else{
    
  }
  return nil;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  
  ActorList *al = [responseArray objectAtIndex:indexPath.row];
  [self callGetProfileData:al.user_id];
}


-(void)getActorsList
{
  [SVProgressHUD show];
  NSString *selID = self.subApplicant.viewApplicantId;
  NSString *url = [NSString stringWithFormat:@"%@%@/%@",BASE_URL,GET_APPLICATIONS,selID];
  [ConnectionManager callGetMethod:url completionBlock:^(BOOL succeeded, id responseData, NSString *errorMsg) {
    
    [SVProgressHUD dismiss];
    
    if (succeeded)
    {
      responseArray = [[NSMutableArray alloc]init];
      data = [responseData objectForKey:@"data"];
      NSLog(@"\n\n\nDATA = %@",data);
      for (int i =0; i<data.count; i++) {
        NSDictionary *dict = [data objectAtIndex:i];
        
        ActorList *ao = [[ActorList alloc]init];
        ao.actorid = [dict valueForKey:@"id"];
        ao.role_id =[dict valueForKey:@"role_id"];
        ao.project_id=[dict valueForKey:@"project_id"];
        ao.user_id=[dict valueForKey:@"user_id"];
        ao.shortlisted=[dict valueForKey:@"shortlisted"];
        ao.status=[dict valueForKey:@"status"];
        ao.created=[dict valueForKey:@"created"];
        ao.modified=[dict valueForKey:@"modified"];
        
        ActorAsset *assetObj = [[ActorAsset alloc]init];
        assetObj.actorAsset_id=[[dict valueForKey:@"asset"]valueForKey:@"id"];
        assetObj.actorAsset_user_id=[[dict valueForKey:@"asset"]valueForKey:@"user_id"];
        assetObj.asset=[[dict valueForKey:@"asset"]valueForKey:@"asset"];
        assetObj.actorAsset_thumb=[[dict valueForKey:@"asset"]valueForKey:@"thumb"];
        assetObj.actorAsset_actual_name=[[dict valueForKey:@"asset"]valueForKey:@"actual_name"];
        assetObj.actorAsset_type=[[dict valueForKey:@"asset"]valueForKey:@"type"];
        assetObj.actorAsset_profile=[[dict valueForKey:@"asset"]valueForKey:@"profile"];
        assetObj.actorAsset_status=[[dict valueForKey:@"asset"]valueForKey:@"status"];
        assetObj.actorAsset_created=[[dict valueForKey:@"asset"]valueForKey:@"created"];
        assetObj.actorAsset_modified=[[dict valueForKey:@"asset"]valueForKey:@"modified"];
        
        ActorAsset *assetObj2 = [[ActorAsset alloc]init];
        assetObj2.actorAsset_id=[[dict valueForKey:@"asset"]valueForKey:@"id"];
        assetObj2.actorAsset_user_id=[[dict valueForKey:@"asset"]valueForKey:@"user_id"];
        assetObj2.asset=[[dict valueForKey:@"asset"]valueForKey:@"asset"];
        assetObj2.actorAsset_thumb=[[dict valueForKey:@"asset"]valueForKey:@"thumb"];
        assetObj2.actorAsset_actual_name=[[dict valueForKey:@"asset"]valueForKey:@"actual_name"];
        assetObj2.actorAsset_type=[[dict valueForKey:@"asset"]valueForKey:@"type"];
        assetObj2.actorAsset_profile=[[dict valueForKey:@"asset"]valueForKey:@"profile"];
        assetObj2.actorAsset_status=[[dict valueForKey:@"asset"]valueForKey:@"status"];
        assetObj2.actorAsset_created=[[dict valueForKey:@"asset"]valueForKey:@"created"];
        assetObj2.actorAsset_modified=[[dict valueForKey:@"asset"]valueForKey:@"modified"];
        
        ao.asset=assetObj;
        ao.asset2=assetObj2;
        [responseArray addObject:ao];
        [self.collectionActors reloadData];
        
      }
    }
    else
    {
      [RKDropdownAlert title:@"INFORMATION" message:errorMsg];
    }
  }];
}

- (void) callGetProfileData:(NSString*)userId
{
  [SVProgressHUD show];
  
  NSString *profileUrl = [NSString stringWithFormat:@"%@%@%@",BASE_URL,PROFILE,userId];
  
  [ConnectionManager callGetMethod:profileUrl completionBlock:^(BOOL succeeded, id responseData, NSString *errorMsg) {
    
    [SVProgressHUD dismiss];
    
    if (succeeded)
    {
      
      NSArray *projects = [[responseData objectForKey:@"data"] objectForKey:@"projects"];
      
      for (NSDictionary *project in projects)
      {
        NSMutableDictionary *projectDict = [NSMutableDictionary new];
        
        [projectDict setValue:[project valueForKey:@"name"] forKey:@"name"];
        [projectDict setValue:[project valueForKey:@"modified"] forKey:@"modified"];
        [projectDict setValue:[project valueForKey:@"director"] forKey:@"director"];
        if(![profileProjects containsObject:projectDict])
          [profileProjects addObject:projectDict];
      }
      
      
      NSArray *mediaFiles = [[responseData objectForKey:@"data"] objectForKey:@"media"];
      for (NSDictionary *media in mediaFiles)
      {
        if ([[media valueForKey:@"type"] isEqualToString:@"1"])
        {
          if(![profileMediaImages containsObject:[media valueForKey:@"asset"]])
            [profileMediaImages addObject:[media valueForKey:@"asset"]];
          
          if ([[media valueForKey:@"profile"] isEqualToString:@"1"])
          {
            profileImageName = [media valueForKey:@"asset"];
            [[NSUserDefaults standardUserDefaults] setObject:[media valueForKey:@"asset"] forKey:@"profileImage"];
          }
        }
        else
        {
          if(![profileMediaVideos containsObject:[media valueForKey:@"asset"]])
            
            [profileMediaVideos addObject:[media valueForKey:@"asset"]];
        }
      }
      SWRevealViewController *revealController = self.revealViewController;
      ProfileViewController *profilViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
      UIViewController *newFrontController = profilViewController;
      UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newFrontController];
      [revealController pushFrontViewController:navigationController animated:YES];
    }
    else
    {
      [RKDropdownAlert title:@"INFORMATION" message:errorMsg];
    }
  }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  // Get the new view controller using [segue destinationViewController].
  // Pass the selected object to the new view controller.
  
  if ([segue.identifier isEqualToString:@"profile_segue"])
  {
    ProfileViewController *profileVC = segue.destinationViewController;
    
    profileVC.profileImages = profileMediaImages;
    profileVC.profileMediaVideos = profileMediaVideos;
    profileVC.profileProjects = profileProjects;
    profileVC.profileImageName = profileImageName;
    //profileVC.profileImageName = profileImageName;
  }
}


@end
