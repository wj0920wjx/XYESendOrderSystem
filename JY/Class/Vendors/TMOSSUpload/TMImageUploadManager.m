//
//  TMImageUploadManager.m
//  FrameDemo
//
//  Created by 许洋 on 2017/12/26.
//  Copyright © 2017年 许洋. All rights reserved.
//

#import "TMImageUploadManager.h"
#import "TMOSSUploadFileManager.h"
#import <TZImagePickerController/TZImagePickerController.h>

/**
 调用一个block,会判断block不为空
 */
#define BlockCallWithTwoArg(block,arg1,arg2) if(block){block(arg1,arg2);}
// 调用带返回值的block
#define BlockCallbackWithTwoArg(block,arg1,arg2)  block ? block(arg1,arg2):nil

@interface TMImageUploadManager()<TZImagePickerControllerDelegate>


@end
@implementation TMImageUploadManager


+(TMImageUploadManager *)standardManager{
    static TMImageUploadManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
    return manager;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _OSSConfig = [[TMOSSConfig alloc]init];
    }
    return self;
}
-(void)uploadImageWithViewController:(UIViewController *)viewController uploadType:(TMOSSUploadType)uploadType imageUploadBlock:(TMImageUploadBlock)imageUploadBlock {
    
    [self uploadImageWithViewController:viewController uploadType:uploadType maxImageCount:9 imageUploadBlock:imageUploadBlock];
}
-(void)uploadImageWithViewController:(UIViewController *)viewController uploadType:(TMOSSUploadType)uploadType maxImageCount:(NSInteger)maxImageCount imageUploadBlock:(TMImageUploadBlock)imageUploadBlock {
    self.imageUploadBlock = imageUploadBlock;
    _OSSConfig.uploadType = uploadType;

    TZImagePickerController *imagePickerCtrl = [[TZImagePickerController alloc]initWithMaxImagesCount:maxImageCount delegate:self];
    [viewController presentViewController:imagePickerCtrl animated:YES completion:nil];
}
-(void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{

    [YFEasyHUD showIndicator];
    [TMOSSUploadFileManager standardManager].OSSConfig = _OSSConfig;
    [[TMOSSUploadFileManager standardManager] OSSUploadeForFileArr:photos completion:^(NSArray *imgUrls) {
        NSLog(@"图片数组%@",imgUrls);

        [YFEasyHUD hideHud];
        if (_imageUploadBlock) {
            _imageUploadBlock(imgUrls);
        }
    }];
}

+ (void)transformUrlWithPrivateUrl:(NSString *)url completion:(void (^)(BOOL, NSString *))completion {
    if (StringIsNullOrEmpty(url)) {
        BlockCallWithTwoArg(completion, NO, @"")
    }
//    [TMBaseEngineInstance requestWithPath:AF_TURNURL parameter:@{@"url":url}.mutableCopy success:^(TMNetRootModel *netRootModel) {
//
//        BlockCallWithTwoArg(completion, netRootModel.ret, netRootModel.data);
//    } failure:^(NSError *error) {
//        BlockCallWithTwoArg(completion, NO, @"");
//    }];
    
    
}



@end
