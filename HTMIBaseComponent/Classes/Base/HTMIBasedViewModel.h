//
//  HTMIBasedViewModel.h
//  HTMIWineMVVM
//
//  Created by wlq on 16/9/14.
//  Copyright © 2016年 wlq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTMIViewModelServices.h"
#import "HTMIViewModelNavigationImpl.h"
@interface HTMIBasedViewModel : NSObject

@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong,readonly)id<HTMIViewModelServices> services;
@property(nonatomic,strong)HTMIViewModelNavigationImpl *naviImpl;
@property (nonatomic, copy, readonly) NSDictionary *params;
- (instancetype)initWithService:(id<HTMIViewModelServices>)service params:(NSDictionary *)params;

/**
 *  判断是否登录
 *  @param  goGoLogin 如果没有登录，是否跳转到登录页面
 */
- (BOOL)judgeWhetherLogin:(BOOL)goGoLogin;

@end
