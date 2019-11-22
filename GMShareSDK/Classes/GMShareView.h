//
//  GMShareView.h
//  GomeShop
//
//  Created by ued1 on 2018/7/16.
//  Copyright © 2018年 mshop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMConstHeader.h"


typedef void(^ SelectionBlock)(GMSharePlatformType type); //block 点击回调

@interface GMShareView : UIView
/**
 分享链接
  @param platformArray  平台数组
  @param block 点击哪个按钮
 */
+ (void)showShareMenuViewInWindowWithPlatform:(NSArray *)platformArray
                               SelectionBlock:(SelectionBlock)block;


@end
