//
//  WebView.m
//  iOS-Dou
//
//  Created by lihua on 15/12/1.
//  Copyright (c) 2015年 lihua. All rights reserved.
//

#import "DWebView.h"

@interface DWebView (){
    UIActivityIndicatorView *_act;
}

@end

@implementation DWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.showTitle;
    
    UIWebView *webView = [[UIWebView alloc]init];
    webView.delegate = self;
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
    if (_act.isAnimating) {
        return;
    }
    if (!_act) {
        _act = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _act.center = self.view.center;
        _act.hidesWhenStopped = YES;
        _act.color = [UIColor colorWithRed:0.000 green:0.525 blue:0.992 alpha:1];
        [self.view addSubview:_act];
    }
    [_act startAnimating];
    
}

- (void) webViewDidFinishLoad:(UIWebView *)webView{
    [_act stopAnimating];
}


@end
