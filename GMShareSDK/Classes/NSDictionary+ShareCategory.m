//
//  NSDictionary+ShareCategory.m
//  GMShareSDK
//
//  Created by 小飞鸟 on 2019/11/20.
//

#import "NSDictionary+ShareCategory.h"
#import "GMShareConfig.h"
#import "GMConstHeader.h"
#import <UMShare/UMShare.h>


@implementation NSDictionary (ShareCategory)
/*从 参数中 获取 分享对象*/
-(UMSocialMessageObject*)getShareObjWithConfig:(GMShareConfig*)config;{
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //分享类型
    UMShareObject * shareObj = nil;
    NSInteger shareType = [[self objectForKey:@"type"] integerValue];
    switch (shareType) {
        case GMShareContentTypeImage://单图片分享
        case GMShareContentTypeImages: //多图片分享
            shareObj = [UMShareImageObject mj_objectWithKeyValues:self];
            break;
        case GMShareContentTypeText://纯文本分享
            NSAssert([self objectForKey:@"text"], @"纯文本分享 需要text参数");
            messageObject.text = [self objectForKey:@"text"];
            break;
        case GMShareContentTypeWebPage://WAP分享
            shareObj = [UMShareWebpageObject mj_objectWithKeyValues:self];
            break;
        case GMContentTypeMiniProgram://小程序分享
                shareObj = [UMShareMiniProgramObject mj_objectWithKeyValues:self];
            ((UMShareMiniProgramObject*)(shareObj)).miniProgramType = config.miniProgramType;
                break;
        default:
            NSAssert([self objectForKey:@"text"], @"纯文本分享 需要text参数");
            messageObject.text = [self objectForKey:@"text"];
            break;
    }
    messageObject.shareObject = shareObj;
    return messageObject;
    
}
@end
