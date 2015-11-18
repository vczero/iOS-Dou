//
//  BookDetailViewController.m
//  iOS-Dou
//
//  Created by lihua on 15/11/17.
//  Copyright (c) 2015年 lihua. All rights reserved.
//

#import "BookDetailViewController.h"

@interface BookDetailViewController ()

@end

@implementation BookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    
    //书名
    UILabel *bookLabel = [[UILabel alloc] init];
    bookLabel.frame = CGRectMake(10 + 10, 30, 200, 30);
    bookLabel.text = @"C语言程序设计";
    bookLabel.font = [UIFont fontWithName:@"Heiti TC" size:14];
    bookLabel.textColor = [UIColor blackColor];
    [self.view addSubview:bookLabel];
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] init];
    backBtn.title = @"图书";
    self.navigationItem.backBarButtonItem = backBtn;
    [self.navigationController setNavigationBarHidden:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)NavigationToMainView{
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController popViewControllerAnimated:YES];
}




@end
