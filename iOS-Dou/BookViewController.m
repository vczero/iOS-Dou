//
//  RootViewController.m
//  iOS-Dou
//
//  Created by lihua on 15/11/16.
//  Copyright (c) 2015年 lihua. All rights reserved.
//

#import "BookViewController.h"
#import "ServiceURL.h"
#import "BookDetailViewController.h"

@interface BookViewController ()

@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图书";
    int btnWidth = 60;
    int searchHeight = 40;
    int statusHieght = 30;
    int screenWidth = [[UIScreen mainScreen]bounds].size.width;
    int screenHeight = [[UIScreen mainScreen]bounds].size.height;
    int inputWidth = screenWidth - 20 - btnWidth;
    UITextField *searchInput = [[UITextField alloc] init];
    searchInput.frame = CGRectMake(10, statusHieght+40, inputWidth, searchHeight);
    [searchInput setBorderStyle: UITextBorderStyleRoundedRect];
    
    UIButton *searchBtn = [[UIButton alloc]init];
    searchBtn.frame = CGRectMake(inputWidth + 5, statusHieght+40, btnWidth, searchHeight);
    searchBtn.backgroundColor = [UIColor colorWithRed:0.000 green:0.569 blue:1.000 alpha:1];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitle:@"搜索" forState:UIControlStateHighlighted];
    
    [self.view addSubview:searchInput];
    [self.view addSubview:searchBtn];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, statusHieght + searchHeight + 50, screenWidth, screenHeight - statusHieght - searchHeight);
    scrollView.scrollEnabled = YES;
    int viewHeight = 100;
    int blockHieght = viewHeight + 20;
    scrollView.contentSize = CGSizeMake(screenWidth, (blockHieght + 5) * 10);
    
//    UIActivityIndicatorView* activityIndicatorView = [ [ UIActivityIndicatorView alloc ]
//                                                      initWithFrame:CGRectMake(100,200,30,30)];
//    activityIndicatorView.activityIndicatorViewStyle= UIActivityIndicatorViewStyleGray;
//    [activityIndicatorView startAnimating];
    
    //请求数据
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", [ServiceURL getBookSearchURL],@"?count=10&q=C语言"];
    [ServiceURL getData:urlStr completion:^(NSError * error, id data) {
        if(!error){
            for(int i = 0; i < [data[@"books"] count]; i++){
                //列表
                int bookImgWidth = 80;
                UIView *item = [[UIView alloc]init];
                item.frame = CGRectMake(0, 0 + (blockHieght * i) , screenWidth, blockHieght);
                CALayer *topBorder = [CALayer layer];
                topBorder.frame = CGRectMake(0.0f, 0.0f, item.frame.size.width, 1.0f);
                topBorder.backgroundColor = [UIColor colorWithRed:0.914 green:0.906 blue:0.914 alpha:1].CGColor;
                [item.layer addSublayer:topBorder];
                
                UIImageView *imgView = [[UIImageView alloc] init];
                NSURL *bookPhotoURL = [NSURL URLWithString:@"https://img1.doubanio.com/mpic/s1106934.jpg"];
                UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:bookPhotoURL]];
                imgView.image = img;
                imgView.frame = CGRectMake(10, 10, bookImgWidth, viewHeight);
                //按最大值自适应
                imgView.contentMode = UIViewContentModeScaleAspectFit;
                [item addSubview:imgView];
                
                //书名
                UILabel *bookLabel = [[UILabel alloc] init];
                bookLabel.frame = CGRectMake(bookImgWidth + 10, 0, 200, 30);
                bookLabel.text = @"C语言程序设计";
                bookLabel.font = [UIFont fontWithName:@"Heiti TC" size:14];
                bookLabel.textColor = [UIColor blackColor];
                [item addSubview:bookLabel];
                
                //作者
                UILabel *authorLabel = [[UILabel alloc]init];
                authorLabel.frame = CGRectMake(bookImgWidth + 10, 20, 200, 30);
                authorLabel.textColor = [UIColor colorWithRed:0.400 green:0.400 blue:0.435 alpha:1];
                authorLabel.font = [UIFont fontWithName:@"Heiti TC" size:13];
                authorLabel.text = @"Bjarne Stroustrup";
                [item addSubview:authorLabel];
                
                //出版社
                UILabel *publisher = [[UILabel alloc]init];
                publisher.frame = CGRectMake(bookImgWidth + 10, 50, 200, 30);
                publisher.textColor = [UIColor colorWithRed:0.400 green:0.400 blue:0.435 alpha:1];
                publisher.font = [UIFont fontWithName:@"Heiti TC" size:13];
                publisher.text = @"人民邮电出版社";
                [item addSubview:publisher];
                
                //价格
                UILabel *price = [[UILabel alloc]init];
                price.frame = CGRectMake(bookImgWidth + 10, 80, 30, 30);
                price.textColor = [UIColor colorWithRed:0.169 green:0.698 blue:0.706 alpha:1];
                price.font = [UIFont boldSystemFontOfSize:20];
                price.text = @"35";
                
                [item addSubview:price];
                
                //单位
                UILabel *danwei = [[UILabel alloc]init];
                danwei.frame = CGRectMake(bookImgWidth + 40, 80, 200, 30);
                danwei.textColor = [UIColor colorWithRed:0.702 green:0.702 blue:0.702 alpha:1];
                danwei.font = [UIFont fontWithName:@"Heiti TC" size:12];
                danwei.text = @"元";
                [item addSubview:danwei];
                
                //页码
                UILabel *pageNum = [[UILabel alloc]init];
                pageNum.frame = CGRectMake(screenWidth - 70, 80, 50, 30);
                pageNum.text = @"300页";
                pageNum.textColor = [UIColor colorWithRed:0.702 green:0.702 blue:0.702 alpha:1];
                pageNum.font = [UIFont fontWithName:@"Heiti TC" size:14];
                [item addSubview:pageNum];
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemClick:)];
                tap.numberOfTapsRequired = 1; //tap次数
                tap.numberOfTouchesRequired = 1; //手指数
                [item addGestureRecognizer:tap];
                
                [scrollView addSubview: item];
                
            }
        }else{
            UIAlertView * alert = [[UIAlertView alloc]init];
            alert.title =@"提示";
            alert.message = @"网络出现异常，请重试";
            [alert addButtonWithTitle:@"确定"];
            [alert show];
        }
    }];
    [self.view addSubview:scrollView];
    
}

-(void)itemClick:(id)sender{
    NSLog(@"click");
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"图书" style:UIBarButtonItemStylePlain target:self action:@selector(backItemClick:)];
    [self.navigationItem setBackBarButtonItem:backItem];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController pushViewController:[BookDetailViewController new] animated:YES];
}



@end
