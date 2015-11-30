//
//  Service.h
//  iOS-Dou
//
//  Created by lihua on 15/11/16.
//  Copyright (c) 2015年 lihua. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Service : NSObject{

}
//获取图书、电影、音乐数据
+ (void) getData:(NSString *)urlStr completion:(void (^)(NSError*,id data))completion;

+ (NSString*) getBookSearchURL;
+ (NSString*) getBookDetailURL;

+ (NSString*) getMusicSearchURL;
+ (NSString*) getMusicDetailURL;

+ (NSString*) getMovieSearchURL;
+ (NSString*) getMovieDetailURL;


@end
