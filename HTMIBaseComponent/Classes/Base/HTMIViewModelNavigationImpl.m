//
//  HTMIViewModelNavigationImpl.m
//  HTMIWineMVVM
//
//  Created by wlq on 16/9/14.
//  Copyright © 2016年 wlq. All rights reserved.
//

#import "HTMIViewModelNavigationImpl.h"
#import "HTMIBaseViewController.h"
#import "SVProgressHUD.h"
@interface HTMIViewModelNavigationImpl ()
@property(nonatomic,weak)UINavigationController *navigationController;
@end

@implementation HTMIViewModelNavigationImpl
- (instancetype)initWithNavigationController:(UINavigationController *)navi
{
    self = [super init];
    if (self)
    {
        _navigationController = navi;
    }
    return self;
}

- (void)setSelectedIndex:(NSInteger )selectedIndex
{
    _selectedIndex = selectedIndex;
    _navigationController.tabBarController.selectedIndex = selectedIndex;
}

- (void)pushViewModel:(HTMIBasedViewModel *)viewModel animated:(BOOL)animated
{
    if (!_navigationController)
    {
        [SVProgressHUD showErrorWithStatus:@"导航错误"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    if (_className.length <= 0)
    {
        [SVProgressHUD showWithStatus:@"错误,未指定viewController"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    HTMIBaseViewController *vc = [[NSClassFromString(_className) alloc] initWithViewModel:viewModel];
    if (!vc)
    {
        NSLog(@"VC名字错误");
        return;
    }
    [_navigationController pushViewController:vc animated:animated];
}

- (void)popViewControllerWithAnimation:(BOOL)animated
{
    if (!_navigationController)
    {
        NSLog(@"没有导航");
        return;
    }
    
    [_navigationController popViewControllerAnimated:animated];
}
- (void)popToRootViewModelWithAnimation:(BOOL)animated
{
    if (!_navigationController)
    {
        NSLog(@"没有导航");
        return;
    }
    
    [_navigationController popToRootViewControllerAnimated:animated];
}

- (void)presentViewModel:(HTMIBasedViewModel *)viewModel animated:(BOOL)animated complete:(void (^)())complete
{
    if (!_navigationController)
    {
        NSLog(@"没有导航");
    }
    if (_className.length <= 0)
    {
        [SVProgressHUD showWithStatus:@"错误,未指定viewController"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    HTMIBaseViewController *vc = [[NSClassFromString(_className) alloc] initWithViewModel:viewModel];
    if (!vc)
    {
        NSLog(@"VC名字错误");
        return;
    }
    [_navigationController presentViewController:vc animated:animated completion:complete];
}
- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated complete:(void (^)())complete
{
    if (!_navigationController)
    {
        [SVProgressHUD showErrorWithStatus:@"导航错误"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    [_navigationController presentViewController:viewController animated:animated completion:complete];
}

@end
