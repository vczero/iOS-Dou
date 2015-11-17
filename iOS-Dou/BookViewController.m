//
//  RootViewController.m
//  iOS-Dou
//
//  Created by lihua on 15/11/16.
//  Copyright (c) 2015年 lihua. All rights reserved.
//

#import "BookViewController.h"

@interface BookViewController ()

@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //搜索框
    int btnWidth = 60;
    int searchHeight = 40;
    int statusHieght = 30;
    int screenWidth = [[UIScreen mainScreen]bounds].size.width;
    int screenHeight = [[UIScreen mainScreen]bounds].size.height;
    int inputWidth = screenWidth - 20 - btnWidth;
    UITextField *searchInput = [[UITextField alloc] init];
    searchInput.frame = CGRectMake(10, statusHieght, inputWidth, searchHeight);
    [searchInput setBorderStyle: UITextBorderStyleRoundedRect];
    
    UIButton *searchBtn = [[UIButton alloc]init];
    searchBtn.frame = CGRectMake(inputWidth + 5, statusHieght, btnWidth, searchHeight);
    searchBtn.backgroundColor = [UIColor colorWithRed:0.000 green:0.569 blue:1.000 alpha:1];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitle:@"搜索" forState:UIControlStateHighlighted];
    
    [self.view addSubview:searchInput];
    [self.view addSubview:searchBtn];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, statusHieght + searchHeight + 10, screenWidth, screenHeight - statusHieght - searchHeight);
    scrollView.scrollEnabled = YES;
    int viewHeight = 100;
    int blockHieght = viewHeight + 20;
    scrollView.contentSize = CGSizeMake(screenWidth, (blockHieght + 5) * 10);
    
    for(int i = 0; i < 10; i++){
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
        
        [scrollView addSubview: item];
        [self.view addSubview:scrollView];
    }
    
    //请求数据
    NSString *urlStr = [NSString stringWithFormat:@"https://api.douban.com/v2/book/search?count=10&q=C语言"];
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        if(error){
            NSLog(@"%@", error);
        }else{
            NSInteger code = [(NSHTTPURLResponse*)response statusCode];
            NSString *result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            
            NSLog(@"%ld", code);
            NSLog(@"%@", result);
        }
    }];
    
    
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    return YES;
}

// 滑动到顶部时调用该方法
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidScrollToTop");
}

// scrollView 已经滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidScroll");
}

// scrollView 开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDragging");
}

// scrollView 结束拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"scrollViewDidEndDragging");
}

// scrollView 开始减速（以下两个方法注意与以上两个方法加以区别）
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDecelerating");
}

// scrollview 减速停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"%@",self.view);
}

@end
