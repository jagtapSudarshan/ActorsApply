//
//  ConnectionManager.m
//  StarRateApp
//
//  Created by Anand Mahajan on 07/04/15.
//  Copyright (c) 2015 Anand Mahajan. All rights reserved.
//

#import "ConnectionManager.h"
#import <AFNetworking.h>
@implementation ConnectionManager

#pragma mark Post Method

+(void)callLoginPostMethod:(NSString *)path Data:(NSDictionary*)dict   completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock
{
    AFHTTPSessionManager*manager = [AFHTTPSessionManager manager];
    [manager setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:path parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
         //completionBlock(YES,responseObject,nil);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         completionBlock(YES,responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         completionBlock(NO,error.localizedDescription,nil);
    }];
}


+(void)callPostMethod:(NSString *)path Data:(NSDictionary*)dict completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock
{
    AFHTTPSessionManager*manager = [AFHTTPSessionManager manager];
    [manager setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"authorization"] forHTTPHeaderField:@"Authorization"];
    [manager POST:path parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        //completionBlock(YES,responseObject,nil);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionBlock(YES,responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionBlock(NO,error.localizedDescription,nil);
    }];
  
}


+(void)callPostThroughBodyMethod:(NSString *)path Data:(NSString*)userId completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock
{
    AFHTTPSessionManager*manager = [AFHTTPSessionManager manager];
    [manager setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone]];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"authorization"] forHTTPHeaderField:@"Authorization"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:@"http://massma.in/apps-getting-all-images.php" parameters:[NSDictionary dictionaryWithObject:userId forKey:@"id"] success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        completionBlock(YES,responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         completionBlock(NO,nil,error.localizedDescription);
    }];
}

+(void)callPostMassmaNoticeMethod:(NSString *)path Data:(NSString*)userId   completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock
{
    AFHTTPSessionManager*manager = [AFHTTPSessionManager manager];
    [manager setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone]];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:userId forHTTPHeaderField:@"usr_id"];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:path parameters:[NSDictionary dictionaryWithObject:userId forKey:@"usr_id"] success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        completionBlock(YES,responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionBlock(NO,nil,error.localizedDescription);
    }];
}

+(void)callPostUpdateKYCMethod:(NSString *)path Data:(NSDictionary*)dict   completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock
{
    AFHTTPSessionManager*manager = [AFHTTPSessionManager manager];
    [manager setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone]];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:[dict valueForKey:@"fld_id"] forHTTPHeaderField:@"fld_id"];
    [manager.requestSerializer setValue:[dict valueForKey:@"comp_massma_id"] forHTTPHeaderField:@"comp_massma_id"];
    [manager.requestSerializer setValue:[dict valueForKey:@"comp_estd_id"] forHTTPHeaderField:@"comp_estd_id"];
    [manager.requestSerializer setValue:[dict valueForKey:@"comp_nm"] forHTTPHeaderField:@"comp_nm"];
    [manager.requestSerializer setValue:[dict valueForKey:@"comp_website"] forHTTPHeaderField:@"comp_website"];
    [manager.requestSerializer setValue:[dict valueForKey:@"comp_add"] forHTTPHeaderField:@"comp_add"];
    [manager.requestSerializer setValue:[dict valueForKey:@"comp_add2"] forHTTPHeaderField:@"comp_add2"];
    [manager.requestSerializer setValue:[dict valueForKey:@"comp_add3"] forHTTPHeaderField:@"comp_add3"];
    [manager.requestSerializer setValue:[dict valueForKey:@"comp_pincode"] forHTTPHeaderField:@"comp_pincode"];
    [manager.requestSerializer setValue:[dict valueForKey:@"comp_city"] forHTTPHeaderField:@"comp_city"];
    [manager.requestSerializer setValue:[dict valueForKey:@"comp_state"] forHTTPHeaderField:@"comp_state"];
    [manager.requestSerializer setValue:[dict valueForKey:@"company_email_id1"] forHTTPHeaderField:@"company_email_id1"];
    [manager.requestSerializer setValue:[dict valueForKey:@"company_email_id2"] forHTTPHeaderField:@"company_email_id2"];
    [manager.requestSerializer setValue:[dict valueForKey:@"company_email_id3"] forHTTPHeaderField:@"company_email_id3"];
    [manager.requestSerializer setValue:[dict valueForKey:@"company_email_id4"] forHTTPHeaderField:@"company_email_id4"];
    [manager.requestSerializer setValue:[dict valueForKey:@"contact_pers1_nm"] forHTTPHeaderField:@"contact_pers1_nm"];
    [manager.requestSerializer setValue:[dict valueForKey:@"contact_pers1_post"] forHTTPHeaderField:@"contact_pers1_post"];
    [manager.requestSerializer setValue:[dict valueForKey:@"contact_pers1_mobile"] forHTTPHeaderField:@"contact_pers1_mobile"];
    [manager.requestSerializer setValue:[dict valueForKey:@"contact_pers1_email"] forHTTPHeaderField:@"contact_pers1_email"];
    [manager.requestSerializer setValue:[dict valueForKey:@"contact_pers2_nm"] forHTTPHeaderField:@"contact_pers2_nm"];
    [manager.requestSerializer setValue:[dict valueForKey:@"contact_pers2_post"] forHTTPHeaderField:@"contact_pers2_post"];
    [manager.requestSerializer setValue:[dict valueForKey:@"contact_pers2_mobile"] forHTTPHeaderField:@"contact_pers2_mobile"];
    [manager.requestSerializer setValue:[dict valueForKey:@"contact_pers2_email"] forHTTPHeaderField:@"contact_pers2_email"];
    [manager.requestSerializer setValue:[dict valueForKey:@"contact_pers3_nm"] forHTTPHeaderField:@"contact_pers3_nm"];
    [manager.requestSerializer setValue:[dict valueForKey:@"contact_pers3_post"] forHTTPHeaderField:@"contact_pers3_post"];
    [manager.requestSerializer setValue:[dict valueForKey:@"contact_pers3_mobile"] forHTTPHeaderField:@"contact_pers3_mobile"];
    [manager.requestSerializer setValue:[dict valueForKey:@"contact_pers3_email"] forHTTPHeaderField:@"contact_pers3_email"];
    [manager.requestSerializer setValue:[dict valueForKey:@"contact_pers4_nm"] forHTTPHeaderField:@"contact_pers4_nm"];
    [manager.requestSerializer setValue:[dict valueForKey:@"contact_pers4_post"] forHTTPHeaderField:@"contact_pers4_post"];
    [manager.requestSerializer setValue:[dict valueForKey:@"contact_pers4_mobile"] forHTTPHeaderField:@"contact_pers4_mobile"];
    [manager.requestSerializer setValue:[dict valueForKey:@"contact_pers4_email"] forHTTPHeaderField:@"contact_pers4_email"];
    [manager.requestSerializer setValue:[dict valueForKey:@"company_hughes_1"] forHTTPHeaderField:@"company_hughes_1"];
    [manager.requestSerializer setValue:[dict valueForKey:@"company_hughes_2"] forHTTPHeaderField:@"company_hughes_2"];
    [manager.requestSerializer setValue:[dict valueForKey:@"company_hughes_3"] forHTTPHeaderField:@"company_hughes_3"];
    [manager.requestSerializer setValue:[dict valueForKey:@"company_hughes_4"] forHTTPHeaderField:@"company_hughes_4"];
    [manager.requestSerializer setValue:[dict valueForKey:@"company_mtnl_1"] forHTTPHeaderField:@"company_mtnl_1"];
    [manager.requestSerializer setValue:[dict valueForKey:@"company_mtnl_2"] forHTTPHeaderField:@"company_mtnl_2"];
    [manager.requestSerializer setValue:[dict valueForKey:@"company_fax"] forHTTPHeaderField:@"company_fax"];
    [manager.requestSerializer setValue:[dict valueForKey:@"company_vat_tin"] forHTTPHeaderField:@"company_vat_tin"];
    [manager.requestSerializer setValue:[dict valueForKey:@"company_cst_no"] forHTTPHeaderField:@"company_cst_no"];
    [manager.requestSerializer setValue:[dict valueForKey:@"company_excise_no"] forHTTPHeaderField:@"company_excise_no"];
    [manager.requestSerializer setValue:[dict valueForKey:@"comp_manufacturer"] forHTTPHeaderField:@"comp_manufacturer"];
    [manager.requestSerializer setValue:[dict valueForKey:@"comp_broker"] forHTTPHeaderField:@"comp_broker"];
    [manager.requestSerializer setValue:[dict valueForKey:@"comp_supplier"] forHTTPHeaderField:@"comp_supplier"];
    [manager.requestSerializer setValue:[dict valueForKey:@"comp_importer"] forHTTPHeaderField:@"comp_importer"];
    [manager.requestSerializer setValue:[dict valueForKey:@"comp_exporter"] forHTTPHeaderField:@"comp_exporter"];
    [manager.requestSerializer setValue:[dict valueForKey:@"comp_stockist"] forHTTPHeaderField:@"comp_stockist"];
    [manager.requestSerializer setValue:[dict valueForKey:@"comp_dealer"] forHTTPHeaderField:@"comp_dealer"];
    [manager.requestSerializer setValue:[dict valueForKey:@"comp_others"] forHTTPHeaderField:@"comp_others"];
    [manager.requestSerializer setValue:[dict valueForKey:@"company_fact_add"] forHTTPHeaderField:@"company_fact_add"];
    [manager.requestSerializer setValue:[dict valueForKey:@"company_fact_add2"] forHTTPHeaderField:@"company_fact_add2"];
    [manager.requestSerializer setValue:[dict valueForKey:@"company_fact_add3"] forHTTPHeaderField:@"company_fact_add3"];
    [manager.requestSerializer setValue:[dict valueForKey:@"company_fact_add4"] forHTTPHeaderField:@"company_fact_add4"];
    [manager.requestSerializer setValue:[dict valueForKey:@"company_fb_links"] forHTTPHeaderField:@"company_fb_links"];
    [manager.requestSerializer setValue:[dict valueForKey:@"company_twitter_links"] forHTTPHeaderField:@"company_twitter_links"];
    [manager.requestSerializer setValue:[dict valueForKey:@"company_google_plus_links"] forHTTPHeaderField:@"company_google_plus_links"];
    [manager.requestSerializer setValue:[dict valueForKey:@"company_skype_links"] forHTTPHeaderField:@"company_skype_links"];
    [manager.requestSerializer setValue:[dict valueForKey:@"company_about_us"] forHTTPHeaderField:@"company_about_us"];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:path parameters:dict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        completionBlock(YES,responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionBlock(NO,nil,error.localizedDescription);
    }];
}


+(void)uploadimage:(UIImage *)img Path:(NSString *)path Data:(NSDictionary*)dict imggName:(NSString*)imgName completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock
{
    AFHTTPSessionManager*manager = [AFHTTPSessionManager manager];
    [manager setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
 
	NSString * timestamp =   [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970] * 1000];
	[manager.requestSerializer setValue:[NSString stringWithFormat:@"%@.png",timestamp]  forHTTPHeaderField:imgName];
	
    [manager POST:path parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(img, 0.4);
        
        [formData appendPartWithFileData:imageData name:imgName fileName:[NSString stringWithFormat:@"%@.png",timestamp] mimeType:@"image/png"];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSMutableDictionary *dict=[responseObject mutableCopy];
       [dict setValue:[NSString stringWithFormat:@"%@.png",timestamp] forKey:@"imgName"];
        completionBlock(YES,dict,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionBlock(NO,nil,error.localizedDescription);
        
    }];
}

#pragma mark Get Method

+(void)callGetMethod:(NSString *) urlstr completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock
{
    AFHTTPSessionManager*manager = [AFHTTPSessionManager manager];
    [manager setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *auth = [[NSUserDefaults standardUserDefaults] objectForKey:@"authorization"];
    NSLog(@"%@",auth);
    
    [manager.requestSerializer setValue:auth forHTTPHeaderField:@"authorization"];
    [manager GET:urlstr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        completionBlock(YES,responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        completionBlock(NO,nil,error.localizedDescription);
        
    }];
}


@end
