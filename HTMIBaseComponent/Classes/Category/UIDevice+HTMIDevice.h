//
//  UIDevice+HTMIDevice.h
//  MXClient
//
//  Created by wlq on 2018/4/14.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (HTMIDevice)

/**
 * @interfaceOrientation 输入要强制转屏的方向
 */
+ (void)switchNewOrientation:(UIInterfaceOrientation)interfaceOrientation;

@end
