//
//  NSString+HTMIDocumentPath.m
//  MXClient
//
//  Created by wlq on 2018/5/30.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import "NSString+HTMIDocumentPath.h"

@implementation NSString (HTMIDocumentPath)

/**
 获取正文文件夹地址
 
 @param userId 用户id
 @param portalId 门户id
 @param appId 应用id
 @return 正文文件夹地址
 */
+ (NSString *)mainBodyPathWithUserId:(NSString *)userId portalId:(NSString *)portalId appId:(NSString *)appId {
    
    NSString * appPathString = [self documentPathWithUserId:userId portalId:portalId appId:appId];
    if (appPathString == nil || appPathString.length <= 0) {
        return @"";
    }
    
    NSString * mainBodyDirectory = [appPathString stringByAppendingPathComponent:@"MainBodyDirectory"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isExist = YES;
    //如果文件夹不存在就创建
    if (![fileManager fileExistsAtPath:mainBodyDirectory isDirectory:&isExist]) {
        [fileManager createDirectoryAtPath:mainBodyDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return mainBodyDirectory;
}

/**
 获取附件文件夹地址
 
 @param userId 用户id
 @param portalId 门户id
 @param appId 应用id
 @return 附件文件夹地址
 */
+ (NSString *)attachmentPathWithUserId:(NSString *)userId portalId:(NSString *)portalId appId:(NSString *)appId {
    
    NSString * appPathString = [self documentPathWithUserId:userId portalId:portalId appId:appId];
    if (appPathString == nil || appPathString.length <= 0) {
        return @"";
    }
    
    NSString * attachmentDirectory = [appPathString stringByAppendingPathComponent:@"AttachmentDirectory"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isExist = YES;
    //如果文件夹不存在就创建
    if (![fileManager fileExistsAtPath:attachmentDirectory isDirectory:&isExist]) {
        [fileManager createDirectoryAtPath:attachmentDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return attachmentDirectory;
}

/**
 获取资料库文件夹地址
 
 @param userId 用户id
 @param portalId 门户id
 @param appId 应用id
 @return 资料库文件夹地址
 */
+ (NSString *)filesCenterPathWithUserId:(NSString *)userId portalId:(NSString *)portalId appId:(NSString *)appId {
    
    NSString * appPathString = [self documentPathWithUserId:userId portalId:portalId appId:appId];
    if (appPathString == nil || appPathString.length <= 0) {
        return @"";
    }
    
    NSString * attachmentDirectory = [appPathString stringByAppendingPathComponent:@"FilesCenterDirectory"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isExist = YES;
    //如果文件夹不存在就创建
    if (![fileManager fileExistsAtPath:attachmentDirectory isDirectory:&isExist]) {
        [fileManager createDirectoryAtPath:attachmentDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return attachmentDirectory;
}

/**
 获取当前用户Path拼接当前门户的Path拼接当前应用的Path
 
 @param userId 用户id
 @param portalId 门户id
 @param appId 应用id
 @return 当前用户Path拼接当前门户的Path拼接当前应用的Path
 */
+ (NSString *)documentPathWithUserId:(NSString *)userId portalId:(NSString *)portalId appId:(NSString *)appId {
    
    if (userId == nil || userId.length <= 0) {
        return @"";
    }
    
    if (portalId == nil || portalId.length <= 0) {
        return @"";
    }
    
    if (appId == nil || appId.length <= 0) {
        return @"";
    }
    
    NSString *portalIdPath = [self documentPathWithUserId:userId portalId:portalId];
    
    NSString * appIdPath = [portalIdPath stringByAppendingPathComponent:appId];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isExist = YES;
    //如果文件夹不存在就创建
    if (![fileManager fileExistsAtPath:appIdPath isDirectory:&isExist]) {
        [fileManager createDirectoryAtPath:appIdPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return appIdPath;
}

/**
 获取当前用户Path拼接当前门户的Path
 
 @param userId 用户id
 @param portalId 门户id
 @return 当前用户Path拼接当前门户的Path
 */
+ (NSString *)documentPathWithUserId:(NSString *)userId portalId:(NSString *)portalId {
    
    NSString * userIdPath = [self documentPathWithUserId:userId];
    
    if (userId == nil || userId.length <= 0) {
        return @"";
    }
    
    if (portalId == nil || portalId.length <= 0) {
        return @"";
    }
    
    NSString *portalIdPath = [userIdPath stringByAppendingPathComponent:portalId];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isExist = YES;
    //如果文件夹不存在就创建
    if (![fileManager fileExistsAtPath:portalIdPath isDirectory:&isExist]) {
        [fileManager createDirectoryAtPath:portalIdPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return portalIdPath;
}


/**
 获取当前用户的Id的DocumentDirectoryPath
 
 @param userId 用户id
 @return 当前用户的Id的DocumentDirectoryPath
 */
+ (NSString *)documentPathWithUserId:(NSString *)userId {
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    if (userId == nil || userId.length <= 0) {
        return @"";
        //NSAssert(NO, @"当前用户不存在");
    }
    
    NSString * userIdPath = [path stringByAppendingPathComponent:userId];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isExist = YES;
    //如果文件夹不存在就创建
    if (![fileManager fileExistsAtPath:userIdPath isDirectory:&isExist]) {
        [fileManager createDirectoryAtPath:userIdPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return userIdPath;
}

@end
