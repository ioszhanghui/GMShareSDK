//
//  GMShareView.m
//  GomeShop
//
//  Created by ued1 on 2018/7/16.
//  Copyright © 2018年 mshop. All rights reserved.
//

#import "GMShareView.h"
#import "GMShareMenu.h"
#import "POPSpringAnimation.h"


@interface GMShareView()<GMShareMenuDelegate>

@property (nonatomic, strong) UIButton *backgroundBtn;  //背景
@property (nonatomic, strong) UIView *contenerDes;      //分享到容器
@property (nonatomic, strong) GMShareMenu *menueView;  //按键
@property (nonatomic, strong) UIButton *closeButton;    //关闭按钮
@property (nonatomic, copy)  SelectionBlock callBack;            //回调block
@end

@implementation GMShareView
static NSInteger const contenerDesBottomPadding = 237;    //分享到容器与底部间距
static NSInteger const ShareToLineWidth = 65;             //分享到线宽度
static NSInteger const ShareToLineHeight = 1;             //分享到线高度
static NSInteger const PaddingWithLineAndLabel = 15;      //line和label 间距
static NSInteger const MenueTopWithBottomPadding = 210;   //menue顶部和最底部边距
static NSInteger const closeButtonWH = 33;                //关闭按钮宽高
static NSInteger const closeButtonTopToSuper = 50+2*closeButtonWH;     //关闭按钮底部距离父视图距离


- (instancetype)initWithFrame:(CGRect)frame
             andPlatformArray:(NSArray *)platformArray
                  andCallBack:(SelectionBlock)block{
    if (self = [super initWithFrame:frame]) {
        self.callBack = block;
        //背景
        self.backgroundColor = [UIColor clearColor];
        self.backgroundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.backgroundBtn.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        [self addSubview:self.backgroundBtn];
        [self addSubview:self.backgroundBtn];
        [self.backgroundBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.with.height.top.equalTo(self);
        }];
        UIBlurEffect *effect;
        if (@available(iOS 10.0, *)) {
            effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
        } else {
            effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        }
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = frame;
        [self.backgroundBtn addSubview:effectView];
        //UI
        [self initShareToIntroduceView];
        [self initTheMenueWithPlatformArray:(NSArray *)platformArray];
        [self initTheCloseButton];
        
        //添加响应通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(closeTheShreView) name:(UIApplicationWillResignActiveNotification) object:nil];
    }
    return self;
}

#pragma mark UI
/** 描述视图 */
- (void)initShareToIntroduceView{
    NSString *tipsString = @"分享到";
    CGFloat labelW = [tipsString widthForFont:PFR15Font];
    CGFloat labelH = [tipsString heightForFont:PFR15Font width:labelW];
    //容器
    self.contenerDes = [[UIView alloc] init];
    self.contenerDes.backgroundColor = [UIColor clearColor];
    [self addSubview:self.contenerDes];
    [self.contenerDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self);
        make.height.equalTo(@(labelH));
        make.bottom.equalTo(self.mas_bottom).offset(-contenerDesBottomPadding);
    }];
    //描述
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    [label setTextColor:[UIColor whiteColor]];
    label.font = PFR15Font;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = tipsString;
    [self.contenerDes addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contenerDes);
        make.width.equalTo(@(labelW));
        make.height.equalTo(@(labelH));
    }];
    //线
    for (int i = 0; i<2; i++) {
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor whiteColor];
        [self.contenerDes addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(label.mas_centerY);
            if (i==0) {
                make.right.equalTo(label.mas_left).offset(-PaddingWithLineAndLabel);
            }else{
                make.left.equalTo(label.mas_right).offset(PaddingWithLineAndLabel);
            }
            make.width.equalTo(@(ShareToLineWidth));
            make.height.equalTo(@(ShareToLineHeight));
        }];
    }
    self.contenerDes.alpha = 0.0;
}

- (void)initTheMenueWithPlatformArray:(NSArray *)platformArray{
    self.menueView = [[GMShareMenu alloc] initWithPlatformArray:platformArray];
    self.menueView.delegate = self;
    [self addSubview:self.menueView];
    [self.menueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom);
        make.left.width.equalTo(self);
        make.height.equalTo(@(100));
    }];
}

- (void)initTheCloseButton{
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeButton.backgroundColor = [UIColor clearColor];
    [self.closeButton setImage:[UIImage imageNamed:@"share_close"] forState:UIControlStateNormal];
    [self addSubview:self.closeButton];
    [self.closeButton addTarget:self action:@selector(closeTheShreView) forControlEvents:UIControlEventTouchUpInside];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(closeButtonWH));
        make.centerX.equalTo(self.contenerDes.mas_centerX);
        make.top.equalTo(self.mas_bottom);
    }];
}

#pragma mark 按钮点击代理
-(void)shareMenueClickdWithPlatform:(GMSharePlatformType)platformType{
    if (self.callBack) {
        self.callBack(platformType);
    }
}

-(void)dealloc{
    //移除 通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
}

#pragma mark 点击事件
/**调起分享*/
+(void)showShareMenuViewInWindowWithPlatform:(NSArray *)platformArray
                              SelectionBlock:(SelectionBlock)block{
    GMShareView *shareView = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds
                                        andPlatformArray:platformArray
                                             andCallBack:block];
    UIWindow *window = KEYWINDOW;
    if([window viewWithTag:100001]){
        return;
    }
    shareView.tag = 100001;
    [window addSubview:shareView];
    [shareView activate];
}

/**动画效果*/
- (void)activate{
    WEAKSELF
    [UIView animateWithDuration:0.3f animations:^{
        self.backgroundBtn.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.contenerDes.alpha = 1.0;
        }];
        POPSpringAnimation *springAnimated =[POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        springAnimated.springSpeed = 15;       //速度
        springAnimated.springBounciness = 10;   //弹力
        springAnimated.toValue = @(self.menueView.layer.center.y-MenueTopWithBottomPadding);
        springAnimated.beginTime = CACurrentMediaTime();
        [self.menueView.layer pop_addAnimation:springAnimated forKey:@"position"];

        POPSpringAnimation *springAnimated2 =[POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        springAnimated2.springSpeed = 15;       //速度
        springAnimated2.springBounciness = 10;   //弹力
        springAnimated2.toValue = @(self.menueView.layer.center.y-closeButtonTopToSuper);
        springAnimated2.beginTime = CACurrentMediaTime()+0.2;
        [self.closeButton.layer pop_addAnimation:springAnimated2 forKey:@"position"];
    }];
}

//关闭按钮点击
- (void)closeTheShreView{
    [self removeMyself];
}

- (void)removeMyself{
     [self removeFromSuperview];
}

@end
