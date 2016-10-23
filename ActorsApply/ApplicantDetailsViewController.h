//
//  ApplicantDetailsViewController.h
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/20/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewApplicant.h"
#import "SuperViewController.h"
@interface ApplicantDetailsViewController : SuperViewController

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblType;
@property (weak, nonatomic) IBOutlet UILabel *lblIndustry;
@property (weak, nonatomic) IBOutlet UILabel *lblDirector;

@property (weak, nonatomic) IBOutlet UILabel *lblRoleDesc;
@property (weak, nonatomic) IBOutlet UILabel *locationDetailsLbl;

@property (strong, nonatomic) ViewApplicant *viewApplicant;

@property (strong, nonatomic) NSString *typeImageName;

@property (weak, nonatomic) IBOutlet UICollectionView *cvV;

@end
