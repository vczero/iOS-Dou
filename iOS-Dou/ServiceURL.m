//
//  ServiceURL.m
//  iOS-Dou
//
//  Created by lihua on 15/11/16.
//  Copyright (c) 2015年 lihua. All rights reserved.
//

#import "ServiceURL.h"

@implementation ServiceURL{
}

//获取数据
+ (void) getData:(NSString *)urlStr completion:(void (^)(NSError *error,id data))completion{
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        if(error){
            NSLog(@"%@", error);
            completion(error, nil);
        }else{
            NSError *parseError;
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            if (parseError) {
                completion(parseError, nil);
            } else {
                completion(nil, json);
            }
            
        }
    }];
    
}


/*
 //图书搜索
 book_search = @"https://api.douban.com/v2/book/search";
 //图书详情
 book_search_id = @"https://api.douban.com/v2/book/",
 //音乐搜索
 music_search = @"https://api.douban.com/v2/music/search";
 //音乐详情
 music_search_id = @"https://api.douban.com/v2/music/";
 //电影搜索
 movie_search = @"https://api.douban.com/v2/movie/search";
 //电影详情
 movie_search_id = @"https://api.douban.com/v2/movie/subject/";
 */

+ (NSString*) getBookSearchURL{
    return @"https://api.douban.com/v2/book/search";
}

+ (NSString*) getBookDetailURL{
    return  @"https://api.douban.com/v2/book/";
}

+ (NSString*) getMusicSearchURL{
    return @"https://api.douban.com/v2/music/search";
}

+ (NSString*) getMusicDetailURL{
    return  @"https://api.douban.com/v2/music/";
}

+ (NSString*) getMovieSearchURL{
    return @"https://api.douban.com/v2/movie/search";
}

+ (NSString*) getMovieDetailURL{
    return  @"https://api.douban.com/v2/movie/subject/";
}

@end
