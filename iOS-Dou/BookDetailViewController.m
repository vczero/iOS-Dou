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

}

-(void)backItemClick:(id)sender{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你点击了导航栏左按钮" delegate:self  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
