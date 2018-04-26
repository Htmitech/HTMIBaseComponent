//
//  UIViewController+Utility.h
//  CodingForiPad
//
//  Created by sunguanglei on 15/6/10.
//  Copyright (c) 2015年 coding. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "HTMIEmptyView.h"

@interface UIViewController (Utility)

/**
 判断控制器是否正在显示
 
 @return 是否正在显示
 */
- (BOOL)isCurrentViewControllerVisible;

/**
 当前控制器

 @return <#return value description#>
 */
+ (UIViewController*)currentViewController;

/**
 获取当前view所在的控制器
 
 @param view 当前的view
 @return 当前view所在的控制器
 */
+ (UIViewController *)viewControllerByView:(UIView *)vie;

@end
