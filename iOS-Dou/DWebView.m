//
//  WebView.m
//  iOS-Dou
//
//  Created by lihua on 15/12/1.
//  Copyright (c) 2015年 lihua. All rights reserved.
//

#import "DWebView.h"

@interface DWebView (){
}

@end

@implementation DWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.movieTitle;
    
    UIWebView *webView = [[UIWebView alloc]init];
    float width = [[UIScreen mainScreen]bounds].size.width;
    float height = [[UIScreen mainScreen]bounds].size.height;
    webView.frame = CGRectMake(0, 0, width, height);
    
    NSURL *url =[NSURL URLWithString:self.url];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"%@", @"----------");
}

- (void) webViewDidFinishLoad:(UIWebView *)webView{

}


@end
