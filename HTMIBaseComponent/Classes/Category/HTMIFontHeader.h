//
//  HTMIFontHeader.h
//  HBFontChange
//
//  Created by 胡明波 on 16/12/15.
//  Copyright © 2016年 mingboJob. All rights reserved.
//
//在这里设置字体大小
#ifndef HTMIFontHeader_h
#define HTMIFontHeader_h
//测试字体大小
//比如说是标题大小
#define    TITLE_FONT                   @"titleFontSize"
//内容字体大小
#define    CONTENT_FONT                 @"contentFontSize"
//详情字体大小
#define    DETAILS_FONT                  @"detailsFontSize"

#define ALL_FONT_CHANGE                 @"allFontChange"

static    float FONT_TITLE_SIZE    =        20.0;
static    float FONT_CONTENT_SIZE  =        16.0;
static    float FONT_DETAILS_SIZE  =        14.0;

#define     Font(F)             [UIFont htmi_systemFontOfSize:(F)]

#define USERDEFAULT_float(key) [[NSUserDefaults standardUserDefaults] floatForKey:key]


//-------------------NSUserDefaults-----------------------
//NSUserDefaults 实例化 取值
#define USERDEFAULT [NSUserDefaults standardUserDefaults]
#define USERDEFAULT_value(key) [[NSUserDefaults standardUserDefaults] valueForKey:key]

#define USERDEFAULT_object(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define USERDEFAULT_BOOL(key) [[NSUserDefaults standardUserDefaults] boolForKey:key]
#define USERDEFAULT_integer(key) [[NSUserDefaults standardUserDefaults] integerForKey:key]

#define USERDEFAULT_int(key) [[[NSUserDefaults standardUserDefaults] objectForKey:key] intValue]
//NSUserDefaults 实例化 存值
// object
#define USERDEFAULT_SET_value(_value_,_key_) [[NSUserDefaults standardUserDefaults] setValue:_value_ forKey:_key_];\
[[NSUserDefaults standardUserDefaults] synchronize]

#define USERDEFAULT_SET_object(_object_,_key_) [[NSUserDefaults standardUserDefaults] setObject:_object_ forKey:_key_];\
[[NSUserDefaults standardUserDefaults] synchronize]
// int
#define USERDEFAULT_SET_int(_int_,_key_) NSString *uIntString=[NSString stringWithFormat:@"%d",_int_];\
[[NSUserDefaults standardUserDefaults] setObject:uIntString forKey:_key_];\
[[NSUserDefaults standardUserDefaults] synchronize]
//float
#define USERDEFAULT_SET_float(_float_,_key_) NSString *uFloatString=[NSString stringWithFormat:@"%f",_float_];\
[[NSUserDefaults standardUserDefaults] setObject:uFloatString forKey:_key_];\
[[NSUserDefaults standardUserDefaults] synchronize]

#define USERDEFAULT_SET_bool(_bool_,_key_)   [[NSUserDefaults standardUserDefaults]setBool:_bool_ forKey:_key_];\
[[NSUserDefaults standardUserDefaults] synchronize];


//-------------------NSUserDefaults-----------------------


#endif /* HTMIFontHeader_h */
