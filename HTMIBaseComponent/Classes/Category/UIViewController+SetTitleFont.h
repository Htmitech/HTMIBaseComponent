//
//  UIViewController+SetTitleFont.h
//  MXClient
//
//  Created by wlq on 16/5/10.
//  Copyright © 2016年 MXClient. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SetTitleFont)

- (void)customNavigationController:(BOOL)canReturn title:(NSString *)title;

- (void)myClickReturn;

- (void)myPopViewControllerrAnimated:(BOOL)animated;

@end
