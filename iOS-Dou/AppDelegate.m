//
//  AppDelegate.m
//  iOS-Dou
//
//  Created by lihua on 15/11/16.
//  Copyright (c) 2015年 lihua. All rights reserved.
//

#import "AppDelegate.h"
#import "BookViewController.h"
#import "MovieViewController.h"
#import "MusicViewController.h"

@interface AppDelegate ()

@property(strong, nonatomic) UITabBarController *tabBarController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    if(!self.window){
        self.window = [[UIWindow alloc]init];
    }
    self.window.frame = [[UIScreen mainScreen]bounds];
    self.tabBarController = [[UITabBarController alloc] init];
    
    BookViewController *bookViewController = [BookViewController new];
    bookViewController.view.backgroundColor = [UIColor whiteColor];
    bookViewController.tabBarItem.title = @"图书";
    bookViewController.tabBarItem.image = [UIImage imageNamed:@"book"];
    bookViewController.tabBarItem.badgeValue = @"5";
    UINavigationController *bookNav = [[UINavigationController alloc]initWithRootViewController:bookViewController];
    
    
    MovieViewController *movieViewController = [MovieViewController new];
    movieViewController.view.backgroundColor = [UIColor whiteColor];
    movieViewController.tabBarItem.title = @"电影";
    movieViewController.tabBarItem.image = [UIImage imageNamed:@"movie"];
    UINavigationController *moviewNav = [[UINavigationController alloc]initWithRootViewController:movieViewController];
    
    MusicViewController *musicViewController = [MusicViewController new];
    musicViewController.view.backgroundColor = [UIColor whiteColor];
    musicViewController.tabBarItem.title = @"音乐";
    musicViewController.tabBarItem.image = [UIImage imageNamed:@"music"];
    UINavigationController *musicNav = [[UINavigationController alloc]initWithRootViewController:musicViewController];
    
    //设置TabBar的颜色
    int width = [[UIScreen mainScreen] applicationFrame].size.width;
    UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 49)];
    blackView.backgroundColor = [UIColor blackColor];
    
    
    [self.tabBarController.tabBar insertSubview:blackView atIndex:0];
    self.tabBarController.tabBar.opaque = YES;
   
    self.tabBarController.viewControllers=@[bookNav, moviewNav, musicNav];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

//禁止横屏
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    return UIInterfaceOrientationMaskPortrait;
}

@end
