//
//  ConnectionManager.h
//  StarRateApp
//
//  Created by Anand Mahajan on 07/04/15.
//  Copyright (c) 2015 Anand Mahajan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ConnectionManager : NSObject
+(void)callLoginPostMethod:(NSString *)path Data:(NSDictionary*)dict   completionBlock:(void (^)(BOOL succeeded, id responseData ,NSString* errorMsg))completionBlock;

+(void)callPostMethod:(NSString *)path Data:(NSDictionary*)dict completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock;

+(void)callPostThroughBodyMethod:(NSString *)path Data:(NSString*)userId   completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock;

+(void)callPostUpdateKYCMethod:(NSString *)path Data:(NSDictionary*)dict  completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock;

+(void)callPostMassmaNoticeMethod:(NSString *)path Data:(NSString*)userId   completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock;

+(void)callGetMethod:(NSString *) urlstr completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock;

+(void)uploadimage:(UIImage *)img Path:(NSString *)path Data:(NSDictionary*)dict imggName:(NSString*)imgName completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock;

+(void)callPutMethod:(NSString *)path Data:(NSString*)userId   completionBlock:(void (^)(BOOL succeeded, id  responseData ,NSString* errorMsg))completionBlock;

@end
