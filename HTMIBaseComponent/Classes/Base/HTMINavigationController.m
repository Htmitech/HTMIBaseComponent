//
//  TTNavigationController.m
//  TTNews
//
//  Created by 瑞文戴尔 on 16/3/25.
//  Copyright © 2016年 瑞文戴尔. All rights reserved.
//

#import "HTMINavigationController.h"
#import "SVProgressHUD.h"
#import "UIFont+HTMIFont.h"


@interface HTMINavigationController ()

@end

@implementation HTMINavigationController

- (instancetype)init
{
    self = [super init];
    if (self) {
        //禁止页面返回手势
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.enabled = NO;
        }
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

// 是否支持旋转
- (BOOL)shouldAutorotate {
    return self.viewControllers.lastObject.shouldAutorotate ? YES : NO;
}

// 支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return self.viewControllers.lastObject.supportedInterfaceOrientations ? self.viewControllers.lastObject.supportedInterfaceOrientations : UIInterfaceOrientationMaskPortrait;
}

// 默认方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return self.viewControllers.lastObject.preferredInterfaceOrientationForPresentation ? self.viewControllers.lastObject.preferredInterfaceOrientationForPresentation : UIInterfaceOrientationPortrait;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self updateSkinModel];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSkinModel) name:SkinModelDidChangedNotification object:nil];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGRect leftBarButtonItemRect = self.navigationItem.leftBarButtonItem.customView.frame;
    leftBarButtonItemRect.size.height = self.navigationBar.frame.size.height;
    leftBarButtonItemRect.size.width = self.navigationBar.frame.size.height;
    self.navigationItem.leftBarButtonItem.customView.frame = leftBarButtonItemRect;
    for (UIBarButtonItem *object in self.navigationItem.leftBarButtonItems) {
        CGRect rect = object.customView.frame;
        rect.size.height = self.navigationBar.frame.size.height;
        rect.size.width = self.navigationBar.frame.size.height;
        object.customView.frame = rect;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


/**
 获取上一个控制器
 
 @return 当前导航控制器的上一个控制器
 */
- (UIViewController *)backViewController
{
    NSInteger myIndex = [self.viewControllers indexOfObject:self];
    
    if ( myIndex != 0 && myIndex != NSNotFound ) {
        return [self.viewControllers objectAtIndex:myIndex-1];
    } else {
        return nil;
    }
}

////让导航控制器pop回指定的控制器
//NSMutableArray *allViewControllers = [NSMutableArray arrayWithArray:[self.navigationController viewControllers]];
//for (UIViewController *aViewController in allViewControllers) {
//    if ([aViewController isKindOfClass:[RequiredViewController class]]) {
//        [self.navigationController popToViewController:aViewController animated:NO];
//    }
//}


#pragma mark 更新皮肤模式 接到模式切换的通知后会调用此方法
- (void)updateSkinModel {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    NSString *currentSkinModel = [[NSUserDefaults standardUserDefaults] stringForKey:@""];//CurrentSkinModelKey
    if ([currentSkinModel isEqualToString:@""]) {//夜间模式NightSkinModelValue
        self.navigationBar.barTintColor = [UIColor colorWithRed:34/255.0 green:30/255.0 blue:33/255.0 alpha:1.0];
        attributes[NSForegroundColorAttributeName] = [UIColor grayColor];
        
        self.toolbar.barTintColor = [UIColor blackColor];
    }else {//日间模式
        self.navigationBar.barTintColor = [UIColor colorWithRed:243/255.0 green:75/255.0 blue:80/255.0 alpha:1.0];
        attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
        self.toolbar.barTintColor = [UIColor whiteColor];
    }
    attributes[NSFontAttributeName] = [UIFont htmi_systemFontOfSize:20];
    self.navigationBar.titleTextAttributes = attributes;
}

/**
 重写系统的跳转方法
 
 @param viewController 控制器
 @param animated 是否动画
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    //    if (self.childViewControllers.count==1) {
    //        viewController.hidesBottomBarWhenPushed = YES; //viewController是将要被push的控制器
    //    }
    
    //跳转之前应该判断一下是不是跳转同一个控制器，否则会崩溃
    if(self.topViewController != viewController) {
        
        if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
            // 隐藏tabbar
            viewController.hidesBottomBarWhenPushed = YES;
        }
        //wlq add 2017/09/04 进入下一个页面会隐藏当前view的加载
        if ([SVProgressHUD isVisible]) {
            [SVProgressHUD dismiss];
        }
        //这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
        [super pushViewController:viewController animated:YES];
    }
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    //wlq add 2017/09/04 返回页面会隐藏当前view的加载
    if ([SVProgressHUD isVisible]) {
        [SVProgressHUD dismiss];
    }
    
    return [super popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    //wlq add 2017/09/04 返回页面会隐藏当前view的加载
    if ([SVProgressHUD isVisible]) {
        [SVProgressHUD dismiss];
    }
    return [super popToRootViewControllerAnimated:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}


@end
