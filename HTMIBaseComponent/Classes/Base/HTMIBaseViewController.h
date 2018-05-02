//
//  HTMIBaseViewController.h
//  MXClient
//
//  Created by wlq on 16/5/30.
//  Copyright © 2016年 MXClient. All rights reserved.
//

#import <UIKit/UIKit.h>

//设置导航栏字体
#import "UIViewController+SetTitleFont.h"
//Controller通用方法分类
#import "UIViewController+Utility.h"
#import "HTMIViewModelNavigationImpl.h"
#import "HTMIBasedViewModel.h"


@interface HTMIBaseViewController : UIViewController<UIGestureRecognizerDelegate>

@property(nonatomic,strong,readonly)HTMIBasedViewModel *viewModel;
@property(nonatomic,strong,readonly)UIPercentDrivenInteractiveTransition *interactivePopTransition;


- (instancetype)initWithViewModel:(HTMIBasedViewModel *)viewModel;

@end
