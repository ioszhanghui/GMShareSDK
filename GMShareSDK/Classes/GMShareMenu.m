//
//  GMShareMenu.m
//  GomeShop
//
//  Created by ued1 on 2018/7/17.
//  Copyright © 2018年 mshop. All rights reserved.
//

#import "GMShareMenu.h"
#import "NSString+YYAdd.h"
#import "GMPlatformModel.h"

@implementation GMShareMenu
{
    NSArray *_platformArray;
}
static NSInteger const totolHeight = 100; //self高度
static NSInteger const itemWAndH = 60;    //icon宽高
static CGFloat const LGRMargin = 44.0;    //左右margin
static NSInteger const itmeAndLabelPadding = 10;    //padding
static NSInteger const baseTag = 6666;    //basetag值

- (instancetype)initWithPlatformArray:(NSArray *)platformArray{
    if (self = [super init]) {
        _platformArray = platformArray;
        [self setUpUi];
    }
    return self;
}

-(void)setUpUi{
    
    self.perLineCount = 3;
    for (int i = 0; i<_platformArray.count; i++) {
        int row = i/self.perLineCount;
        NSInteger col = i%self.perLineCount;
        CGFloat leftAndRightPadding;   //最左最右
        CGFloat margin;                //item间距
        GMPlatformModel * platformModel = [_platformArray objectAtIndex:i];
        NSInteger arrayTag = [platformModel.plat_tag integerValue];

        if (ScreenW<=320) {
            margin = leftAndRightPadding = (ScreenW-self.perLineCount*itemWAndH)/(self.perLineCount+1);
        }else{
            leftAndRightPadding = LGRMargin;
            margin = (ScreenW-self.perLineCount*itemWAndH-2*LGRMargin)/(self.perLineCount-1);
        }
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];
        [self addSubview:btn];
        btn.tag = baseTag+arrayTag;
        [btn addTarget:self action:@selector(itemBtnClickd:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:platformModel.icon_image] forState:UIControlStateNormal];
        btn.adjustsImageWhenHighlighted = NO;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@(itemWAndH));
            make.top.equalTo(@(row*totolHeight));
            make.left.equalTo(@(leftAndRightPadding+col*(itemWAndH+margin)));
        }];
        
        NSString *labelString = platformModel.platform_name ;
        CGFloat labelH = [labelString heightForFont:PFR12Font width:itemWAndH];
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.font = PFR12Font;
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = labelString;
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.equalTo(btn);
            make.top.equalTo(btn.mas_bottom).offset(itmeAndLabelPadding);
            make.height.equalTo(@(labelH));
        }];
    }
}

- (void)itemBtnClickd:(UIButton *)item{
    NSInteger tag = item.tag-baseTag;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(shareMenueClickdWithPlatform:)]) {
        [self.delegate shareMenueClickdWithPlatform:tag];
    }
}
@end
