//
//  HTMICurrentViewController.m
//  HTMITemplate
//
//  Created by wlq on 17/5/8.
//  Copyright © 2017年 htmi. All rights reserved.
//

#import "HTMICurrentViewController.h"

#import "UIViewController+Utility.h"

UIViewController * kHTMICurrentViewController = nil;

@implementation HTMICurrentViewController

/**
 *  获取当前屏幕显示的viewcontroller
 *
 *  @return 当前屏幕显示的viewcontroller
 */
+ (UIViewController *)currentViewController
{
    @try {
        
        return [UIViewController currentViewController];
        
    } @catch (NSException *exception) {
        
        //[Bugly reportException:exception];
        return kHTMICurrentViewController;
    } @finally {
        
    }
}

@end
