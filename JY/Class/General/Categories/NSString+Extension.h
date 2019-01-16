//
//  NSString+Extension.h
//  iTrends
//
//  Created by wujin on 12-7-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 版本号
#define kAppShortVersion [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
// 后台版本号标示
#define kAppVersionAlias @"115"
// build号
#define kAppBuildVersion [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]

//获取一个字符串转换为URL
#define URL(str) [NSURL URLWithString:str]
///如果有nil或者null替换为空串
UIKIT_STATIC_INLINE NSString * StringIsNullRetBlank(NSString *str)
{
    if (str==nil || (NSNull *)(str)==[NSNull null]) {
        return @"";
    }
    return  str;
}



///正则判断手机号
UIKIT_STATIC_INLINE BOOL StringIsPhoneNumber(NSString *telPhone)
{
    NSString *pattern = @"^1[3578]\\d{9}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telPhone];
    return isMatch;
}

///正则邮箱
UIKIT_STATIC_INLINE BOOL StringIsEmail(NSString *telPhone)
{
//    NSString *pattern = @"[\\w!#$%&'*+/=?^_`{|}~-]+(?:\\.[\\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\\w](?:[\\w-]*[\\w])?\\.)+[\\w](?:[\\w-]*[\\w])?";
    NSString *pattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";

    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telPhone];
    return isMatch;
}

///正则判断密码
UIKIT_STATIC_INLINE BOOL StringIsPassword(NSString *pwd)
{
    NSString *pattern = @"^(?![A-Z]*$)(?![a-z]*$)(?![0-9]*$)(?![^a-zA-Z0-9]*$)\\S{6,12}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:pwd];
    return isMatch;
}
UIKIT_STATIC_INLINE BOOL StringIsIdentityCardNum(NSString *identityCardNum){
    NSString *pattern = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:identityCardNum];
    return isMatch;
}

///如果有nil或者null替换为自定义字符串
UIKIT_STATIC_INLINE NSString * StringIsNullRetString(NSString *str,NSString * repString)
{
    if (str==nil || (NSNull *)(str)==[NSNull null]||[str isEqualToString:@""]) {
        if (repString==nil || (NSNull *)(repString)==[NSNull null]||[repString isEqualToString:@""]) {
            return @"";
        }
        return repString;
    }
    return  str;
}
/**
判断字符串为空或者为空字符串,只有空格也算是空
@param str : 要判断的字符串
@return 返回BOOL表示结果
*/
UIKIT_STATIC_INLINE BOOL StringTrimIsNullOrEmpty(NSString* str)
{
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return ((NSNull *)str==[NSNull null] || str==nil||[str isEqualToString:@""]);
}

/**
 判断字符串为空或者为空字符串
 @param str : 要判断的字符串
 @return 返回BOOL表示结果
 */
UIKIT_STATIC_INLINE BOOL StringIsNullOrEmpty(NSString* str)
{
	return ((NSNull *)str==[NSNull null] || str==nil||[str isEqualToString:@""]);
}
/**
 判断字符串不为空并且不为空字符串
 @param str : 要判断的字符串
 @return 返回BOOL表示结果
 */
UIKIT_STATIC_INLINE BOOL StringNotNullAndEmpty(NSString* str)
{
	return ((NSNull *)str!=[NSNull null] && str!=nil&&![str isEqualToString:@""]&&str.length);
}

///返回一个占位字符，用于做Placeholder显示
UIKIT_STATIC_INLINE NSString * StringPlaceholderForString(NSString* placeholder,NSString* string)
{
	return StringNotNullAndEmpty(string)?string:placeholder;
}
///用于判断字符串非空的结尾参数
UIKIT_EXTERN NSString * const kStringsNotNullAndEmptyEnd;
/**
 判断一级字符串不为空并且不为空字符串
 必需在字符串的最后一个放置kStringsNotNullAndEmptyEnd
 @param str1 : 要判断的字符串
 @return 返回BOOL表示结果
 */
UIKIT_STATIC_INLINE BOOL StringsNotNullAndEmpty(NSString * str1,...)
{
	if (StringIsNullOrEmpty(str1)) {
		return NO;
	}
	BOOL result=YES;
	va_list argptr;
	va_start(argptr, str1);
	str1=va_arg(argptr, id);
	while (str1!=kStringsNotNullAndEmptyEnd) {
		str1=va_arg(argptr, id);
		if (StringIsNullOrEmpty(str1)) {
			result=NO;
			break;
		}
	}
	va_end(argptr);
	return result;
}

UIKIT_STATIC_INLINE NSString *decimalNumberMultiplyWithString(NSString *multiplierValue,NSString *multiplicandValue)
{
    NSDecimalNumber *multiplierNumber = [NSDecimalNumber decimalNumberWithString:multiplierValue];
    NSDecimalNumber *multiplicandNumber = [NSDecimalNumber decimalNumberWithString:multiplicandValue];
    NSDecimalNumber *product = [multiplicandNumber decimalNumberByMultiplyingBy:multiplierNumber];
    return [product stringValue];
}

UIKIT_STATIC_INLINE NSString *decimalNumberPlusWithString(NSString *multiplierValue,NSString *multiplicandValue)
{
    NSDecimalNumber *multiplierNumber = [NSDecimalNumber decimalNumberWithString:multiplierValue];
    NSDecimalNumber *multiplicandNumber = [NSDecimalNumber decimalNumberWithString:multiplicandValue];
    NSDecimalNumber *product = [multiplicandNumber decimalNumberByAdding:multiplierNumber];
    return [product stringValue];
}

UIKIT_STATIC_INLINE NSString *decimalNumberMinusWithString(NSString *multiplierValue,NSString *multiplicandValue)
{
    NSDecimalNumber *multiplierNumber = [NSDecimalNumber decimalNumberWithString:multiplierValue];
    NSDecimalNumber *multiplicandNumber = [NSDecimalNumber decimalNumberWithString:multiplicandValue];
    NSDecimalNumber *product = [multiplicandNumber decimalNumberBySubtracting:multiplierNumber];
    return [product stringValue];
}

//快速格式化一个字符串
#define S(str,...) [NSString stringWithFormat:str,##__VA_ARGS__]

@class MREntitiesConverter;
@interface NSString (Extension)

//判断字符串是否包含指定字符串
-(BOOL)isContainString:(NSString*)str;

- (NSString *)currencyString;

//获取某固定文本的显示高度
+(CGRect)heightForString:(NSString*)str Size:(CGSize)size Font:(UIFont*)font;

+(CGRect)heightForString:(NSString*)str Size:(CGSize)size Font:(UIFont*)font Lines:(NSInteger)lines;

//返回取到的token的字符串格式
+(NSString*)tokenString:(NSData*)devToken;


//返回经过md5加密后的字符串
- (NSString *)MD5String;

//返回经base64编码过后的数据
+ (NSString*)base64Encode:(NSData *)data;
-(NSString*)base64Encode;

//返回经base64解码过后的数据
+ (NSString*) base64Decode:(NSString *)string;
+ (NSData*) base64_Decode:(NSString *)string;
-(NSString*)base64Decode;

// 方法1：使用NSFileManager来实现获取文件大小
+ (long long) fileSizeAtPath1:(NSString*) filePath;
// 方法1：使用unix c函数来实现获取文件大小
+ (long long) fileSizeAtPath2:(NSString*) filePath;


// 方法1：循环调用fileSizeAtPath1
+ (long long) folderSizeAtPath1:(NSString*) folderPath;
// 方法2：循环调用fileSizeAtPath2
+ (long long) folderSizeAtPath2:(NSString*) folderPath;
// 方法2：在folderSizeAtPath2基础之上，去除文件路径相关的字符串拼接工作
+ (long long) folderSizeAtPath3:(NSString*) folderPath;

/// 去除字符串中收尾空格和换行
- (NSString *)trimString;

/// 计算字符串字节数，英文为1，中文为2
- (int)byteCount;

/// 根据最大字节数截取字符串
- (NSString *)substringWithMaxByteCount:(NSInteger)maxByteCount;

//============================for core text=====================//
/*** 返回符合 pattern 的所有 items */
- (NSMutableArray *)itemsForPattern:(NSString *)pattern;

/*** 返回符合 pattern 的 捕获分组为 index 的所有 items */
- (NSMutableArray *)itemsForPattern:(NSString *)pattern captureGroupIndex:(NSUInteger)index;

/*** 返回符合 pattern 的第一个 item */
- (NSString *)itemForPatter:(NSString *)pattern;

/*** 返回符合 pattern 的 捕获分组为 index 的第一个 item */
- (NSString *)itemForPattern:(NSString *)pattern captureGroupIndex:(NSUInteger)index;

/*** 按 format 格式化字符串生成 NSDate 类型的对象，返回 timeString 时间与 1970年1月1日的时间间隔
 * @discussion 格式化后的 NSDate 类型对象为 +0000 时区时间
 */
+ (NSTimeInterval)timeIntervalFromString:(NSString *)timeString withDateFormat:(NSString *)format;

/*** 按 format 格式化字符串生成 NSDate 类型的对象，返回当前时间距给定 timeString 之间的时间间隔
 * @discussion 格式化后的 NSDate 类型对象为本地时间
 */
+ (NSTimeInterval)localTimeIntervalFromString:(NSString *)timeString withDateFormat:(NSString *)format;

- (BOOL)contains:(NSString *)piece;

// 删除字符串开头与结尾的空白符与换行
- (NSString *)trim;

- (NSString *)encodeToPercentEscapeString;

/**
 支付宝支付使用的encode

 @return 返回encodedString ?!@#$^%*+,:;'\"`<>()[]{} /\\|
 */
- (NSString*) alpUrlEncodedString;

- (NSString *)decodeFromPercentEscapeString;

//============================for core text=====================//

//============================for JSON ========================//

- (id)objectFromJSONString;


// 乘以100 将元转成分
- (NSString *)pennyString;
// 除以100 将分转成元
- (NSString *)yuanString;
// 乘以一个数
- (NSString *)multipliedByValue:(CGFloat)value;

- (NSComparisonResult)floatCompare:(NSString*)other;

/**
 通过时间戳获取时间
 
 @return
 */
-(NSString *)getStamDate;

@end

@interface NSMutableString (Extension)

/**
 以指定格式向当前字符串追加一行
 @param string : 要追加的字符串
 */
-(void)appendLine:(NSString *)string;

@end
