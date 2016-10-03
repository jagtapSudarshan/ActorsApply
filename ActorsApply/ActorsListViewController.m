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

@interface ActorsListViewController ()
{
    NSMutableArray *data;
}
@end

@implementation ActorsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backClcicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.collectionRecomended)
    {
        return 5;
    }
    else
    {
        return 15;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.collectionRecomended)
    {
        RecomendedActorsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecomendedActorsCollectionViewCell" forIndexPath:indexPath];
        return cell;
    }
    else
    {
        ActorsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ActorsCollectionViewCell" forIndexPath:indexPath];
        return cell;
    }
}

-(void)getActorsList
{
    [SVProgressHUD show];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,GET_APPLICATIONS];
    
    [ConnectionManager callGetMethod:url completionBlock:^(BOOL succeeded, id responseData, NSString *errorMsg) {
        
        [SVProgressHUD dismiss];
        
        if (succeeded)
        {
            data = [responseData objectForKey:@"data"];
            
            for (NSMutableDictionary *dict in data) {
                ActorList *vo = [ActorList new];
                vo.actorid = [dict objectForKey:@"id"];
                vo.role_id = [dict objectForKey:@"role_id"];
                vo.project_id = [dict objectForKey:@"project_id"];
                vo.user_id = [dict objectForKey:@"user_id"];
                vo.asset_id = [dict objectForKey:@"asset_id"];
                vo.asset_id2 = [dict objectForKey:@"asset_id2"];
                vo.shortlisted = [dict objectForKey:@"shortlisted"];
                vo.status = [dict objectForKey:@"status"];
                vo.created = [dict objectForKey:@"created"];
                vo.modified = [dict objectForKey:@"modified"];
                [data addObject:vo];
            }
        }
        else
        {
            [RKDropdownAlert title:@"INFORMATION" message:errorMsg];
        }
    }];
}

@end
