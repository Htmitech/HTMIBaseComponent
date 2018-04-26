//
//  UIView+Common.h
//  Coding_iOS
//
//  Created by 王 原闯 on 14-8-6.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<QuartzCore/QuartzCore.h>
#import "UIView+Extension.h"

@class EaseLoadingView, EaseBlankPageView;

typedef NS_ENUM(NSInteger, EaseBlankPageType)
{
    EaseBlankPageTypeDefaultNoData = 0,//没有数据
    EaseBlankPageTypeNoNetWork,//没有网络
    EaseBlankPageType_Error,//不确定的的Error
    EaseBlankPageTypeRequestTimeOut,//网络超时
    EaseBlankPageTypeRequestError,//接口不通错误
    EaseBlankPageTypeResponseError,//接口返回结果错误
    EaseBlankPageTypeAppCenter_Main,//应用中心首页
    EaseBlankPageTypeShortcutkeys_Edit,//快捷键编辑页面
    EaseBlankPageTypeSubAccountMamage_Main,//子账号主页面
    EaseBlankPageTypeTableFormNoData,//表单无数据
    EaseBlankPageTypeMatterAttachmentError,//附件出错
    EaseBlankPageTypecompanAddressBook,//附件出错
    EaseBlankPageTypesearchCompanAddressBook,//附件出错
    EaseBlankPageTypeNoDataScheduleList,//日程列表无数据
    EaseBlankPageTypeSearchNoResult,//通用的搜索无结果
};

typedef NS_ENUM(NSInteger, BadgePositionType) {
    
    BadgePositionTypeDefault = 0,
    BadgePositionTypeMiddle
};

@interface UIView (Common)<UIGestureRecognizerDelegate>
@property (nonatomic) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable BOOL masksToBounds;

/**
 *  边框
 */
+ (UIView *)creatBorderViewFrame:(CGRect)frame;

- (void)doCircleFrame;
- (void)doNotCircleFrame;
- (void)doBorderWidth:(CGFloat)width color:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;

- (UIViewController *)findViewController;
- (void)addBadgeTip:(NSString *)badgeValue withCenterPosition:(CGPoint)center;
- (void)addBadgeTip:(NSString *)badgeValue;
- (void)addBadgePoint:(NSInteger)pointRadius withPosition:(BadgePositionType)type;
- (void)addBadgePoint:(NSInteger)pointRadius withPointPosition:(CGPoint)point;
- (void)removeBadgePoint;
- (void)removeBadgeTips;
- (void)setY:(CGFloat)y;
- (void)setX:(CGFloat)x;
- (void)setOrigin:(CGPoint)origin;
- (void)setHeight:(CGFloat)height;
- (void)setWidth:(CGFloat)width;
- (void)setSize:(CGSize)size;
- (CGFloat)maxXOfFrame;

- (void)setSubScrollsToTop:(BOOL)scrollsToTop;


- (void)addGradientLayerWithColors:(NSArray *)cgColorArray;
- (void)addGradientLayerWithColors:(NSArray *)cgColorArray locations:(NSArray *)floatNumArray startPoint:(CGPoint )aPoint endPoint:(CGPoint)endPoint;
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown;
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color;
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace;

- (void)addRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

- (void)removeViewWithTag:(NSInteger)tag;
- (CGSize)doubleSizeOfFrame;
- (void)outputSubviewTree;//输出子视图的目录树

+ (CGRect)frameWithOutNav;
+ (UIViewAnimationOptions)animationOptionsForCurve:(UIViewAnimationCurve)curve;
+ (UIView *)lineViewWithPointHTMIYY:(CGFloat)pointY;
+ (UIView *)lineViewWithPointHTMIYY:(CGFloat)pointY andColor:(UIColor *)color;
+ (UIView *)lineViewWithPointHTMIYY:(CGFloat)pointY andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace;
+ (void)outputTreeInView:(UIView *)view withSeparatorCount:(NSInteger)count;//输出某个View的subview目录

#pragma mark LoadingView
@property (strong, nonatomic) EaseLoadingView *loadingView;
- (void)beginLoading;
- (void)endLoading;

#pragma mark BlankPageView
@property (strong, nonatomic) EaseBlankPageView *blankPageView;
- (void)configBlankPage:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;
- (void)configBlankPage:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError offsetY:(CGFloat)offsetY reloadButtonBlock:(void(^)(id sender))block;
@end

@interface EaseLoadingView : UIView
@property (strong, nonatomic) UIImageView *loopView, *monkeyView;
@property (assign, nonatomic, readonly) BOOL isLoading;
- (void)startAnimating;
- (void)stopAnimating;
@end

@interface EaseBlankPageView : UIView
@property (strong, nonatomic) UIImageView *monkeyView;
@property (strong, nonatomic) UILabel *tipLabel;
@property (strong, nonatomic) UIButton *reloadButton;
@property (assign, nonatomic) EaseBlankPageType curType;
@property (copy, nonatomic) void(^reloadButtonBlock)(id sender);
@property (copy, nonatomic) void(^loadAndShowStatusBlock)();
@property (copy, nonatomic) void(^clickButtonBlock)(EaseBlankPageType curType);
@property (copy, nonatomic) void(^tipLabelBlock)();
- (void)configWithType:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError offsetY:(CGFloat)offsetY reloadButtonBlock:(void(^)(id sender))block;
@end

