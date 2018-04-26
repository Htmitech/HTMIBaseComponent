//
//  UIImage+WM.h
//  QQSlideMenu
//
//  Created by wamaker on 15/6/22.
//  Copyright (c) 2015年 wamaker. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (WM)

- (instancetype)roundImage;

/**
 *  根据颜色生成图片
 *
 *  @param color 色值
 *  @param size  大小
 *
 *  @return 图片
 */
+ (UIImage *)imageWithRenderColor:(UIColor *)color renderSize:(CGSize)size;

/**
 *  获取图片，根据当前的色调
 *
 *  @param imageName 图片名
 *
 *  @return 图片
 */
+ (UIImage *)imageWithViewHue:(NSString *)imageName;

/**
 *  导航栏获取图片，根据当前的色调
 *
 *  @param imageName 图片名
 *
 *  @return 图片
 */
+ (UIImage *)imageNavigationWithViewHue:(NSString *)imageName;


/**
 *  不是导航栏获取图片，根据当前的色调
 *
 *  @param imageName 图片名
 *
 *  @return 图片
 */
+ (UIImage *)imageNormalWithViewHue:(NSString *)imageName;


- (UIImage *)circleImage;

- (UIImage *)roundedCornerImageWithCornerRadius:(CGFloat)cornerRadius;

//获取某个特定View里的图片
+ (UIImage*)captureView:(UIView *)theView;

//自定义长宽的图片
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;

/**
 *  base64字符串转Image
 *
 *  @param imageBaseString base64字符串
 *
 *  @return Image
 */
+ (UIImage *)imageFromBaseString:(NSString *)imageBaseString;

/**
 *  Image转base64字符串
 *
 *  @param originImage Image
 *
 *  @return base64字符串
 */
+ (NSString *)baseStringFromImage:(UIImage *)originImage;

//将view转为image
+ (UIImage *)getImageFromView:(UIView *)view;

+ (void)saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath;

/**
 *  生成图片
 *
 *  @param color  图片颜色
 *  @param height 图片高度
 *
 *  @return 生成的图片
 */
+ (UIImage*)GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height;

//开始动画
+ (UIImageView *)rotate360DegreeWithImageView:(UIImageView *)imageView;

/**
 通过图片Data数据第一个字节 来获取图片扩展名
 
 @param data 图片数据
 @return 扩展名
 */
+ (NSString *)htmi_contentTypeForImageData:(NSData *)data;

/** 设置圆形图片(放到分类中使用) */
- (UIImage *)htmi_cutCircleImage;

/**
 *  图片压缩到指定大小
 *  @param targetSize  目标图片的大小
 *  @param sourceImage 源图片
 *  @return 目标图片
 */
+ (UIImage*)htmi_imageByScalingAndCroppingForSize:(CGSize)targetSize withSourceImage:(UIImage *)sourceImage;

@end
