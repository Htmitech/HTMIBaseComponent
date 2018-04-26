//
//  UIViewController+SetTitleFont.m
//  MXClient
//
//  Created by wlq on 16/5/10.
//  Copyright © 2016年 MXClient. All rights reserved.
//

#import "UIViewController+SetTitleFont.h"
//#import "MXNetworkListView.h"
#import "HTMISettingManager.h"
#import "BlocksKit+UIKit.h"
#import "SVProgressHUD.h"
#import "UIImage+WM.h"

@implementation UIViewController (SetTitleFont)

- (void)myClickReturn
{
    [self myPopViewControllerrAnimated:YES];
}

- (void)myPopViewControllerrAnimated:(BOOL)animated{
    
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:animated];
}

- (void)customNavigationController:(BOOL)canReturn title:(NSString *)title
{
    //设置导航栏背景色
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithRenderColor:navBarColor renderSize:CGSizeMake(10., 10.)] forBarMetrics:UIBarMetricsDefault];
    //self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;//的模糊效果，默认为YES
    self.navigationController.navigationBar.tintColor = navBarColor;
    //隐藏底部边线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.hidden = NO;
    
    if (self.navigationController.viewControllers.count > 1 || canReturn) {
        
        UIButton *btnLeft = [self htmi_leftButton:@"mx_btn_back_phone"];
        [btnLeft addTarget:self action:@selector(myClickReturn) forControlEvents:UIControlEventTouchUpInside];
    }
    else {
        UIButton *btnLeft = [self htmi_leftButton:@"mx_btn_community_list_phone"];
        
        [btnLeft bk_addEventHandler:^(id sender) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"htmi_leftBarButtonItemClick" object:self];
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        //页面加载完成之后 获取是否有新版本
        //[[MXNetworkListView sharedMXNetworkListView] isHaveVersionRedDot];
    }
    
    self.navigationItem.title = title;
    [self.navigationController.navigationBar setTitleTextAttributes:
     HTMINavigationBarTitleFont];
}



#pragma mark - Private

- (void)htmi_leftBarButtonItem:(UIButton *)btnLeft {
    UIBarButtonItem *negativeMargin = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeMargin.width = -18;
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    if ([[UIDevice currentDevice].systemVersion floatValue]>=7.0&&[[UIDevice currentDevice].systemVersion floatValue]<11.0)
    {
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeMargin, leftButtonItem, nil];
    }else{
        self.navigationItem.leftBarButtonItem = leftButtonItem;
    }
}

- (void)htmi_rightBarButtonItem:(UIButton *)btnRight {
    UIBarButtonItem *negativeMargin = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeMargin.width = -15;
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
    
    if ([[UIDevice currentDevice].systemVersion floatValue]>=7.0&&[[UIDevice currentDevice].systemVersion floatValue]<11.0)
    {
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeMargin, rightButtonItem, nil];
    }else{
        self.navigationItem.rightBarButtonItem = rightButtonItem;
    }
}

- (UIButton *)htmi_leftButton:(NSString *)imageName {
    
    UIImage * leftImage = [UIImage imageNavigationWithViewHue:imageName];
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat navigationBarHeight =  self.navigationController.navigationBar.frame.size.height;
    if (navigationBarHeight > 0) {
        btnLeft.frame = CGRectMake(0.0f, 0.0f, navigationBarHeight, navigationBarHeight);
    }
    else {
        btnLeft.frame = CGRectMake(0.0f, 0.0f, self.navigationController.navigationBar.frame.size.height-[UIApplication sharedApplication].statusBarFrame.size.height, self.navigationController.navigationBar.frame.size.height-[UIApplication sharedApplication].statusBarFrame.size.height);
    }
    
    [btnLeft setImage:leftImage forState:UIControlStateNormal];
    [btnLeft setImage:leftImage forState:UIControlStateHighlighted];
    btnLeft.backgroundColor = [UIColor clearColor];
    [self htmi_leftBarButtonItem:btnLeft];
    return btnLeft;
}


@end
