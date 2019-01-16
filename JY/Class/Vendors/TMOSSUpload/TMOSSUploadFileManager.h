//
//  TMOSSUploadFileManager.h
//  FrameDemo
//
//  Created by 许洋 on 2017/12/22.
//  Copyright © 2017年 许洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMOSSConfig.h"

@interface TMOSSUploadFileManager : NSObject

typedef void (^OSSUploadSingleCompletion)(NSString *resulte);

typedef void (^OSSUploadMultipleCompletion)(NSArray *imgUrls);

@property (nonatomic, copy) OSSUploadSingleCompletion OSSUploadSingleCompletion;

@property (nonatomic, copy) OSSUploadMultipleCompletion OSSUploadMultipleCompletion;

@property (nonatomic, strong) TMOSSConfig *OSSConfig;

+ (TMOSSUploadFileManager *)standardManager;

- (void)OSSUploadeForFileArr:(NSArray *)fileArr completion:(OSSUploadMultipleCompletion)completion;
@end
