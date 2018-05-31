//
//  NSString+HTMIDocumentPath.h
//  MXClient
//
//  Created by wlq on 2018/5/30.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HTMIDocumentPath)

/**
 获取正文文件夹地址
 
 @param userId 用户id
 @param portalId 门户id
 @param appId 应用id
 @return 正文文件夹地址
 */
+ (NSString *)mainBodyPathWithUserId:(NSString *)userId portalId:(NSString *)portalId appId:(NSString *)appId;

/**
 获取附件文件夹地址
 
 @param userId 用户id
 @param portalId 门户id
 @param appId 应用id
 @return 附件文件夹地址
 */
+ (NSString *)attachmentPathWithUserId:(NSString *)userId portalId:(NSString *)portalId appId:(NSString *)appId;

/**
 获取资料库文件夹地址
 
 @param userId 用户id
 @param portalId 门户id
 @param appId 应用id
 @return 资料库文件夹地址
 */
+ (NSString *)filesCenterPathWithUserId:(NSString *)userId portalId:(NSString *)portalId appId:(NSString *)appId;

/**
 获取当前用户Path拼接当前门户的Path拼接当前应用的Path
 
 @param userId 用户id
 @param portalId 门户id
 @param appId 应用id
 @return 当前用户Path拼接当前门户的Path拼接当前应用的Path
 */
+ (NSString *)documentPathWithUserId:(NSString *)userId portalId:(NSString *)portalId appId:(NSString *)appId;

/**
 获取当前用户Path拼接当前门户的Path
 
 @param userId 用户id
 @param portalId 门户id
 @return 当前用户Path拼接当前门户的Path
 */
+ (NSString *)documentPathWithUserId:(NSString *)userId portalId:(NSString *)portalId;


/**
 获取当前用户的Id的DocumentDirectoryPath
 
 @param userId 用户id
 @return 当前用户的Id的DocumentDirectoryPath
 */
+ (NSString *)documentPathWithUserId:(NSString *)userId;

@end
