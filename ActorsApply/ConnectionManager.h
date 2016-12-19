//
//  ConnectionManager.h
//  StarRateApp
//
//  Created by Anand Mahajan on 07/04/15.
//  Copyright (c) 2015 Anand Mahajan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "NSURLSession.h"

@interface ConnectionManager : NSObject<NSURLSessionDelegate,NSURLSessionDataDelegate>

+(void)callLoginPostMethod:(NSString *)path Data:(NSDictionary*)dict   completionBlock:(void (^)(BOOL succeeded, id responseData ,NSString* errorMsg))completionBlock;

+(void)callPostMethod:(NSString *)path Data:(NSDictionary*)dict completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock;

+(void)callPostThroughBodyMethod:(NSString *)path Data:(NSString*)userId   completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock;

+(void)callPostUpdateKYCMethod:(NSString *)path Data:(NSDictionary*)dict  completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock;

+(void)callPostMassmaNoticeMethod:(NSString *)path Data:(NSString*)userId   completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock;

+(void)callGetMethod:(NSString *) urlstr completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock;

+(void)uploadimage:(UIImage *)img Path:(NSString *)path imggName:(NSString*)imgName completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock;

+(void)callPutMethod:(NSString *)path Data:(NSString*)userId   completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock;

+(void)callDeleteMethod:(NSString *)path completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock;

+(void)callAddProjectPostMethod:(NSString *)path Data:(NSMutableArray*)data completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock;

+(void)callPutProjectMethod:(NSString *)path Data:(NSDictionary*)data completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock;

+(void)uploadVideo:(NSString *)path videoPath:(NSString*)videoPath completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock;

+(void)callFBLoginPostMethod:(NSString *)path Data:(NSDictionary*)dict   completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock;

@end
