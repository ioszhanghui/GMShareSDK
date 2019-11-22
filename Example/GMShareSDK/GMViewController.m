//
//  GMViewController.m
//  GMShareSDK
//
//  Created by ioszhanghui@163.com on 11/20/2019.
//  Copyright (c) 2019 ioszhanghui@163.com. All rights reserved.
//

#import "GMViewController.h"
#import "GMShareSDK.h"

@interface GMViewController ()

@end

@implementation GMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = CGRectMake(100, 100, 40, 40);
    [btn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];
}

-(void)clickAction{
    
    NSDictionary * params = @{
        @"title":@"测试",
        @"type":@"1",
        @"descr":@"descr",
        @"thumbImage":[UIImage imageNamed:@"Group_wechatFavorite"],
        @"shareImage":[UIImage imageNamed:@"Group_wechatFavorite"],
        @"text":@"纯文本测试",
        @"webpageUrl":@"http://www.baidu.com",
        @"userName":@"gh_9cd4e7aa6688",
        @"path":@"pages/detail/detail",
        @"hdImageData":UIImagePNGRepresentation([UIImage imageNamed:@"Group_wechatFavorite"]),
        @"miniProgramType":@"0"
    };
    

    [GMShareSDK shareWithParameters:params onStateChanged:^(id  _Nullable data, NSError * _Nullable error) {
        
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
