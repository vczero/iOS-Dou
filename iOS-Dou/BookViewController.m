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

#define IDX_TAG  9090

@interface BookViewController () {
    
    UIScrollView *              _contentView;
    UIActivityIndicatorView *   _activityIndicator;
    NSArray *                   _tempBooks;
    
}

@property UITextField *searchInput;

@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    int btnWidth = 60;
    int searchHeight = 40;
    int statusHieght = 30;
    int screenWidth = [[UIScreen mainScreen]bounds].size.width;
    int screenHeight = [[UIScreen mainScreen]bounds].size.height;
    int inputWidth = screenWidth - 20 - btnWidth;
    self.searchInput = [[UITextField alloc] init];
    self.searchInput.frame = CGRectMake(10, statusHieght, inputWidth, searchHeight);
    [self.searchInput setBorderStyle: UITextBorderStyleRoundedRect];
    
    UIButton *searchBtn = [[UIButton alloc]init];
    searchBtn.frame = CGRectMake(inputWidth + 5, statusHieght, btnWidth, searchHeight);
    searchBtn.backgroundColor = [UIColor colorWithRed:0.000 green:0.569 blue:1.000 alpha:1];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitle:@"搜索" forState:UIControlStateHighlighted];
    [searchBtn addTarget:self action:@selector(searchBooK:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.searchInput];
    [self.view addSubview:searchBtn];
    
    _contentView = [UIScrollView new];
    _contentView.frame = CGRectMake(0, statusHieght + searchHeight + 10, screenWidth, screenHeight - statusHieght - searchHeight - 20);
    
    [self.view addSubview:_contentView];
    [self searchBooK:nil];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)itemClick:(UITapGestureRecognizer *)ges{
    NSInteger idx = ges.view.tag - IDX_TAG;
    BookDetailViewController *detail = [BookDetailViewController new];
    detail.bookId = _tempBooks[idx];
    [self.navigationController pushViewController:detail animated:YES];
    
}

-(void)searchBooK:(id)sender{
    if (_activityIndicator.isAnimating) {
        return;
    }
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityIndicator.center = self.view.center;
        _activityIndicator.hidesWhenStopped = YES;
        [self.view addSubview:_activityIndicator];
    }
    
    [_activityIndicator startAnimating];
    NSString *searchKey = self.searchInput.text.length == 0  ? @"C语言" : self.searchInput.text;
    NSString *urlStr = [NSString stringWithFormat:@"%@?count=10&q=%@", [ServiceURL getBookSearchURL],searchKey];
    [ServiceURL getData:urlStr completion:^(NSError * error, id data) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                UIAlertView * alert = [[UIAlertView alloc]init];
                alert.title =@"提示";
                alert.message = @"网络出现异常，请重试";
                [alert addButtonWithTitle:@"确定"];
                [alert show];
                return ;
            }
            [[_contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
            NSArray *books = data[@"books"];
            
            if ([books count] == 0) {
                [_activityIndicator stopAnimating];
                return;
            }
            
            _tempBooks = books;
            int viewHeight = 100;
            int blockHieght = viewHeight + 20;
            int screenWidth = [[UIScreen mainScreen]bounds].size.width;
            _contentView.contentSize = CGSizeMake(screenWidth, (blockHieght + 5) * 10);
            
            [books enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                int bookImgWidth = 80;
                UIView *item = [[UIView alloc]init];
                item.frame = CGRectMake(0, 0 + (blockHieght * idx) , screenWidth, blockHieght);
                CALayer *topBorder = [CALayer layer];
                topBorder.frame = CGRectMake(0.0f, 0.0f, item.frame.size.width, 1.0f);
                topBorder.backgroundColor = [UIColor colorWithRed:0.914 green:0.906 blue:0.914 alpha:1].CGColor;
                [item.layer addSublayer:topBorder];
                
                UIImageView *imgView = [[UIImageView alloc] init];
                NSURL *bookPhotoURL = [NSURL URLWithString:obj[@"image"]];
                UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:bookPhotoURL]];
                imgView.image = img;
                imgView.frame = CGRectMake(10, 10, bookImgWidth, viewHeight);
                //按最大值自适应
                imgView.contentMode = UIViewContentModeScaleAspectFit;
                [item addSubview:imgView];
                
                //书名
                UILabel *bookLabel = [[UILabel alloc] init];
                bookLabel.frame = CGRectMake(bookImgWidth + 10, 0, 200, 30);
                bookLabel.text = obj[@"title"];
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
                publisher.text = obj[@"publisher"];
                [item addSubview:publisher];
                
                //价格
                UILabel *price = [[UILabel alloc]init];
                price.frame = CGRectMake(bookImgWidth + 10, 80, 30, 30);
                price.textColor = [UIColor colorWithRed:0.169 green:0.698 blue:0.706 alpha:1];
                price.font = [UIFont boldSystemFontOfSize:20];
                NSArray *arr = [obj[@"price"] componentsSeparatedByString:@"."];
                price.text = arr[0];
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
                pageNum.text = [NSString stringWithFormat:@"%@页", obj[@"pages"]];
                pageNum.textColor = [UIColor colorWithRed:0.702 green:0.702 blue:0.702 alpha:1];
                pageNum.font = [UIFont fontWithName:@"Heiti TC" size:14];
                [item addSubview:pageNum];
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemClick:)];
                tap.numberOfTapsRequired = 1; //tap次数
                tap.numberOfTouchesRequired = 1; //手指数
                [item addGestureRecognizer:tap];
                [_contentView addSubview: item];
                item.tag = (IDX_TAG + idx);
                
            }];
            [_activityIndicator stopAnimating];
            
        });
        
    }];
    
    
    
}


@end
