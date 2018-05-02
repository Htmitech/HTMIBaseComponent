//
//  HTMIViewModelNavigationImpl.h
//  HTMIWineMVVM
//
//  Created by wlq on 16/9/14.
//  Copyright © 2016年 wlq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTMIViewModelServices.h"

@interface HTMIViewModelNavigationImpl : NSObject<HTMIViewModelServices>
@property(nonatomic,copy)NSString *className;
///设置当前rootVC
@property(nonatomic,assign)NSInteger selectedIndex;
- (instancetype)initWithNavigationController:(UINavigationController *)navi;


@end
