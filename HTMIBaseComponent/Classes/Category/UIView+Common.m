//
//  UIView+Common.m
//  Coding_iOS
//
//  Created by 王 原闯 on 14-8-6.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import "UIView+Common.h"

#import <objc/runtime.h>
#import "UIColor+expanded.h"
#import "Masonry.h"
//#import "UIBadgeView.h"
#import "HTMISettingManager.h"

#ifndef kColorDDD
#define kColorDDD [UIColor colorWithHexString:@"0xDDDDDD"]
#endif
#ifndef kColorBrandGreen
#define kColorBrandGreen [UIColor colorWithHexString:@"0x3BBD79"]
#endif

#define kTagBadgeView  1000
#define kTagBadgePointView  1001
#define kTagLineView 1007

@implementation UIView (Common)
static char LoadingViewKey, BlankPageViewKey;

@dynamic borderColor,borderWidth,cornerRadius, masksToBounds;

/**
 *  边框
 */
+ (UIView *)creatBorderViewFrame:(CGRect)frame {
    UIView *borderView = [[UIView alloc] initWithFrame:frame];
    borderView.userInteractionEnabled = YES;
    borderView.layer.borderWidth = 1.0;
    borderView.layer.borderColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0].CGColor;
    borderView.layer.masksToBounds = YES;
    borderView.layer.cornerRadius = 2.0;
    //    borderView.backgroundColor = [UIColor clearColor];//水印
    
    return borderView;
}

-(void)setBorderColor:(UIColor *)borderColor{
    [self.layer setBorderColor:borderColor.CGColor];
}

-(void)setBorderWidth:(CGFloat)borderWidth{
    [self.layer setBorderWidth:borderWidth];
}

-(void)setCornerRadius:(CGFloat)cornerRadius{
    [self.layer setCornerRadius:cornerRadius];
}

- (void)setMasksToBounds:(BOOL)masksToBounds{
    [self.layer setMasksToBounds:masksToBounds];
}

- (void)doCircleFrame{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.frame.size.width/2;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = kColorDDD.CGColor;
}

- (void)doNotCircleFrame{
    self.layer.cornerRadius = 0.0;
    self.layer.borderWidth = 0.0;
}

- (void)doBorderWidth:(CGFloat)width color:(UIColor *)color cornerRadius:(CGFloat)cornerRadius{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = width;
    if (!color) {
        self.layer.borderColor = kColorDDD.CGColor;
    }else{
        self.layer.borderColor = color.CGColor;
    }
}

- (UIViewController *)findViewController
{
    for (UIView* next = self; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
/*
 - (void)addBadgePoint:(NSInteger)pointRadius withPosition:(BadgePositionType)type {
 
 if(pointRadius < 1)
 return;
 
 [self removeBadgePoint];
 
 UIView *badgeView = [[UIView alloc]init];
 badgeView.tag = kTagBadgePointView;
 badgeView.layer.cornerRadius = pointRadius;
 badgeView.backgroundColor = [UIColor redColor];
 
 switch (type) {
 
 case BadgePositionTypeMiddle:
 badgeView.frame = CGRectMake(0, self.frame.size.height / 2 - pointRadius, 2 * pointRadius, 2 * pointRadius);
 break;
 
 default:
 badgeView.frame = CGRectMake(self.frame.size.width - 2 * pointRadius, 0, 2 * pointRadius, 2 * pointRadius);
 break;
 }
 
 [self addSubview:badgeView];
 }
 
 - (void)addBadgePoint:(NSInteger)pointRadius withPointPosition:(CGPoint)point {
 
 if(pointRadius < 1)
 return;
 
 [self removeBadgePoint];
 
 UIView *badgeView = [[UIView alloc]init];
 badgeView.tag = kTagBadgePointView;
 badgeView.layer.cornerRadius = pointRadius;
 badgeView.backgroundColor = [UIColor colorWithHexString:@"0xf75388"];
 badgeView.frame = CGRectMake(0, 0, 2 * pointRadius, 2 * pointRadius);
 badgeView.center = point;
 [self addSubview:badgeView];
 }
 
 - (void)removeBadgePoint {
 
 for (UIView *subView in self.subviews) {
 
 if(subView.tag == kTagBadgePointView)
 [subView removeFromSuperview];
 }
 }
 
 - (void)addBadgeTip:(NSString *)badgeValue withCenterPosition:(CGPoint)center{
 if (!badgeValue || !badgeValue.length) {
 [self removeBadgeTips];
 }else{
 UIView *badgeV = [self viewWithTag:kTagBadgeView];
 if (badgeV && [badgeV isKindOfClass:[UIBadgeView class]]) {
 [(UIBadgeView *)badgeV setBadgeValue:badgeValue];
 badgeV.hidden = NO;
 }else{
 badgeV = [UIBadgeView viewWithBadgeTip:badgeValue];
 badgeV.tag = kTagBadgeView;
 [self addSubview:badgeV];
 }
 [badgeV setCenter:center];
 }
 }
 - (void)addBadgeTip:(NSString *)badgeValue{
 if (!badgeValue || !badgeValue.length) {
 [self removeBadgeTips];
 }else{
 UIView *badgeV = [self viewWithTag:kTagBadgeView];
 if (badgeV && [badgeV isKindOfClass:[UIBadgeView class]]) {
 [(UIBadgeView *)badgeV setBadgeValue:badgeValue];
 }else{
 badgeV = [UIBadgeView viewWithBadgeTip:badgeValue];
 badgeV.tag = kTagBadgeView;
 [self addSubview:badgeV];
 }
 CGSize badgeSize = badgeV.frame.size;
 CGSize selfSize = self.frame.size;
 CGFloat offset = 2.0;
 [badgeV setCenter:CGPointMake(selfSize.width- (offset+badgeSize.width/2),
 (offset +badgeSize.height/2))];
 }
 }
 - (void)removeBadgeTips{
 NSArray *subViews =[self subviews];
 if (subViews && [subViews count] > 0) {
 for (UIView *aView in subViews) {
 if (aView.tag == kTagBadgeView && [aView isKindOfClass:[UIBadgeView class]]) {
 aView.hidden = YES;
 }
 }
 }
 }
 */
- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size.width = size.width;
    frame.size.height = size.height;
    self.frame = frame;
}

- (CGFloat)maxXOfFrame{
    return CGRectGetMaxX(self.frame);
}

- (void)setSubScrollsToTop:(BOOL)scrollsToTop{
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)obj setScrollEnabled:scrollsToTop];
            *stop = YES;
        }
    }];
}

- (void)addGradientLayerWithColors:(NSArray *)cgColorArray{
    [self addGradientLayerWithColors:cgColorArray locations:nil startPoint:CGPointMake(0.0, 0.5) endPoint:CGPointMake(1.0, 0.5)];
}

- (void)addGradientLayerWithColors:(NSArray *)cgColorArray locations:(NSArray *)floatNumArray startPoint:(CGPoint )startPoint endPoint:(CGPoint)endPoint{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.bounds;
    if (cgColorArray && [cgColorArray count] > 0) {
        layer.colors = cgColorArray;
    }else{
        return;
    }
    if (floatNumArray && [floatNumArray count] == [cgColorArray count]) {
        layer.locations = floatNumArray;
    }
    layer.startPoint = startPoint;
    layer.endPoint = endPoint;
    [self.layer addSublayer:layer];
}


+ (CGRect)frameWithOutNav{
    CGRect frame = [UIScreen mainScreen].bounds;
    frame.size.height -= (20+44);//减去状态栏、导航栏的高度
    return frame;
}

+ (UIViewAnimationOptions)animationOptionsForCurve:(UIViewAnimationCurve)curve
{
    switch (curve) {
        case UIViewAnimationCurveEaseInOut:
            return UIViewAnimationOptionCurveEaseInOut;
            break;
        case UIViewAnimationCurveEaseIn:
            return UIViewAnimationOptionCurveEaseIn;
            break;
        case UIViewAnimationCurveEaseOut:
            return UIViewAnimationOptionCurveEaseOut;
            break;
        case UIViewAnimationCurveLinear:
            return UIViewAnimationOptionCurveLinear;
            break;
    }
    
    return kNilOptions;
}

+ (UIView *)lineViewWithPointHTMIYY:(CGFloat)pointY{
    return [self lineViewWithPointHTMIYY:pointY andColor:kColorDDD];
}

+ (UIView *)lineViewWithPointHTMIYY:(CGFloat)pointY andColor:(UIColor *)color{
    return [self lineViewWithPointHTMIYY:pointY andColor:color andLeftSpace:0];
}

+ (UIView *)lineViewWithPointHTMIYY:(CGFloat)pointY andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(leftSpace, pointY, [UIScreen mainScreen].bounds.size.width - leftSpace, 0.5)];
    lineView.backgroundColor = color;
    return lineView;
}

+ (void)outputTreeInView:(UIView *)view withSeparatorCount:(NSInteger)count{
    NSString *outputStr = @"";
    outputStr = [outputStr stringByReplacingCharactersInRange:NSMakeRange(0, count) withString:@"-"];
    outputStr = [outputStr stringByAppendingString:view.description];
    printf("%s\n", outputStr.UTF8String);
    
    if (view.subviews.count == 0) {
        return;
    }else{
        count++;
        for (UIView *subV in view.subviews) {
            [self outputTreeInView:subV withSeparatorCount:count];
        }
    }
}

- (void)outputSubviewTree{
    [UIView outputTreeInView:self withSeparatorCount:0];
}

- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown{
    [self addLineUp:hasUp andDown:hasDown andColor:kColorDDD];
}

- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color{
    [self removeViewWithTag:kTagLineView];
    if (hasUp) {
        UIView *upView = [UIView lineViewWithPointHTMIYY:0 andColor:color];
        upView.tag = kTagLineView;
        [self addSubview:upView];
    }
    if (hasDown) {
        UIView *downView = [UIView lineViewWithPointHTMIYY:CGRectGetMaxY(self.bounds)-0.5 andColor:color];
        downView.tag = kTagLineView;
        [self addSubview:downView];
    }
    return [self addLineUp:hasUp andDown:hasDown andColor:color andLeftSpace:0];
}
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace{
    [self removeViewWithTag:kTagLineView];
    if (hasUp) {
        UIView *upView = [UIView lineViewWithPointHTMIYY:0 andColor:color andLeftSpace:leftSpace];
        upView.tag = kTagLineView;
        [self addSubview:upView];
    }
    if (hasDown) {
        UIView *downView = [UIView lineViewWithPointHTMIYY:CGRectGetMaxY(self.bounds)-0.5 andColor:color andLeftSpace:leftSpace];
        downView.tag = kTagLineView;
        [self addSubview:downView];
    }
}
- (void)removeViewWithTag:(NSInteger)tag{
    for (UIView *aView in [self subviews]) {
        if (aView.tag == tag) {
            [aView removeFromSuperview];
        }
    }
}

- (void)addRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [CAShapeLayer new];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (CGSize)doubleSizeOfFrame{
    CGSize size = self.frame.size;
    return CGSizeMake(size.width*2, size.height*2);
}
#pragma mark LoadingView
- (void)setLoadingView:(EaseLoadingView *)loadingView{
    [self willChangeValueForKey:@"LoadingViewKey"];
    objc_setAssociatedObject(self, &LoadingViewKey,
                             loadingView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"LoadingViewKey"];
}
- (EaseLoadingView *)loadingView{
    return objc_getAssociatedObject(self, &LoadingViewKey);
}

- (void)beginLoading{
    for (UIView *aView in [self.blankPageContainer subviews]) {
        if ([aView isKindOfClass:[EaseBlankPageView class]] && !aView.hidden) {
            return;
        }
    }
    
    if (!self.loadingView) { //初始化LoadingView
        self.loadingView = [[EaseLoadingView alloc] initWithFrame:self.bounds];
    }
    [self addSubview:self.loadingView];
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.self.edges.equalTo(self);
    }];
    [self.loadingView startAnimating];
}

- (void)endLoading{
    if (self.loadingView) {
        [self.loadingView stopAnimating];
    }
}

#pragma mark BlankPageView
- (void)setBlankPageView:(EaseBlankPageView *)blankPageView{
    [self willChangeValueForKey:@"BlankPageViewKey"];
    objc_setAssociatedObject(self, &BlankPageViewKey,
                             blankPageView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"BlankPageViewKey"];
}

- (EaseBlankPageView *)blankPageView{
    return objc_getAssociatedObject(self, &BlankPageViewKey);
}

- (void)configBlankPage:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void (^)(id))block{
    [self configBlankPage:blankPageType hasData:hasData hasError:hasError offsetY:0 reloadButtonBlock:block];
}

- (void)configBlankPage:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError offsetY:(CGFloat)offsetY reloadButtonBlock:(void(^)(id sender))block{
    if (hasData) {
        if (self.blankPageView) {
            self.blankPageView.hidden = YES;
            [self.blankPageView removeFromSuperview];
        }
    }else{
        if (!self.blankPageView) {
            self.blankPageView = [[EaseBlankPageView alloc] initWithFrame:self.bounds];
        }
        self.blankPageView.hidden = NO;
        [self.blankPageContainer insertSubview:self.blankPageView atIndex:0];
        [self.blankPageView configWithType:blankPageType hasData:hasData hasError:hasError offsetY:offsetY reloadButtonBlock:block];
    }
}

- (UIView *)blankPageContainer{
    UIView *blankPageContainer = self;
    for (UIView *aView in [self subviews]) {
        if ([aView isKindOfClass:[UITableView class]]) {
            blankPageContainer = aView;
        }
    }
    return blankPageContainer;
}

@end


@interface EaseLoadingView ()
@property (nonatomic, assign) CGFloat loopAngle, monkeyAlpha, angleStep, alphaStep;
@end


@implementation EaseLoadingView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _loopView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_loop"]];
        _loopView.userInteractionEnabled = YES;
        _monkeyView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_monkey"]];
        _monkeyView.userInteractionEnabled = YES;
        [_loopView setCenter:self.center];
        [_monkeyView setCenter:self.center];
        [self addSubview:_loopView];
        [self addSubview:_monkeyView];
        [_loopView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        [_monkeyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        
        _loopAngle = 0.0;
        _monkeyAlpha = 1.0;
        _angleStep = 360/3;
        _alphaStep = 1.0/3.0;
    }
    return self;
}

- (void)startAnimating{
    self.hidden = NO;
    if (_isLoading) {
        return;
    }
    _isLoading = YES;
    [self loadingAnimation];
}

- (void)stopAnimating{
    self.hidden = YES;
    _isLoading = NO;
}

- (void)loadingAnimation{
    static CGFloat duration = 0.25f;
    _loopAngle += _angleStep;
    if (_monkeyAlpha >= 1.0 || _monkeyAlpha <= 0.0) {
        _alphaStep = -_alphaStep;
    }
    _monkeyAlpha += _alphaStep;
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        CGAffineTransform loopAngleTransform = CGAffineTransformMakeRotation(_loopAngle * (M_PI / 180.0f));
        _loopView.transform = loopAngleTransform;
        _monkeyView.alpha = _monkeyAlpha;
    } completion:^(BOOL finished) {
        if (_isLoading && [self superview] != nil) {
            [self loadingAnimation];
        }else{
            [self removeFromSuperview];
            
            _loopAngle = 0.0;
            _monkeyAlpha = 1,0;
            _alphaStep = ABS(_alphaStep);
            CGAffineTransform loopAngleTransform = CGAffineTransformMakeRotation(_loopAngle * (M_PI / 180.0f));
            _loopView.transform = loopAngleTransform;
            _monkeyView.alpha = _monkeyAlpha;
        }
    }];
}

@end

@implementation EaseBlankPageView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)configWithType:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError offsetY:(CGFloat)offsetY reloadButtonBlock:(void (^)(id))block{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_loadAndShowStatusBlock) {
            _loadAndShowStatusBlock();
        }
    });
    
    if (hasData) {
        [self removeFromSuperview];
        return;
    }
    self.alpha = 1.0;
    
    //图片
    if (!_monkeyView) {
        _monkeyView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _monkeyView.userInteractionEnabled = YES;
        [self addSubview:_monkeyView];
    }
    //文字
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.numberOfLines = 0;
        _tipLabel.font = [UIFont htmi_systemFontOfSize:15];
        _tipLabel.textColor = [UIColor lightGrayColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.userInteractionEnabled = YES;
        [self addSubview:_tipLabel];
        
        UITapGestureRecognizer *tipLabelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tipLabelClick:)];
        tipLabelTap.delegate = self;
        [_tipLabel addGestureRecognizer:tipLabelTap];
    }
    
    //布局
    [_monkeyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        if (ABS(offsetY) > 1.0) {
            make.top.equalTo(self).offset(offsetY);
        }else{
            //make.bottom.equalTo(self.mas_centerY);
            make.centerY.equalTo(self.mas_centerY).offset(-30);
        }
    }];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.centerX.equalTo(self);
        make.top.equalTo(_monkeyView.mas_bottom);
        make.height.mas_equalTo(50);
    }];
    
    _reloadButtonBlock = nil;
    //    if (hasError) {
    //        //加载失败
    //        if (!_reloadButton) {
    //            _reloadButton = [[UIButton alloc] initWithFrame:CGRectZero];
    //            //[_reloadButton setImage:[UIImage imageNamed:@"blankpage_button_reload"] forState:UIControlStateNormal];
    //            //_reloadButton.adjustsImageWhenHighlighted = YES;
    //            [_reloadButton setBackgroundImage:[UIImage imageWithRenderColor:kHTMI_HUEControlColor renderSize:CGSizeMake(10., 10.)] forState:UIControlStateNormal];
    //
    //            [_reloadButton setTitle:@"刷新" forState:UIControlStateNormal];
    //
    //            [_reloadButton addTarget:self action:@selector(reloadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    //            [self addSubview:_reloadButton];
    //            [_reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
    //                make.centerX.equalTo(self);
    //                make.top.equalTo(_tipLabel.mas_bottom);
    //                make.size.mas_equalTo(CGSizeMake(150, 50));
    //            }];
    //        }
    //        _reloadButton.hidden = NO;
    //        _reloadButtonBlock = block;
    //
    //        [_monkeyView setImage:[UIImage imageNamed:@"img_no_wifi"]];
    //        _tipLabel.text = @"网络连接失败";
    //    }else{
    
    //        //空白数据
    //        if (_reloadButton) {
    //            _reloadButton.hidden = YES;
    //        }
    
    NSString *imageName, *tipStr;
    _curType=blankPageType;
    switch (blankPageType) {
        case EaseBlankPageTypeNoNetWork:{//没有网络
            imageName = @"img_no_wifi";//1
            tipStr = @"网络连接失败\n点击刷新";
        }
            break;
        case EaseBlankPageTypeDefaultNoData:{//没有数据
            imageName = @"img_empty_nodata";
            tipStr = @"当前没有数据\n点击刷新";
        }
            break;
        case EaseBlankPageTypeRequestError:{//404
            imageName = @"img_page_none";//1
            tipStr = @"服务器连接异常\n点击返回上一页";
        }
            break;
            
        case EaseBlankPageTypeRequestTimeOut:{//超时
            imageName = @"img_page_none";
            tipStr = @"服务器连接异常\n点击刷新";
        }
            break;
        case EaseBlankPageTypeAppCenter_Main:{
            imageName = @"img_no_application";//2
            tipStr = @"当前没有数据\n点击刷新";
        }
            break;
        case EaseBlankPageTypeShortcutkeys_Edit:{
            imageName = @"img_no_add";//2
            tipStr = @"暂无应用可编辑";
        }
            break;
            
        case EaseBlankPageType_Error:{
            imageName = @"img_page_none";
            tipStr = @"这个页面丢了\n点击刷新";
        }
            break;
        case EaseBlankPageTypeSubAccountMamage_Main:{
            imageName = @"img_empty_nodata";
            tipStr = @"没有子账号";
        }
            break;
        case EaseBlankPageTypeTableFormNoData:{
            imageName = @"img_empty_nodata";
            tipStr = @"当前没有数据\n点击刷新";
        }
            break;
        case EaseBlankPageTypeMatterAttachmentError:{
            imageName = @"img_empty_nodata";
            tipStr = @"没有找到附件记录";
        }
            break;
        case EaseBlankPageTypecompanAddressBook:{
            imageName = @"img_empty_nodata";
            tipStr = @"暂无记录";
        }
            break;
        case EaseBlankPageTypesearchCompanAddressBook:{
            imageName = @"img_empty_nodata";
            tipStr = @"暂无搜索结果，请重试";
        }
            break;
        case EaseBlankPageTypeSearchNoResult:{
            imageName = @"img_empty_nodata";
            tipStr = @"抱歉没有找到相关的搜索结果\n换个词试试吧";
        }
            break;
        case EaseBlankPageTypeNoDataScheduleList:{
            imageName = @"img_empty_nodata";
            tipStr = @"当前没有日程\n点击刷新或添加一条新日程";
        }
            break;
        case EaseBlankPageTypeResponseError:{
            imageName = @"img_empty_nodata";
            tipStr = @"这里还什么都没有";
        }
            break;
        default://其它页面（这里没有提到的页面，都属于其它）
        {
            imageName = @"img_empty_nodata";
            tipStr = @"这里还什么都没有";
        }
            break;
    }
    _reloadButtonBlock = block;
    [_monkeyView setImage:[UIImage imageNamed:imageName]];
    _tipLabel.text = tipStr;
    
    if ((blankPageType < 0)) {
        
        [_monkeyView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.mas_centerY).offset(-35);
        }];
        
        //新增按钮
        UIButton *actionBtn=({
            UIButton *button=[UIButton new];
            button.backgroundColor=kColorBrandGreen;
            button.titleLabel.font=[UIFont htmi_systemFontOfSize:15];
            [button addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
            button.layer.cornerRadius=18;
            button.layer.masksToBounds=TRUE;
            button;
        });
        
        [self addSubview:actionBtn];
        
        [actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(125 , 36));
            make.top.equalTo(_tipLabel.mas_bottom).offset(15);
            make.centerX.equalTo(self);
        }];
        
        NSString *titleStr;
        switch (blankPageType) {
                
                //case EaseBlankPageTypeProject_WATCHED:
                //titleStr=@"+ 去关注";
                //[actionBtn setTitle:@"+ 去关注" forState:UIControlStateNormal];
                //break;
                
            default:
                break;
        }
        //NSMutableAttributedString *titleFontStr=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"+ %@",titleStr]];
        //            NSRange range;
        //            range.location=0;
        //            range.length=1;
        //            [titleFontStr addAttribute:NSFontAttributeName value:[UIFont htmi_systemFontOfSize:20] range:range];
        //            [actionBtn setAttributedTitle:titleFontStr forState:UIControlStateNormal];
        [actionBtn setTitle:titleStr forState:UIControlStateNormal];
        
    }
    
    
    //    }
}


/**
 底部刷新按钮点击事件
 
 @param sender 按钮
 */
- (void)reloadButtonClicked:(id)sender{
    //    self.hidden = YES;
    //    [self removeFromSuperview];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_reloadButtonBlock) {
            _reloadButtonBlock(sender);
        }
    });
}

/**
 添加按钮点击事件
 */
- (void)btnAction{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (_clickButtonBlock) {
            _clickButtonBlock(_curType);
        }
    });
}

/**
 文字点击事件
 
 @param tap 手势
 */
- (void)tipLabelClick:(UITapGestureRecognizer *)tap {
    
    if (_reloadButtonBlock) {
        _reloadButtonBlock(tap);
    }
}

@end

