//
//  MovieViewController.m
//  iOS-Dou
//
//  Created by lihua on 15/11/16.
//  Copyright (c) 2015年 lihua. All rights reserved.
//

#import "MovieViewController.h"
#import "Service.h"
#import "DWebView.h"

#define IDX_TAG  99990

@interface MovieViewController (){
    UIScrollView *              _contentView;
    UIActivityIndicatorView *   _activityIndicator;
    NSArray *                   _subjects;
}
@property UITextField *searchInput;
@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"电影";
    
    int btnWidth = 60;
    int searchHeight = 40;
    int statusHieght = 30;
    int screenWidth = [[UIScreen mainScreen]bounds].size.width;
    int screenHeight = [[UIScreen mainScreen]bounds].size.height;
    int inputWidth = screenWidth - 20 - btnWidth;
    self.searchInput = [[UITextField alloc] init];
    self.searchInput.frame = CGRectMake(10, statusHieght, inputWidth, searchHeight);
    [self.searchInput setBorderStyle: UITextBorderStyleRoundedRect];
    self.searchInput.placeholder = @"请输入电影的名称";
    
    UIButton *searchBtn = [[UIButton alloc]init];
    searchBtn.frame = CGRectMake(inputWidth + 5, statusHieght, btnWidth, searchHeight);
    searchBtn.backgroundColor = [UIColor colorWithRed:0.000 green:0.569 blue:1.000 alpha:1];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitle:@"搜索" forState:UIControlStateHighlighted];
    [searchBtn addTarget:self action:@selector(searchMovie:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.searchInput];
    [self.view addSubview:searchBtn];
    
    _contentView = [[UIScrollView alloc]init];
    _contentView.frame = CGRectMake(0, statusHieght + searchHeight + 10, screenWidth, screenHeight - statusHieght - searchHeight - 20);
    [self.view addSubview:_contentView];
    [self searchMovie:nil];

}

- (void)searchMovie:(id)sender{
    
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
    
    NSString *searchKey = self.searchInput.text.length == 0  ? @"当幸福来敲门" : self.searchInput.text;
    NSString *urlStr = [NSString stringWithFormat:@"%@?count=10&q=%@", [Service getMovieSearchURL],searchKey];
    [Service getData:urlStr completion:^(NSError * error, id data) {
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
            int screenWidth = [[UIScreen mainScreen]bounds].size.width;
            _subjects = data[@"subjects"];
            
            _contentView.contentSize = CGSizeMake(screenWidth, 135 * _subjects.count + 35);
            [_subjects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                UIView *item = [[UIView alloc]init];
                item.frame = CGRectMake(0, idx * 135, screenWidth, 130);
                CALayer *layer = [CALayer layer];
                layer.frame = CGRectMake(0, 0, screenWidth, 1);
                layer.backgroundColor = [UIColor colorWithRed:0.914 green:0.906 blue:0.914 alpha:1].CGColor;
                [item.layer addSublayer:layer];
                
                NSURL *imgURL = [NSURL URLWithString:obj[@"images"][@"medium"]];
                UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:imgURL]];
                UIImageView *imgView = [[UIImageView alloc]init];
                imgView.image = img;
                imgView.frame = CGRectMake(5, 5, 90, 120);
                imgView.contentMode = UIViewContentModeScaleAspectFit;
                [item addSubview:imgView];
                
                //名称
                UILabel *name = [[UILabel alloc] init];
                name.frame = CGRectMake(98, 0, 200, 30);
                name.text = [NSString stringWithFormat:@"名称: %@", obj[@"title"]];
                name.font = [UIFont fontWithName:@"Heiti TC" size:14];
                name.textColor = [UIColor blackColor];
                [item addSubview:name];
                
                //演员
                UILabel *performer = [[UILabel alloc] init];
                performer.frame = CGRectMake(98, 20, 200, 30);
                performer.text = [NSString stringWithFormat:@"演员: %@", [obj[@"casts"] count] ? obj[@"casts"][0][@"name"]: @""];
                performer.font = [UIFont fontWithName:@"Heiti TC" size:14];
                performer.textColor = [UIColor blackColor];
                [item addSubview:performer];
                
                //评分
                UILabel *score = [[UILabel alloc] init];
                score.frame = CGRectMake(98, 40, 200, 30);
                score.text = [NSString stringWithFormat:@"评分: %@", obj[@"rating"][@"average"]];
                score.font = [UIFont fontWithName:@"Heiti TC" size:14];
                score.textColor = [UIColor blackColor];
                [item addSubview:score];
                
                //年份
                UILabel *year = [[UILabel alloc] init];
                year.frame = CGRectMake(98, 60, 200, 30);
                year.text = [NSString stringWithFormat:@"年份: %@", obj[@"year"]];
                year.font = [UIFont fontWithName:@"Heiti TC" size:14];
                year.textColor = [UIColor blackColor];
                [item addSubview:year];
                
                //年份
                UILabel *type = [[UILabel alloc] init];
                type.frame = CGRectMake(98, 80, 200, 30);
                type.text = [NSString stringWithFormat:@"类型: %@", [obj[@"genres"] count] ? obj[@"genres"][0] : @""];
                type.font = [UIFont fontWithName:@"Heiti TC" size:14];
                type.textColor = [UIColor blackColor];
                [item addSubview:type];
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemClick:)];
                tap.numberOfTapsRequired = 1;
                tap.numberOfTouchesRequired = 1;
                [item addGestureRecognizer:tap];
                item.tag = (IDX_TAG + idx);
                [_contentView addSubview:item];
                
            }];
            [_activityIndicator stopAnimating];
            
        });
    }];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void) itemClick:(UITapGestureRecognizer*)ges{
    NSInteger idx = ges.view.tag - IDX_TAG;
    DWebView *wb = [[DWebView alloc]init];
    wb.url= _subjects[idx][@"alt"];
    wb.movieTitle = _subjects[idx][@"title"];
    [self.navigationController pushViewController:wb animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
