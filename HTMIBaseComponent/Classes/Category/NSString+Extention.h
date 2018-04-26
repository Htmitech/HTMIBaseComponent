//
//  NSString+Extention.h
//  01-QQ聊天
//
//  Created by 武镇涛 on 15/4/12.
//  Copyright (c) 2015年 武镇涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Extention)
+ (NSString *)changValueOrIdToName:(NSString *)valueId dicArrarr:(NSArray *)dicArrarr;
#pragma mark  ------ 对齐方式
- (NSTextAlignment)alignmentWithString;
/**
 *  返回字符串的SIZE
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
- (CGSize)sizeWithfont:(UIFont*)font MaxX:(CGFloat)maxx;
- (CGSize)sizeWithfont:(UIFont*)font;
- (NSInteger)Filesize;

- (unsigned long long)fileSize;
- (NSString *)fileSizeString;
/**
 MD5加密
 
 @return 加密后密码
 */
- (NSString *)htmi_md5String;
- (NSString *)md5_32;
- (CGSize)textSizeWithFont:(UIFont *)font forWidth:(CGFloat)width NS_AVAILABLE_IOS(6_0);

- (BOOL)isChinese;
- (BOOL)includeChinese;

/**
 获取设备唯一标识
 @return 设备唯一标识
 */
//+ (NSString *)getDeviceId;

/**
 *  DES加密方法
 *
 *  @param clearText 待加密的字符串
 *  @param key       秘钥
 *
 *  @return 加密后的字符串
 */
+ (NSString *)encryptUseDES:(NSString *)clearText key:(NSString *)key;

//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)firstCharactor:(NSString *)aString;

/**
 *  汉字转拼音
 *
 *  @param strChinese 汉字
 *
 *  @return 拼音
 */
+ (NSString *)transformToPinyin:(NSString *)strChinese;

#pragma mark 判断字符串
- (BOOL)htmi_isBlankString;

/**
 获取加密后的电话字符串
 
 @param originalPhoneNumber 原始的电话字符串
 @return 加密后的电话号码字符串
 */
+ (NSString *)htmi_secrecyPhoneWithString:(NSString *)originalPhoneNumber;

@end
