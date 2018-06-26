//
//  HTMIPluginBaseObject.h
//  MXClient
//
//  Created by wlq on 2016/12/13.
//  Copyright © 2016年 MXClient. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HTMIPluginBaseObject : NSObject

/**
 父控制器
 */
@property (nonatomic, assign) UIViewController *parentViewController;

/**
 参数字典（可以存放多个参数）
 */
@property (nonatomic, copy) NSDictionary *versionConfigDic;

/**
 字符串参数
 */
@property (nonatomic, copy) NSString *params;

/**
 外部字符串参数
 */
@property (nonatomic, copy) NSString *extParams;

/**
 应用id
 */
@property (nonatomic, copy) NSString *appID;

/**
 应用Code
 */
@property (nonatomic, copy) NSString *appCode;

/**
 应用显示标题
 */
@property (nonatomic, copy) NSString *displayTile;

/**
 应用模型
 */
@property (nonatomic, copy) id appModel;

- (void)exec;

- (void)uninstall;

@end
