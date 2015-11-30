//
//  BookDetailViewController.m
//  iOS-Dou
//
//  Created by lihua on 15/11/17.
//  Copyright (c) 2015年 lihua. All rights reserved.
//

#import "BookDetailViewController.h"
#import "Service.h"

@interface BookDetailViewController (){
    UIActivityIndicatorView *   _activityIndicator;
}

@end

@implementation BookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.title;
    [self showDetail];
    
    
    
}

-(void) showDetail{
    NSString *url = [NSString stringWithFormat:@"%@/%@", [Service getBookDetailURL], self.bookId];
    if (_activityIndicator.isAnimating) {
        return;
    }
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityIndicator.center = self.view.center;
        _activityIndicator.hidesWhenStopped = YES;
        _activityIndicator.color = [UIColor colorWithRed:0.000 green:0.525 blue:0.992 alpha:1];
        [self.view addSubview:_activityIndicator];
    }
    
    [_activityIndicator startAnimating];
    [Service getData:url completion:^(NSError *error, id data) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                UIAlertView * alert = [[UIAlertView alloc]init];
                alert.title =@"提示";
                alert.message = @"网络出现异常，请重试";
                [alert addButtonWithTitle:@"确定"];
                [alert show];
                return;
            }
            [_activityIndicator stopAnimating];
            NSLog(@"%@", data);
            
            UIView *bookInfo = [[UIView alloc]init];
            float width = UIScreen.mainScreen.bounds.size.width;
            bookInfo.frame = CGRectMake(0, 70, width, 135);
            CALayer *topBorder = [CALayer layer];
            topBorder.frame = CGRectMake(0.0f, 135, bookInfo.frame.size.width, 1.0f);
            topBorder.backgroundColor = [UIColor colorWithRed:0.914 green:0.906 blue:0.914 alpha:1].CGColor;
            [bookInfo.layer addSublayer:topBorder];
            
            UIImageView *imgView = [[UIImageView alloc]init];
            NSURL *bookImgURL =  [NSURL URLWithString:data[@"image"]];
            UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:bookImgURL]];
            imgView.image = img;
            imgView.frame = CGRectMake(5, 5, 80, 120);
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            [bookInfo addSubview:imgView];
            
            int bookImgWidth = 83;
            //书名
            UILabel *bookLabel = [[UILabel alloc] init];
            bookLabel.frame = CGRectMake(bookImgWidth + 10, 0, 200, 30);
            bookLabel.text = self.title;
            bookLabel.font = [UIFont fontWithName:@"Heiti TC" size:14];
            bookLabel.textColor = [UIColor blackColor];
            [bookInfo addSubview:bookLabel];
            
            //作者
            UILabel *authorLabel = [[UILabel alloc]init];
            authorLabel.frame = CGRectMake(bookImgWidth + 10, 20, 200, 30);
            authorLabel.textColor = [UIColor colorWithRed:0.400 green:0.400 blue:0.435 alpha:1];
            authorLabel.font = [UIFont fontWithName:@"Heiti TC" size:13];
            authorLabel.text = data[@"author"][0];
            [bookInfo addSubview:authorLabel];
            
            //出版社
            UILabel *publisher = [[UILabel alloc]init];
            publisher.frame = CGRectMake(bookImgWidth + 10, 50, 200, 30);
            publisher.textColor = [UIColor colorWithRed:0.400 green:0.400 blue:0.435 alpha:1];
            publisher.font = [UIFont fontWithName:@"Heiti TC" size:13];
            publisher.text = data[@"publisher"];
            [bookInfo addSubview:publisher];
            
            //价格
            UILabel *price = [[UILabel alloc]init];
            price.frame = CGRectMake(bookImgWidth + 10, 80, 30, 30);
            price.textColor = [UIColor colorWithRed:0.169 green:0.698 blue:0.706 alpha:1];
            price.font = [UIFont boldSystemFontOfSize:20];
            NSArray *arr = [data[@"price"] componentsSeparatedByString:@"."];
            price.text = arr[0];
            [bookInfo addSubview:price];
            
            //单位
            UILabel *danwei = [[UILabel alloc]init];
            danwei.frame = CGRectMake(bookImgWidth + 40, 80, 200, 30);
            danwei.textColor = [UIColor colorWithRed:0.702 green:0.702 blue:0.702 alpha:1];
            danwei.font = [UIFont fontWithName:@"Heiti TC" size:12];
            danwei.text = @"元";
            [bookInfo addSubview:danwei];
            
            //页码
            UILabel *pageNum = [[UILabel alloc]init];
            pageNum.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 70, 80, 50, 30);
            pageNum.text = [NSString stringWithFormat:@"%@页", data[@"pages"]];;
            pageNum.textColor = [UIColor colorWithRed:0.702 green:0.702 blue:0.702 alpha:1];
            pageNum.font = [UIFont fontWithName:@"Heiti TC" size:14];
            [bookInfo addSubview:pageNum];
            
            [self.view addSubview:bookInfo];
        });
        
        
    }];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}






@end
