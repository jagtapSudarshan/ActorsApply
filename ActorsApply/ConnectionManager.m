//
//  ConnectionManager.m
//  StarRateApp
//
//  Created by Anand Mahajan on 07/04/15.
//  Copyright (c) 2015 Anand Mahajan. All rights reserved.
//

#import "ConnectionManager.h"
#import "AFNetworking.h"

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
        if(error.code == 404)
        {
           completionBlock(NO,nil,@"The username or password is not correct.");
        }
        else{
        NSLog(@"ERROR::::%ld",(long)error.code);
        completionBlock(NO,nil,error.localizedDescription);
        }
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

+(void)callAddProjectPostMethod:(NSString *)path Data:(NSMutableArray*)data completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock
{
    AFHTTPSessionManager*manager = [AFHTTPSessionManager manager];
    [manager setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone]];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"authorization"] forHTTPHeaderField:@"Authorization"];
    
    [manager POST:path parameters:data progress:^(NSProgress * _Nonnull uploadProgress) {
        //completionBlock(YES,responseObject,nil);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionBlock(YES,responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionBlock(NO,error.localizedDescription,nil);
    }];
}

+(void)callDeleteMethod:(NSString *)path completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock
{
    AFHTTPSessionManager*manager = [AFHTTPSessionManager manager];
    [manager setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"authorization"] forHTTPHeaderField:@"Authorization"];
    
    [manager DELETE:path parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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

+(void)callPutProjectMethod:(NSString *)path Data:(NSDictionary*)data completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock
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

+(void)uploadimage:(UIImage *)img Path:(NSString *)path imggName:(NSString*)imgName completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock
{
    AFHTTPSessionManager*manager = [AFHTTPSessionManager manager];
    [manager setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
	NSString * timestamp =  [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970] * 1000];
	[manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"authorization"] forHTTPHeaderField:@"Authorization"];
    
    [manager POST:path parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(img, 0.4);
        [formData appendPartWithFileData:imageData name:@"userFiles[]" fileName:[NSString stringWithFormat:@"%@.png",timestamp] mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary *dict=[responseObject mutableCopy];
        [dict setValue:[NSString stringWithFormat:@"%@.jpeg",timestamp] forKey:@"imgName"];
        completionBlock(YES,dict,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionBlock(NO,nil,error.localizedDescription);
    }];
}

+(void)uploadVideo:(NSString *)path videoPath:(NSString*)videoPath completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock
{
    AFHTTPSessionManager*manager = [AFHTTPSessionManager manager];
    [manager setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSURL *urlPath = [NSURL URLWithString:videoPath];
    NSData *data = [NSData dataWithContentsOfURL:urlPath];
    
    NSString * timestamp =  [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970] * 1000];
    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"authorization"] forHTTPHeaderField:@"Authorization"];
    
    [manager POST:path parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (data)
        {
            [formData appendPartWithFileData:data name:@"userFiles[]" fileName:[NSString stringWithFormat:@"%@.mov",timestamp] mimeType:@"video/quicktime"];
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary *dict=[responseObject mutableCopy];
        [dict setValue:[NSString stringWithFormat:@"%@.jpeg",timestamp] forKey:@"imgName"];
        completionBlock(YES,dict,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionBlock(NO,nil,error.localizedDescription);
    }];
}


- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error
{
 
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Received String %@",str);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{

  
}


#pragma mark Get Method

+(void)callGetMethod:(NSString *) urlstr completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock
{
    AFHTTPSessionManager*manager = [AFHTTPSessionManager manager];
    [manager setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    NSString *auth = [[NSUserDefaults standardUserDefaults] objectForKey:@"authorization"];
    NSLog(@"%@",auth);
    
    [manager.requestSerializer setValue:auth forHTTPHeaderField:@"Authorization"];
    
    [manager GET:[[NSUserDefaults standardUserDefaults] objectForKey:@"authorization"] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        completionBlock(YES,responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        NSString *errorCode;
        if(error.code == 3840)
        {
            errorCode = @"No mails here.";
            completionBlock(NO,nil,errorCode);
        }else{
            completionBlock(NO,nil,error.localizedDescription);
        }
    }];
}

@end
