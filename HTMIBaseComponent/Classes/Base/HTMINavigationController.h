//
//  TTNavigationController.h
//  TTNews
//
//  Created by 瑞文戴尔 on 16/3/25.
//  Copyright © 2016年 瑞文戴尔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTMINavigationController : UINavigationController

/**
 获取侧滑返回手势
 
 @return 屏幕侧滑手势
 */
- (UIScreenEdgePanGestureRecognizer *)screenEdgePanGestureRecognizer;

@end
