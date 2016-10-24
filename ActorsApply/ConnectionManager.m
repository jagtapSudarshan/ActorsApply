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

+(void)callPutMethod:(NSString *)path Data:(NSString*)userId   completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock
{
    AFHTTPSessionManager*manager = [AFHTTPSessionManager manager];
    [manager setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"authorization"] forHTTPHeaderField:@"Authorization"];
    [manager PUT:path parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
    
    [manager.requestSerializer setValue:auth forHTTPHeaderField:@"Authorization"];
    [manager GET:urlstr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        completionBlock(YES,responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        completionBlock(NO,nil,error.localizedDescription);
        
    }];
}


@end
