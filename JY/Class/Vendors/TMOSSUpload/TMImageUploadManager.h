//
//  TMImageUploadManager.h
//  FrameDemo
//
//  Created by 许洋 on 2017/12/26.
//  Copyright © 2017年 许洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMOSSConfig.h"

@interface TMImageUploadManager : NSObject

typedef void (^TMImageUploadBlock)(NSArray<NSString *> *imageUrls);

@property (nonatomic, copy) TMImageUploadBlock imageUploadBlock;

@property (nonatomic, strong) TMOSSConfig *OSSConfig;


+ (TMImageUploadManager *)standardManager;

// 没有数量限制
- (void)uploadImageWithViewController:(UIViewController *)viewController uploadType:(TMOSSUploadType)uploadType imageUploadBlock:(TMImageUploadBlock)imageUploadBlock;

// 带数量限制
- (void)uploadImageWithViewController:(UIViewController *)viewController uploadType:(TMOSSUploadType)uploadType maxImageCount:(NSInteger)maxImageCount imageUploadBlock:(TMImageUploadBlock)imageUploadBlock;

/**
 将不可访问的私有图片地址转换成可访问的临时 url

 @param url  要转换的私有 url
 @param completion 完成回调
 */
+ (void)transformUrlWithPrivateUrl:(NSString *)url completion:(void(^)(BOOL success, NSString *url))completion;


@end
