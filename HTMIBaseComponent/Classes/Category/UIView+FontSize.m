//
//  UIView+FontSize.m
//  FontSizeModify
//
//  Created by 王立权 on 16/10/22.
//  Copyright © 2016年 王立权. All rights reserved.
//

#import "UIView+FontSize.h"
#import <objc/runtime.h>
#import "HTMIFontHeader.h"

#define IgnoreTagKey @"IgnoreTagKey"
#define FontScaleKey @"FontScaleKey"

#define ScrenScale [UIScreen mainScreen].bounds.size.width/320.0

@implementation UIView (FontSize)
///**
// 设置需要忽略的空间tag值
//
// @param tagArr tag值数组
// */
//+ (void)setIgnoreTags:(NSArray<NSNumber*> *)tagArr{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:tagArr forKey:IgnoreTagKey];
//    [defaults synchronize];
//}


+ (CGFloat)getFontScale{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *valueNum = [defaults objectForKey:FontScaleKey];
    return valueNum?valueNum.floatValue:0;
}

@end


@interface UIButton (FontSize)

@end

@interface UITextField (FontSize)

@end

@interface UITextView (FontSize)

@end

@implementation UILabel (FontSize)

static const void *customAnimatingKey = @"HTMI_CustomAnimatingKey";//&customAnimatingKey;

//@dynamic originalFontSize;

- (NSNumber *)originalFontSize {
    return objc_getAssociatedObject(self, &customAnimatingKey);
}

- (void)setOriginalFontSize:(NSNumber *)fontSize{
    
    objc_setAssociatedObject(self, &customAnimatingKey, fontSize, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load{
    if(!UILabelEnable) return;
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
    
    Method cmp = class_getInstanceMethod([self class], @selector(initWithFrame:));
    Method myCmp = class_getInstanceMethod([self class], @selector(myInitWithFrame:));
    method_exchangeImplementations(cmp, myCmp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode {
    [self myInitWithCoder:aDecode];
    if (self) {
        //        //代码创建的时候 还不能拿到之后设置的tag 所以无法判断忽略项
        //        NSArray *ignoreTags = [UIView getIgnoreTags];
        //        for (NSNumber *num in ignoreTags) {
        //            if(self.tag == num.integerValue) return self;
        //        }
        CGFloat fontSize = self.font.pointSize;
        
        self.originalFontSize = @(fontSize);
        self.font = [self.font fontWithSize:fontSize];
        
        //接收通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fontSizeChange) name:ALL_FONT_CHANGE object:nil];
        
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ALL_FONT_CHANGE object:nil];
}

#pragma mark - 监听到字体改变

- (void)fontSizeChange{
    
    
    
    float originalValue = [[self originalFontSize] floatValue];
    
    self.font = [self.font fontWithSize:originalValue];
}


- (id)myInitWithFrame:(CGRect)frame{
    [self myInitWithFrame:frame];
    if(self){
        
        CGFloat fontSize = self.font.pointSize;
        self.originalFontSize = @(fontSize);
        self.font = [self.font fontWithSize:fontSize];
    }
    return self;
}

@end

@implementation UIButton (FontSize)

+ (void)load {
    if(!UIButtonEnable) return;
    
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
    
    Method cmp = class_getInstanceMethod([self class], @selector(initWithFrame:));
    Method myCmp = class_getInstanceMethod([self class], @selector(myInitWithFrame:));
    method_exchangeImplementations(cmp, myCmp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode {
    [self myInitWithCoder:aDecode];
    if (self) {
        
        CGFloat fontSize = self.titleLabel.font.pointSize;
        
        self.titleLabel.font = [self.titleLabel.font fontWithSize:fontSize];
    }
    return self;
}

- (id)myInitWithFrame:(CGRect)frame{
    [self myInitWithFrame:frame];
    if(self){
        
        CGFloat fontSize = self.titleLabel.font.pointSize;
        self.titleLabel.font = [self.titleLabel.font fontWithSize:fontSize];
    }
    return self;
}

@end

@implementation UITextField (FontSize)

+ (void)load {
    if(!UITextFieldEnable) return;
    
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
    
    Method cmp = class_getInstanceMethod([self class], @selector(initWithFrame:));
    Method myCmp = class_getInstanceMethod([self class], @selector(myInitWithFrame:));
    method_exchangeImplementations(cmp, myCmp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode {
    [self myInitWithCoder:aDecode];
    if (self) {
        
        CGFloat fontSize = self.font.pointSize;
        //self.originalFontSize = @(fontSize);
        self.font = [self.font fontWithSize:fontSize];
    }
    return self;
}

- (id)myInitWithFrame:(CGRect)frame{
    [self myInitWithFrame:frame];
    if(self){
        
        CGFloat fontSize = self.font.pointSize;
        //self.originalFontSize = @(fontSize);
        self.font = [self.font fontWithSize:fontSize];
    }
    return self;
}

@end

@implementation UITextView (FontSize)

+ (void)load {
    if(!UITextViewEnable) return;
    
    Method ibImp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myIbImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(ibImp, myIbImp);
    
    //    Method cmp = class_getInstanceMethod([self class], @selector(initWithFrame:));
    //    Method myCmp = class_getInstanceMethod([self class], @selector(myInitWithFrame:));
    //    method_exchangeImplementations(cmp, myCmp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode {
    [self myInitWithCoder:aDecode];
    if (self) {
        
        CGFloat fontSize = self.font.pointSize;
        //self.originalFontSize = @(fontSize);
        self.font = [self.font fontWithSize:fontSize];
    }
    return self;
}

//- (id)myInitWithFrame:(CGRect)frame{
//    [self myInitWithFrame:frame];
//    if(self){
//        //textView 此时的 self.font 还是 nil 所以无法修改
//        CGFloat fontSize = self.font.pointSize;
//        self.font = [self.font fontWithSize:fontSize*ScrenScale];
//    }
//    return self;
//}


@end