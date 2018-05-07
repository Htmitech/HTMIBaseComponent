//
//  HTMIBasedViewModel.m
//  HTMIWineMVVM
//
//  Created by wlq on 16/9/14.
//  Copyright © 2016年 wlq. All rights reserved.
//

#import "HTMIBasedViewModel.h"

@interface HTMIBasedViewModel ()
@property(nonatomic,strong,readwrite)id<HTMIViewModelServices> services;
@property (nonatomic, copy, readwrite) NSDictionary *params;
@end

@implementation HTMIBasedViewModel
- (instancetype)initWithService:(id<HTMIViewModelServices>)service params:(NSDictionary *)params
{
    self = [super init];
    if (self)
    {
        self.title      = params[@"title"];
        self.params     = params;
        self.services   = service;
    }
    return self;
}

- (BOOL)judgeWhetherLogin:(BOOL)goLogin
{
    /*
     if ([HTMIUser currentUser].isLogin)
     {
     return YES;
     }
     if (goLogin)
     {
     HTMILoginViewModel *viewModel    = [[HTMILoginViewModel alloc]initWithService:self.services params:@{@"title":@"登录"}];
     self.naviImpl.className         = @"HTMILoginVC";
     [self.naviImpl pushViewModel:viewModel animated:YES];
     }
     */
    return NO;
    
}
@end
