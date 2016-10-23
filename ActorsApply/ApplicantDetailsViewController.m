//
//  ApplicantDetailsViewController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/20/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "ApplicantDetailsViewController.h"
#import "VerticalCollectionViewCell.h"
#import "ActorsListViewController.h"
@interface ApplicantDetailsViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
 UICollectionView *_collectionView;
  ViewApplicant *mainApplicant;
  ViewApplicant *subApplicant;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ApplicantDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.lblName.text = self.viewApplicant.name;
    self.lblIndustry.text = [self getIndustryNameFromId:[self.viewApplicant.industry integerValue]];
    self.lblDirector.text = self.viewApplicant.casting_director;
  if ( self.viewApplicant.location == nil ||  self.viewApplicant.location == (id)[NSNull null]) {
     self.locationDetailsLbl.text = @"Location not given";
  } else {
     self.locationDetailsLbl.text = self.viewApplicant.location;
  }  
    self.lblRoleDesc.text = self.viewApplicant.vwAppdesc;
    [self.lblRoleDesc sizeToFit];
  UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
  CGFloat width = [UIScreen mainScreen].bounds.size.width;
  flow.itemSize = CGSizeMake(width/3-10, 55);
  flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.minimumInteritemSpacing = 0;
    flow.minimumLineSpacing = 0;
  self.cvV.collectionViewLayout = flow;

  _lblType.text = [self castingType:[self.viewApplicant.type integerValue]];
  _imageView.image = [UIImage imageNamed:_typeImageName];
}

- (IBAction)backClcicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*)getIndustryNameFromId : (NSInteger)industryId
{
    switch (industryId) {
        case 0:
            return @"Hindi";
            break;
        case 1:
            return @"English";
            break;
        case 2:
            return @"Telugu";
            break;
        case 3:
            return @"Malyalam";
            break;
        case 4:
            return @"Tamil";
            break;
        case 5:
            return @"Punjabi";
            break;
        case 6:
            return @"Gujrati";
            break;
        case 7:
            return @"Bengali";
            break;
        case 8:
            return @"Marathi";
            break;
        case 9:
            return @"Bhojpuri";
            break;
        case 10:
            return @"Other";
            break;
        default:
            break;
    }
    return nil;
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
    return self.viewApplicant.roles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VerticalCollectionViewCell *vc = nil;
    vc = (VerticalCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"test1" forIndexPath:indexPath];
    vc.Txtlbl.text =[[self.viewApplicant.roles objectAtIndex:indexPath.row] valueForKey:@"name"];
    vc.Txtlbl.backgroundColor = [UIColor clearColor];
    vc.Txtlbl.textColor = [UIColor blackColor];
    vc.Txtlbl.layer.borderColor = [UIColor orangeColor].CGColor;
    vc.Txtlbl.layer.borderWidth = 1.5f;
    return vc;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  subApplicant = [[ViewApplicant alloc]init];
  subApplicant.viewApplicantId = [[self.viewApplicant.roles objectAtIndex:indexPath.row]valueForKey:@"id"];
  subApplicant.user_id = [[self.viewApplicant.roles objectAtIndex:indexPath.row]valueForKey:@""];
  subApplicant.name = [[self.viewApplicant.roles objectAtIndex:indexPath.row]valueForKey:@"name"];
  subApplicant.type = [[self.viewApplicant.roles objectAtIndex:indexPath.row]valueForKey:@"type"];
  subApplicant.vwAppdesc = [[self.viewApplicant.roles objectAtIndex:indexPath.row]valueForKey:@"desc"];
  subApplicant.location = [[self.viewApplicant.roles objectAtIndex:indexPath.row]valueForKey:@"location"];
  subApplicant.roleCount = [[self.viewApplicant.roles objectAtIndex:indexPath.row]valueForKey:@""];
  subApplicant.applicationCount = [[self.viewApplicant.roles objectAtIndex:indexPath.row]valueForKey:@""];
  subApplicant.castingDate = [[self.viewApplicant.roles objectAtIndex:indexPath.row]valueForKey:@""];
  subApplicant.shootingDate = [[self.viewApplicant.roles objectAtIndex:indexPath.row]valueForKey:@""];
  subApplicant.industry = [[self.viewApplicant.roles objectAtIndex:indexPath.row]valueForKey:@""];
  subApplicant.casting_director = [[self.viewApplicant.roles objectAtIndex:indexPath.row]valueForKey:@""];
  subApplicant.director = [[self.viewApplicant.roles objectAtIndex:indexPath.row]valueForKey:@""];
  subApplicant.status = [[self.viewApplicant.roles objectAtIndex:indexPath.row]valueForKey:@""];
  subApplicant.application_count = [[self.viewApplicant.roles objectAtIndex:indexPath.row]valueForKey:@""];
  subApplicant.created = [[self.viewApplicant.roles objectAtIndex:indexPath.row]valueForKey:@"created"];
  subApplicant.modified = [[self.viewApplicant.roles objectAtIndex:indexPath.row]valueForKey:@"modified"];
    
//NSString *projectId = projectId;
    
  [self performSegueWithIdentifier:@"AppDetailToPhotos" sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if([segue.identifier isEqualToString:@"AppDetailToPhotos"])
  {
    ActorsListViewController *vc = segue.destinationViewController;
    vc.mainApplicant = self.viewApplicant;
    vc.subApplicant = subApplicant;
    vc.typeImageName = [self getImageFromType:[vc.mainApplicant.type integerValue]];
  }
}

@end
