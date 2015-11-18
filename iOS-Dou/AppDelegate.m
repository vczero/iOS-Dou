//
//  AppDelegate.m
//  iOS-Dou
//
//  Created by lihua on 15/11/16.
//  Copyright (c) 2015年 lihua. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
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
    [bookNav setNavigationBarHidden:YES];
    
    
    MovieViewController *movieViewController = [MovieViewController new];
    movieViewController.view.backgroundColor = [UIColor whiteColor];
    movieViewController.tabBarItem.title = @"电影";
    movieViewController.tabBarItem.image = [UIImage imageNamed:@"movie"];
    UINavigationController *moviewNav = [[UINavigationController alloc]initWithRootViewController:movieViewController];
    [moviewNav setNavigationBarHidden:YES];
    
    MusicViewController *musicViewController = [MusicViewController new];
    musicViewController.view.backgroundColor = [UIColor whiteColor];
    musicViewController.tabBarItem.title = @"音乐";
    musicViewController.tabBarItem.image = [UIImage imageNamed:@"music"];
    UINavigationController *musicNav = [[UINavigationController alloc]initWithRootViewController:musicViewController];
    [musicNav setNavigationBarHidden:YES];
    
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
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//禁止横屏
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    return UIInterfaceOrientationMaskPortrait;
}

@end
