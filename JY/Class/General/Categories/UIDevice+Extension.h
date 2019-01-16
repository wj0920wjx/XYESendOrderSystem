//
//  UIDevice+Extension.h
//  iOSShare
//
//  Created by wujin on 13-5-7.
//  Copyright (c) 2013年 wujin. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 获取系统的某版本是否比某给定的版本小
 @return 返回BOOL表示是否比指定的系统版本号小
 */
UIKIT_EXTERN BOOL DeviceSystemSmallerThan(float version);

/**
 获取手机设备的型号是否为iPhone5的
 @return 返回BOOL表示是否iPhone5以后的设备
 */
UIKIT_EXTERN BOOL DeviceIsiPhone5OrLater();

///是否为iPad界面
UIKIT_EXTERN BOOL DeviceIsiPad();

///是否为iPhone界面
UIKIT_EXTERN BOOL DeviceIsiPhone();

///是否是大于320的屏幕
UIKIT_EXTERN BOOL DeviceIsLarge();

///手机的系统
UIKIT_EXTERN NSUInteger DeviceSystemMajorVersion();

///手机的唯一标识
UIKIT_EXTERN NSString* mydeviceUniqueIdentifier();

@interface UIDevice (Extension)


+ (NSString*) uniqueOpenIdentifier;

+ (NSString*) uniqueAdvertisingIdentifier;
+ (NSString*) uniqueGlobalDeviceIdentifier;

///后面如果苹果审核没有问题再使用，现在审核比较严
//+ (NSString*) uniqueIDFAIdentifier;
@end
