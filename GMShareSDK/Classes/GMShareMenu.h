//
//  GMShareMenu.h
//  GomeShop
//
//  Created by ued1 on 2018/7/17.
//  Copyright © 2018年 mshop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMConstHeader.h"

@protocol GMShareMenuDelegate <NSObject>
@required
/**
 返回点击的平台
 */
-(void)shareMenueClickdWithPlatform:(GMSharePlatformType)platformType;
@end

@interface GMShareMenu : UIView
/** 每行数量 */
@property (nonatomic, assign) NSInteger perLineCount;

@property (nonatomic, weak) id<GMShareMenuDelegate> delegate;

- (instancetype)initWithPlatformArray:(NSArray *)platformArray;
@end
