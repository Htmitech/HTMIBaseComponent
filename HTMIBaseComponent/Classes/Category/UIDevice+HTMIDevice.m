//
//  UIDevice+HTMIDevice.m
//  MXClient
//
//  Created by wlq on 2018/4/14.
//  Copyright © 2018年 MXClient. All rights reserved.
//

#import "UIDevice+HTMIDevice.h"

@implementation UIDevice (HTMIDevice)

+ (void)switchNewOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    
    [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
    
    NSNumber *orientationTarget = [NSNumber numberWithInt:interfaceOrientation];
    
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
}

@end
