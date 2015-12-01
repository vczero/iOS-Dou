//
//  MusicViewController.m
//  iOS-Dou
//
//  Created by lihua on 15/11/16.
//  Copyright (c) 2015年 lihua. All rights reserved.
//

#import "MusicViewController.h"

@interface MusicViewController ()
@property UITextField *searchInput;
@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"音乐";
    int btnWidth = 60;
    int searchHeight = 40;
    int statusHieght = 30;
    int screenWidth = [[UIScreen mainScreen]bounds].size.width;
    int screenHeight = [[UIScreen mainScreen]bounds].size.height;
    int inputWidth = screenWidth - 20 - btnWidth;
    self.searchInput = [[UITextField alloc] init];
    self.searchInput.frame = CGRectMake(10, statusHieght, inputWidth, searchHeight);
    [self.searchInput setBorderStyle: UITextBorderStyleRoundedRect];
    self.searchInput.placeholder = @"请输入音乐的名称";
    
    UIButton *searchBtn = [[UIButton alloc]init];
    searchBtn.frame = CGRectMake(inputWidth + 5, statusHieght, btnWidth, searchHeight);
    searchBtn.backgroundColor = [UIColor colorWithRed:0.000 green:0.569 blue:1.000 alpha:1];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitle:@"搜索" forState:UIControlStateHighlighted];
    [searchBtn addTarget:self action:@selector(searchBooK:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.searchInput];
    [self.view addSubview:searchBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
