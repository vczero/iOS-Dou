//
//  MusicViewController.m
//  iOS-Dou
//
//  Created by lihua on 15/11/16.
//  Copyright (c) 2015年 lihua. All rights reserved.
//

#import "MusicViewController.h"
#import "Service.h"
#import "DWebView.h"

#define IDX_TAG  19090

@interface MusicViewController (){
    UIScrollView                *_scrollView;
    NSString                    *_keywords;
    UIActivityIndicatorView     *_act;
    NSArray                     *_musics;
}
@property UITextField *searchInput;
@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"音乐";
    int btnWidth = 60;
    int searchHeight = 40;
    int statusHieght = 30;
    float screenWidth = [[UIScreen mainScreen]bounds].size.width;
    float height = [[UIScreen mainScreen]bounds].size.height;
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
    [searchBtn addTarget:self action:@selector(musicList:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.searchInput];
    [self.view addSubview:searchBtn];
   
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc]init];
    }
    _scrollView.frame = CGRectMake(0, 75, screenWidth, height -124);
    [self.view addSubview:_scrollView];
    [self musicList:nil];
    
    
}

- (void) musicList:(id)sender{
    
    if(!_act){
        _act = [[UIActivityIndicatorView alloc]init];
        _act.center = self.view.center;
        _act.color = [UIColor colorWithRed:0.000 green:0.525 blue:0.992 alpha:1];
        _act.hidesWhenStopped = YES;
        [self.view addSubview:_act];
    }
    
    if(_act.isAnimating){
        return;
    }
    [_act startAnimating];
    float width = [[UIScreen mainScreen]bounds].size.width;
    
    NSString *key = self.searchInput.text.length == 0 ? @"刘德华": self.searchInput.text;
    NSString *url = [NSString stringWithFormat:@"%@?count=10&q=%@",[Service getMusicSearchURL], key];
    
    [Service getData:url completion:^(NSError *error, id data) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(error){
                UIAlertView * alert = [[UIAlertView alloc]init];
                alert.title =@"提示";
                alert.message = @"网络出现异常，请重试";
                [alert addButtonWithTitle:@"确定"];
                [alert show];
                return;
            }
            [[_scrollView subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];
            _musics = data[@"musics"];
            if([_musics count] == 0){
                [_act startAnimating];
                return;
            }
            _scrollView.contentSize = CGSizeMake(width, 130 * [_musics count] + 10);
            
            [_musics enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                UIView *item = [[UIView alloc]init];
                item.frame = CGRectMake(0, 3 + idx * 130, width - 6, 130);
                CALayer *layer = [[CALayer alloc]init];
                layer.frame = CGRectMake(0, 0, width, 1);
                layer.backgroundColor = [UIColor colorWithRed:0.914 green:0.906 blue:0.914 alpha:1].CGColor;
                [item.layer addSublayer:layer];
                
                UIImageView *imgView = [[UIImageView alloc]init];
                UIImage *img = [UIImage imageWithData:[[NSData alloc]initWithContentsOfURL:[[NSURL alloc]initWithString:obj[@"image"]]]];
                imgView.image = img;
                imgView.frame = CGRectMake(width/2 - 40, 10, 80, 80);
                imgView.layer.cornerRadius = 40;
                imgView.layer.masksToBounds = YES;
                imgView.contentMode = UIViewContentModeScaleAspectFill;
                [item addSubview:imgView];
                
                UILabel *name = [[UILabel alloc]init];
                name.text = [NSString stringWithFormat:@"曲目：%@", obj[@"title"]];
                name.frame = CGRectMake(3, 90, 200, 20);
                name.font = [UIFont systemFontOfSize:14];
                [item addSubview:name];
                
                UILabel *time = [[UILabel alloc]init];
                time.text = [NSString stringWithFormat:@"时间：%@年", [obj[@"attrs"][@"pubdate"]count]? obj[@"attrs"][@"pubdate"][0] : @""];
                time.frame = CGRectMake(3, 110, 200, 20);
                time.font = [UIFont systemFontOfSize:14];
                [item addSubview:time];
                
                UILabel *author = [[UILabel alloc]init];
                author.text = [NSString stringWithFormat:@"演唱：%@", [obj[@"attrs"][@"singer"]count] ? obj[@"attrs"][@"singer"][0]: @""];
                author.frame = CGRectMake(width - 100, 90, 100, 20);
                author.font = [UIFont systemFontOfSize:14];
                [item addSubview:author];
                
                UILabel *score = [[UILabel alloc]init];
                score.text = [NSString stringWithFormat:@"评分：%@", obj[@"rating"][@"average"]];
                score.frame = CGRectMake(width - 100, 110, 100, 20);
                score.font = [UIFont systemFontOfSize:14];
                [item addSubview:score];
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemClick:)];
                tap.numberOfTapsRequired = 1;
                tap.numberOfTouchesRequired = 1;
                [item addGestureRecognizer:tap];
                item.tag = (IDX_TAG + idx);

                
                [_scrollView addSubview:item];
                
            }];
            
            [_act stopAnimating];
            
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;

}

-(void)itemClick:(UITapGestureRecognizer *)ges{
    NSInteger idx = ges.view.tag - IDX_TAG;
    DWebView *wb = [[DWebView alloc]init];
    wb.url = _musics[idx][@"mobile_link"];
    wb.showTitle = _musics[idx][@"title"];
    [self.navigationController pushViewController:wb animated:YES];
}



@end
