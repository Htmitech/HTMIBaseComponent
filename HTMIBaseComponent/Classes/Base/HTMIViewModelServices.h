//
//  HTMIViewModelServices.h
//  HTMIWineMVVM
//
//  Created by wlq on 16/9/14.
//  Copyright © 2016年 wlq. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HTMIBasedViewModel;
@protocol HTMIViewModelServices <NSObject>

- (void)pushViewModel:(HTMIBasedViewModel *)viewModel animated:(BOOL)animated;

- (void)popViewControllerWithAnimation:(BOOL)animated;

- (void)popToRootViewModelWithAnimation:(BOOL)animated;

- (void)presentViewModel:(HTMIBasedViewModel *)viewModel animated:(BOOL)animated complete:(void(^)())complete;

///模态弹出vc，用于alert
- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated complete:(void(^)())complete;

@end
