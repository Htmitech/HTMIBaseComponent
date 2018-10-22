//
//  HTMIBaseViewController.m
//  MXClient
//
//  Created by wlq on 16/5/30.
//  Copyright © 2016年 MXClient. All rights reserved.
//

#import "HTMIBaseViewController.h"
#import "SVProgressHUD.h"

#ifndef kDefaultBackgroundColor

#define kDefaultBackgroundColor [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0]

#endif

@interface HTMIBaseViewController ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong,readwrite)HTMIBasedViewModel *viewModel;

@property(nonatomic,strong,readwrite)UIPercentDrivenInteractiveTransition *interactivePopTransition;

@end

@implementation HTMIBaseViewController

- (instancetype)initWithViewModel:(HTMIBasedViewModel *)viewModel
{
    if (self == [super init])
    {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
}

// 是否支持旋转
- (BOOL)shouldAutorotate {
    return NO;
}

// 支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

// 默认方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kDefaultBackgroundColor;
    
    self.viewModel.naviImpl = [[HTMIViewModelNavigationImpl alloc]
                               initWithNavigationController:self.navigationController];
    if (self.navigationController && self != self.navigationController.viewControllers.firstObject)
    {
        /*
         UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePopRecognizer:)];
         [self.view addGestureRecognizer:popRecognizer];
         popRecognizer.delegate = self;
         */
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
    //        if (self.navigationController) {
    //            self.navigationController.interactivePopGestureRecognizer.enabled = NO;      // 手势有效设置为YES  无效为NO
    //            self.navigationController.interactivePopGestureRecognizer.delegate = self;    // 手势的代理设置为self
    //        }
    //    }
    
    //    //禁止页面返回手势
    //    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    //        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    //    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    // 此处做兼容处理需要加上ios6.0的宏开关，保证是在6.0下使用的,6.0以前屏蔽以下代码，否则会在下面使用self.view时自动加载viewDidUnLoad
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
        //需要注意的是self.isViewLoaded是必不可少的，其他方式访问视图会导致它加载 ，在WWDC视频也忽视这一点。
        if (self.isViewLoaded && !self.view.window)// 是否是正在使用的视图
        {
            //code
            self.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
        }
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)handlePopRecognizer:(UIPanGestureRecognizer *)recognizer
{
    CGFloat progress = [recognizer translationInView:self.view].x / CGRectGetWidth(self.view.frame);
    progress = MIN(1.0, MAX(0.0, progress));
    NSLog(@"progress---%.2f",progress);
    
    static BOOL flag = NO;
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        flag = YES;
    }
    if (flag && progress > 0)
    {
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
        [self.navigationController popViewControllerAnimated:YES];
        flag = NO;
    }
    
    //    if (progress <= 0 && !self.w_isDraging && recognizer.state != UIGestureRecognizerStateBegan) {
    //        return;
    //    }
    //    if (recognizer.state == UIGestureRecognizerStateBegan)
    //    {
    //        self.w_isDraging = YES;
    //        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
    //        [self.navigationController popViewControllerAnimated:YES];
    //    }
    if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        [self.interactivePopTransition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled)
    {
        if (progress > 0.25)
        {
            [self.interactivePopTransition finishInteractiveTransition];
        }
        else
        {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        self.interactivePopTransition = nil;
    }
}

#pragma mark - 监听到字体改变

- (void)fontSizeChange {
    
    [self setFontFamily:@"" forView:self.view andSubViews:YES];
}

// 遍历self.view 中所有的UILabel设置其字体
- (void)setFontFamily:(NSString*)fontFamily forView:(UIView*)view andSubViews:(BOOL)isSubViews {
    
    if ([view isKindOfClass:[UILabel class]])
    {
        
    }
    else if([view isKindOfClass:[UIButton class]]){
        
    }
    
    if (isSubViews)
    {
        for (UIView *sview in view.subviews)
        {
            [self setFontFamily:fontFamily forView:sview andSubViews:YES];
        }
    }
}


@end
