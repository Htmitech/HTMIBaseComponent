//
//  NSString+Extention.m
//  01-QQ聊天
//
//  Created by 武镇涛 on 15/4/12.
//  Copyright (c) 2015年 武镇涛. All rights reserved.
//

#import "NSString+Extention.h"
//#import "HTMIKeychainTool.h"
//#import "KeychainItemWrapper.h"
#import <CommonCrypto/CommonDigest.h>
//对称加密
#import "HTMIGTMBase64.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>//des加密


@implementation NSString (Extention)

#pragma mark ------ value 或 id 转化为 name
+ (NSString *)changValueOrIdToName:(NSString *)valueId dicArrarr:(NSArray *)dicArrarr {
    NSArray *array = [valueId componentsSeparatedByString:@";"];
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    NSString *nameString = nil;
    
    for (int i = 0; i < dicArrarr.count; i++) {
        NSDictionary *dic = dicArrarr[i];
        
        NSString *name = [dic objectForKey:@"name"];
        NSString *idString = [dic objectForKey:@"id"];
        NSString *valueString = [dic objectForKey:@"value"];
        
        for (int j = 0; j < array.count; j++) {
            NSString *string = array[j];
            if ([string isEqualToString:idString] || [string isEqualToString:valueString] || [string isEqualToString:name]) {
                [mutableArray addObject:name];
            }
        }
    }
    
    nameString = [mutableArray componentsJoinedByString:@";"];
    
    return nameString;
}

#pragma mark  ------ 对齐方式
- (NSTextAlignment)alignmentWithString {
    if ([self isEqualToString:@"Right"]) {
        return NSTextAlignmentRight;
    }
    else if ([self isEqualToString:@"Left"]) {
        return NSTextAlignmentLeft;
    }
    else if ([self isEqualToString:@"Center"]) {
        return NSTextAlignmentCenter;
    }
    else {
        return NSTextAlignmentLeft;
    }
}

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesDeviceMetrics|NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
}

- (NSString *)md5_32
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    
    
    NSString *string32 = [NSString stringWithFormat:
                          @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          result[0], result[1], result[2], result[3],
                          result[4], result[5], result[6], result[7],
                          result[8], result[9], result[10], result[11],
                          result[12], result[13], result[14], result[15]
                          ];
    
    return string32;
}

/**
 MD5加密
 
 @return 加密后密码
 */
- (NSString *)htmi_md5String{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

- (CGSize)sizeWithfont:(UIFont*)font MaxX:(CGFloat)maxx
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxx, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
}
- (CGSize)sizeWithfont:(UIFont*)font
{
    return [self sizeWithfont:font MaxX:MAXFLOAT];
}

- (NSInteger)Filesize
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL dir;
    BOOL exist =  [mgr fileExistsAtPath:self isDirectory:&dir];
    if (exist == NO) return 0;
    if (dir) {//self是一个文件夹
        //找出文件夹中的文件名
        NSArray *subpaths = [mgr subpathsAtPath:self];
        //获得全路径
        NSInteger totalByteSize = 0;
        for (NSString *subpath in subpaths)
        {
            NSString *fullpath = [self stringByAppendingPathComponent:subpath];
            //遍历文件
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullpath isDirectory:&dir];
            if (dir == NO) {
                totalByteSize +=[[mgr attributesOfItemAtPath:fullpath error:nil][NSFileSize]integerValue];
            }
            
        }
        return totalByteSize;
        
    }else
    {
        return [[mgr attributesOfItemAtPath:self error:nil][NSFileSize]integerValue];
    }
}

- (CGSize)textSizeWithFont:(UIFont *)font forWidth:(CGFloat)width NS_AVAILABLE_IOS(6_0)
{
    CGSize retSize;
    CGSize maxSize = CGSizeMake(width, CGFLOAT_MAX);
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.alignment = NSTextAlignmentLeft;
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,paragraphStyle,NSParagraphStyleAttributeName, nil];
        CGRect rect = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil];
        retSize = rect.size;
    }
    else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        retSize = [self sizeWithFont:font constrainedToSize:maxSize];
#pragma clang diagnostic pop
    }
    
    return retSize;
}

- (BOOL)isChinese
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)includeChinese
{
    for(int i=0; i< [self length];i++)
    {
        int a =[self characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
        }
    }
    return NO;
}

- (unsigned long long)fileSize
{
    // 总大小
    unsigned long long size = 0;
    NSFileManager *manager = [NSFileManager defaultManager];
    
    BOOL isDir = NO;
    BOOL exist = [manager fileExistsAtPath:self isDirectory:&isDir];
    
    // 判断路径是否存在
    if (!exist) return size;
    if (isDir) { // 是文件夹
        NSDirectoryEnumerator *enumerator = [manager enumeratorAtPath:self];
        for (NSString *subPath in enumerator) {
            NSString *fullPath = [self stringByAppendingPathComponent:subPath];
            size += [manager attributesOfItemAtPath:fullPath error:nil].fileSize;
            
        }
    }else{ // 是文件
        size += [manager attributesOfItemAtPath:self error:nil].fileSize;
    }
    return size;
}

- (NSString *)fileSizeString
{
    // 总大小
    unsigned long long size = 0;
    NSString *sizeText = nil;
    // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 文件属性
    NSDictionary *attrs = [mgr attributesOfItemAtPath:self error:nil];
    // 如果这个文件或者文件夹不存在,或者路径不正确直接返回0;
    if (attrs == nil) {
        return @"0MB";
    }
    
    if ([attrs.fileType isEqualToString:NSFileTypeDirectory]) { // 如果是文件夹
        // 获得文件夹的大小  == 获得文件夹中所有文件的总大小
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        for (NSString *subpath in enumerator) {
            // 全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            // 累加文件大小
            size += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
            
            if (size >= pow(10, 9)) { // size >= 1GB
                sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
            } else if (size >= pow(10, 6)) { // 1GB > size >= 1MB
                sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
            } else if (size >= pow(10, 3)) { // 1MB > size >= 1KB
                sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
            } else { // 1KB > size
                sizeText = [NSString stringWithFormat:@"%zdB", size];
            }
            
        }
        return sizeText;
    } else { // 如果是文件
        size = attrs.fileSize;
        if (size >= pow(10, 9)) { // size >= 1GB
            sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
        } else if (size >= pow(10, 6)) { // 1GB > size >= 1MB
            sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
        } else if (size >= pow(10, 3)) { // 1MB > size >= 1KB
            sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
        } else { // 1KB > size
            sizeText = [NSString stringWithFormat:@"%zdB", size];
        }
        
    }
    return sizeText;
}

///**
// 获取设备唯一标识
// @return 设备唯一标识
// */
//+ (NSString *)getDeviceId
//{
//    NSString * currentDeviceUUIDStr = [HTMIKeychainTool getUUID];
//    if (currentDeviceUUIDStr == nil || [currentDeviceUUIDStr isEqualToString:@""])
//    {
//        NSUUID * currentDeviceUUID  = [UIDevice currentDevice].identifierForVendor;
//        currentDeviceUUIDStr = currentDeviceUUID.UUIDString;
//        currentDeviceUUIDStr = [currentDeviceUUIDStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
//        currentDeviceUUIDStr = [currentDeviceUUIDStr lowercaseString];
//        [HTMIKeychainTool setUUID:currentDeviceUUIDStr];
//    }
//    //[self getDeviceIdNew];
//    return currentDeviceUUIDStr;
//}

//+ (NSString *)getDeviceIdNew {
//    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"htmitech_uuid" accessGroup:nil];
//    NSString *UUIDString = [wrapper objectForKey:(__bridge id)kSecValueData];
//    if (UUIDString.length == 0) {
//        UUIDString = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//        [wrapper setObject:UUIDString forKey:(__bridge id)kSecValueData];
//    }
//    NSLog(@"%@", UUIDString);
//    return UUIDString;
//}

/**
 *  DES加密方法
 *
 *  @param clearText 待加密的字符串
 *  @param key       秘钥
 *
 *  @return 加密后的字符串
 */
+ (NSString *)encryptUseDES:(NSString *)clearText key:(NSString *)key
{
    NSData *data = [clearText dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          nil,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          1024,
                                          &numBytesEncrypted);
    
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData *dataTemp = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        plainText = [HTMIGTMBase64 stringByEncodingData:dataTemp];
    }else{
        NSLog(@"DES加密失败");
    }
    return plainText;
}

//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)firstCharactor:(NSString *)aString
{
    if (aString) {
        //转成了可变字符串
        NSMutableString *str = [NSMutableString stringWithString:aString];
        //先转换为带声调的拼音
        CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
        //再转换为不带声调的拼音
        CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
        //转化为大写拼音
        NSString *pinYin = [str capitalizedString];
        
        if (pinYin.length > 0) {
            //获取并返回首字母
            return [pinYin substringToIndex:1];
        }
        else{
            return @"";
        }
    }else{
        return @"";
    }
}

/**
 *  汉字转拼音
 *
 *  @param strChinese 汉字
 *
 *  @return 拼音
 */
+ (NSString *)transformToPinyin:(NSString *)strChinese
{
    NSMutableString *mutableString = [NSMutableString stringWithString:strChinese];
    
    CFStringTransform((CFMutableStringRef)mutableString,NULL,kCFStringTransformToLatin,false);
    
    mutableString = (NSMutableString*)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    NSString * strResult =  [mutableString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return strResult;
}

/**
 移除字符串中的空格和换行
 
 @param str 字符串
 @return 新的字符串
 */
+ (NSString *)htmi_removeSpaceAndNewline:(NSString *)str {
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}

/**
 判断字符串中是否有空格
 
 @param str 字符串
 @return  是否有空格
 */
+ (BOOL)htmi_isBlank:(NSString *)str {
    NSRange _range = [str rangeOfString:@" "];
    if (_range.location != NSNotFound) {
        //有空格
        return YES;
    } else {
        //没有空格
        return NO;
    }
}


/**
 获取加密后的电话字符串
 
 @param originalPhoneNumber 原始的电话字符串
 @return 加密后的电话号码字符串
 */
+ (NSString *)htmi_secrecyPhoneWithString:(NSString *)originalPhoneNumber {
    
    NSMutableArray * phoneNumberArray = [NSMutableArray array];
    NSString *split = @",";
    //这个可能里面有多个，号，如果有，进行拆分
    if ([originalPhoneNumber  containsString:@","]) {//英文，
        
        NSArray *array = [originalPhoneNumber  componentsSeparatedByString:@","];
        [phoneNumberArray addObjectsFromArray:array];
    }
    else if ([originalPhoneNumber  containsString:@"，"]){//中文，
        split = @"，";
        NSArray *array = [originalPhoneNumber  componentsSeparatedByString:@"，"];
        [phoneNumberArray addObjectsFromArray:array];
    }
    else if ([originalPhoneNumber  containsString:@" "]){
        split = @" ";
        NSArray *array = [originalPhoneNumber  componentsSeparatedByString:@" "];
        [phoneNumberArray addObjectsFromArray:array];
    }
    else if ([originalPhoneNumber  containsString:@";"]){//英文;
        split = @";";
        NSArray *array = [originalPhoneNumber  componentsSeparatedByString:@";"];
        [phoneNumberArray addObjectsFromArray:array];
    }
    else if ([originalPhoneNumber  containsString:@"；"]){//中文；
        split = @"；";
        NSArray *array = [originalPhoneNumber  componentsSeparatedByString:@"；"];
        [phoneNumberArray addObjectsFromArray:array];
    }
    else{
        
        NSString * strPhoneNumber = originalPhoneNumber ;
        
        if (strPhoneNumber.length > 0) {
            [phoneNumberArray addObject:strPhoneNumber];
        }
    }
    
    NSMutableString *resultString = [NSMutableString string];
    for (NSString *phoneNumber in phoneNumberArray) {
        if (phoneNumber.length > 7) {
            if (resultString.length > 0) {
                [resultString appendString:split];
            }
            NSString *tempString = [phoneNumber stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            [resultString appendString:tempString];
        }
    }
    return resultString;
}

#pragma mark 判断字符串
- (BOOL)htmi_isBlankString{
    
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([self isEqualToString:@"(null)"]) {
        return YES;
    }
    return NO;
}

@end
