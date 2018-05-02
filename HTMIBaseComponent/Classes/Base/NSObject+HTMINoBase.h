//
//  NSObject+HTMINoBase.h
//  HTMIBaseMVVM
//
//  Created by wlq on 2017/12/10.
//  Copyright © 2017年 htmi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HTMINoBase)

/**
 去表征化参数列表
 */
@property (nonatomic, strong, readonly) NSDictionary *params;

/**
 初始化方法
 */
- (instancetype)initWithParams:(NSDictionary *)params;

@end
