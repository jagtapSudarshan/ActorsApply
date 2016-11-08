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
    NSURL *url=[NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    // Create request.
    NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc] init];
    [theRequest setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [theRequest setHTTPShouldHandleCookies:NO];
    [theRequest setTimeoutInterval:30];
    [theRequest setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [theRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // Add image data.
    NSData *imageData = UIImageJPEGRepresentation(img, 1.0);
    NSMutableData *body = [NSMutableData new];
    
    [body appendData:imageData];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
   
    if (imageData)
    {
        [body appendData:[[NSString stringWithFormat:@"%@", @"Content-Disposition: form-data; name=\"userfile\""] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [theRequest setHTTPBody:body];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [theRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    // Set URL
    [theRequest setURL:url];
   // NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
   // [connection start];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject];
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:theRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //
        if (data) {
            NSHTTPURLResponse * httpResponse  = (NSHTTPURLResponse*)response;
            NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            NSInteger statusCode = httpResponse.statusCode;
            if (statusCode == 200) {
                //PERFORM YOUR OPERATIONS
            }
        }else if (error)
        {
            NSLog(@"Errorrrrrrr....");
        }
    }];
    [dataTask resume];
    
//    AFHTTPSessionManager*manager = [AFHTTPSessionManager manager];
//    [manager setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
//    [manager.requestSerializer setValue:@"application/uploadfile" forHTTPHeaderFild:@"Accept"];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//	NSString * timestamp =   [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970] * 1000];
//	//[manager.requestSerializer setValue:[NSString stringWithFormat:@"%@.png",timestamp]  forHTTPHeaderField:imgName];
//	[manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"authorization"] forHTTPHeaderField:@"Authorization"];
//    NSDictionary *parameters = @{@"userfile":img};
//    
//    [manager POST:path parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSData *imageData = UIImageJPEGRepresentation(img, 0.4);
//        //[formData appendPartWithFileData:imageData name:@"userfile" fileName:[NSString stringWithFormat:@"%@.png",timestamp] mimeType:@"image/png"];
//        //[formData appendPartWithFormData:imageData name:@"userfile"];
//        NSError *error;
//        [formData appendPartWithFileURL:[NSURL URLWithString:imgName] name:@"userfile" error:&error];
//
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSMutableDictionary *dict=[responseObject mutableCopy];
//        [dict setValue:[NSString stringWithFormat:@"%@.png",timestamp] forKey:@"imgName"];
//        completionBlock(YES,dict,nil);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        completionBlock(NO,nil,error.localizedDescription);
//    }];
//
//    [manager POST:path parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSData *imageData = UIImageJPEGRepresentation(img, 0.4);
//        
//        [formData appendPartWithFileData:imageData name:@"userfile" fileName:[NSString stringWithFormat:@"%@.png",timestamp] mimeType:@"image/png"];
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        NSMutableDictionary *dict=[responseObject mutableCopy];
//       [dict setValue:[NSString stringWithFormat:@"%@.png",timestamp] forKey:@"imgName"];
//        completionBlock(YES,dict,nil);
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        completionBlock(NO,nil,error.localizedDescription);
//    }];
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
    
    [manager GET:urlstr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
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
