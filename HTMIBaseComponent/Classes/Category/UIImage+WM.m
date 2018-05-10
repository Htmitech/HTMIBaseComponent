//
//  UIImage+WM.m
//  QQSlideMenu
//
//  Created by wamaker on 15/6/22.
//  Copyright (c) 2015年 wamaker. All rights reserved.
//

#import "UIImage+WM.h"
#import "NSString+Extention.h"
#import "UIColor+Hex.h"
#import "HTMISettingManager.h"

@implementation UIImage (WM)

+ (UIImage *)imageWithRenderColor:(UIColor *)color renderSize:(CGSize)size {
    
    UIImage *image = nil;
    UIGraphicsBeginImageContext(size);
    [color setFill];
    CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0., 0., size.width, size.height));
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  返回圆形图像, 若图像不为正方形，则截取中央正方形
 *
 *  @param original 原始的ImageView，用于获取大小
 *
 *  @return 修正好的图片
 */
- (instancetype)roundImage {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat compare = self.size.width + self.size.height;
    CGFloat circleW, circleX, circleY;
    if (compare > 0) {
        circleW = self.size.height;
        circleY = 0;
        circleX = (self.size.width + circleW) / 2.0;
    } else if (compare == 0) {
        circleW = self.size.width;
        circleX = circleY = 0;
    } else {
        circleW = self.size.width;
        circleX = 0;
        circleY = (self.size.height + circleW) / 2.0;
    }
    CGRect circleRect = CGRectMake(circleX, circleY, circleW, circleW);
    CGContextAddEllipseInRect(ctx, circleRect);
    CGContextClip(ctx);
    
    [self drawInRect:circleRect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)roundedCornerImageWithCornerRadius:(CGFloat)cornerRadius {
    
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, self.size.width, self.size.height);
    imageLayer.contents = (id) self.CGImage;
    
    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = cornerRadius;
    
    UIGraphicsBeginImageContext(self.size);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return roundedImage;
}


- (UIImage *)circleImage {
    
    // 开始图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    // 获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 设置一个范围
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    // 根据一个rect创建一个椭圆
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪
    CGContextClip(ctx);
    
    // 将原照片画到图形上下文
    [self drawInRect:rect];
    
    // 从上下文上获取剪裁后的照片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 *  获取图片，根据当前的色调
 *
 *  @param imageName 图片名
 *
 *  @return 图片
 */
+ (UIImage *)imageWithViewHue:(NSString *)imageName {
    
    NSMutableString * imageNameEndString = [NSMutableString stringWithString:imageName];
    
    if ([HTMISettingManager manager].applicationHue == HTMIApplicationHueWhite) {
        [imageNameEndString appendString:@"_blue"];
    }
    else if([HTMISettingManager manager].applicationHue == HTMIApplicationHueRed){
        [imageNameEndString appendString:@"_red"];
    }else if([HTMISettingManager manager].applicationHue == HTMIApplicationHueBlue){
        [imageNameEndString appendString:@"_blue"];
    }
    
    UIImage * image = [[self class]imageNamed:imageNameEndString];
    
    return image;
}

/**
 *  生成图片
 *
 *  @param color  图片颜色
 *  @param height 图片高度
 *
 *  @return 生成的图片
 */
+ (UIImage*)GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r = CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

/**
 *  导航栏获取图片，根据当前的色调
 *
 *  @param imageName 图片名
 *
 *  @return 图片
 */
+ (UIImage *)imageNavigationWithViewHue:(NSString *)imageName{
    
    NSMutableString * imageNameEndString = [NSMutableString stringWithString:imageName];
    
    if ([HTMISettingManager manager].applicationHue == HTMIApplicationHueWhite) {
        [imageNameEndString appendString:@"_white"];
    }
    else{
        [imageNameEndString appendString:@"_blue"];
    }
    
    UIImage * image = [[self class] imageNamed:imageNameEndString];
    
    return image;
}


/**
 *  不是导航栏获取图片，根据当前的色调
 *
 *  @param imageName 图片名
 *
 *  @return 图片
 */
+ (UIImage *)imageNormalWithViewHue:(NSString *)imageName{
    
    NSMutableString * imageNameEndString = [NSMutableString stringWithString:imageName];
    
    if ([HTMISettingManager manager].applicationHue == HTMIApplicationHueWhite) {
        
        [imageNameEndString appendString:@"_white"];
    }
    else if([HTMISettingManager manager].applicationHue == HTMIApplicationHueBlue){
        
        [imageNameEndString appendString:@"_blue"];
    }else{
        
        [imageNameEndString appendString:@"_red"];
    }
    
    UIImage * image = [[self class] imageNamed:imageNameEndString];
    
    return image;
}

//获取某个特定View里的图片
+ (UIImage*)captureView:(UIView *)theView
{
    CGRect rect = theView.frame;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

//自定义长宽的图片
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

+ (UIImage *)imageFromBaseString:(NSString *)imageBaseString{
    
    if (!imageBaseString) {
        return nil;
    }
    NSData * decodedImageData   = [[NSData alloc] initWithBase64EncodedString:imageBaseString options:0];
    
    UIImage * decodedImage      = [UIImage imageWithData:decodedImageData];
    
    return decodedImage;
    
}

+ (NSString *)baseStringFromImage:(UIImage *)originImage{
    
    if (!originImage) {
        return @"";
    }
    NSData *imageData = UIImageJPEGRepresentation(originImage, 1.0f);
    
    NSString *encodedImageString = [imageData base64EncodedStringWithOptions:0];
    
    return encodedImageString;
}

+ (UIImage *)getImageFromView:(UIView *)view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (void)saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath
{
    if ([[extension lowercaseString] isEqualToString:@"png"])
    {
        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
    }
    else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"])
    {
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
    }
    else
    {
        NSLog(@"文件后缀不认识");
    }
}

//开始动画
+ (UIImageView *)rotate360DegreeWithImageView:(UIImageView *)imageView{
    
    CABasicAnimation *animation = [CABasicAnimation
                                   
                                   animationWithKeyPath: @"transform" ];
    
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    //围绕Z轴旋转，垂直与屏幕 顺时针旋转(1.0, 0.0, 0.0, M_PI) 逆时针旋转(M_PI, 0.0, 0.0, 1.0)
    
    animation.toValue = [NSValue valueWithCATransform3D:
                         
                         CATransform3DMakeRotation(1.0, 0.0, 0.0, 1.0) ];
    
    animation.duration = 0.5;
    
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    
    animation.cumulative = YES;
    
    animation.repeatCount = 1000;
    
    //在图片边缘添加一个像素的透明区域，去图片锯齿
    
    CGRect imageRrect = CGRectMake(0, 0,imageView.frame.size.width, imageView.frame.size.height);
    
    UIGraphicsBeginImageContext(imageRrect.size);
    
    [imageView.image drawInRect:CGRectMake(1,1,imageView.frame.size.width-2,imageView.frame.size.height-2)];
    
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    [imageView.layer addAnimation:animation forKey:nil];
    
    return imageView;
    
}

/**
 通过图片Data数据第一个字节 来获取图片扩展名
 
 @param data 图片数据
 @return 扩展名
 */
+ (NSString *)htmi_contentTypeForImageData:(NSData *)data
{
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c)
    {
        case 0xFF:
            return @"jpeg";
            
        case 0x89:
            return @"png";
            
        case 0x47:
            return @"gif";
            
        case 0x49:
        case 0x4D:
            return @"tiff";
            
        case 0x52:
            if ([data length] < 12) {
                return nil;
            }
            
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"]
                && [testString hasSuffix:@"WEBP"])
            {
                return @"webp";
            }
            
            return nil;
    }
    
    return nil;
}

/**
 判断图片是否有透明度
 
 @return 是否有透明度
 */
- (BOOL)htmi_hasAlphaChannel
{
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(self.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}

/**
 图片拉伸
 
 @param imageName 图片名称
 @return 拉伸后的图片
 */
+ (UIImage *)htmi_resizableImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageH * 0.5, imageW * 0.5, imageH * 0.5, imageW * 0.5) resizingMode:UIImageResizingModeStretch];
}

/**
 获得灰度图
 
 @param sourceImage 原图片
 @return 灰度图
 */
+ (UIImage*)htmi_covertToGrayImageFromImage:(UIImage*)sourceImage
{
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,width,height,8,0,colorSpace,kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        return nil;
    }
    
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), sourceImage.CGImage);
    CGImageRef contextRef = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:contextRef];
    CGContextRelease(context);
    CGImageRelease(contextRef);
    
    return grayImage;
}

/**
 根据bundle中的文件名读取图片

 @param name 文件名称
 @return <#return value description#>
 */
+ (UIImage *)htmi_imageWithFileName:(NSString *)name {
    NSString *extension = @"png";
    
    NSArray *components = [name componentsSeparatedByString:@"."];
    if ([components count] >= 2) {
        NSUInteger lastIndex = components.count - 1;
        extension = [components objectAtIndex:lastIndex];
        
        name = [name substringToIndex:(name.length-(extension.length+1))];
    }
    
    // 如果为Retina屏幕且存在对应图片，则返回Retina图片，否则查找普通图片
    if ([UIScreen mainScreen].scale == 2.0) {
        name = [name stringByAppendingString:@"@2x"];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:extension];
        if (path != nil) {
            return [UIImage imageWithContentsOfFile:path];
        }
    }
    
    if ([UIScreen mainScreen].scale == 3.0) {
        name = [name stringByAppendingString:@"@3x"];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:extension];
        if (path != nil) {
            return [UIImage imageWithContentsOfFile:path];
        }
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:extension];
    if (path) {
        return [UIImage imageWithContentsOfFile:path];
    }
    
    return nil;
}

/** 设置圆形图片 */
- (UIImage *)htmi_cutCircleImage {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    // 获取上下文
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    // 设置圆形
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctr, rect);
    // 裁剪
    CGContextClip(ctr);
    // 将图片画上去
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  图片压缩到指定大小
 *  @param targetSize  目标图片的大小
 *  @param sourceImage 源图片
 *  @return 目标图片
 */
+ (UIImage*)htmi_imageByScalingAndCroppingForSize:(CGSize)targetSize withSourceImage:(UIImage *)sourceImage
{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 获取一个视频的第一帧图片

 @param filepath 视频地址
 @return <#return value description#>
 */
//- (UIImage *)htmi_getImageFirstFromVideo:(NSString *)filepath{
//    NSURL *url = [NSURL URLWithString:filepath];
//    AVURLAsset *asset1 = [[AVURLAsset alloc] initWithURL:url options:nil];
//    AVAssetImageGenerator *generate1 = [[AVAssetImageGenerator alloc] initWithAsset:asset1];
//    generate1.appliesPreferredTrackTransform = YES;
//    NSError *err = NULL;
//    CMTime time = CMTimeMake(1, 2);
//    CGImageRef oneRef = [generate1 copyCGImageAtTime:time actualTime:NULL error:&err];
//    UIImage *one = [[UIImage alloc] initWithCGImage:oneRef];
//    
//    return one;
//}

//获取视频的时长
//+ (NSInteger)getVideoTimeByUrlString:(NSString *)urlString {
//    NSURL *videoUrl = [NSURL URLWithString:urlString];
//    AVURLAsset *avUrl = [AVURLAsset assetWithURL:videoUrl];
//    CMTime time = [avUrl duration];
//    int seconds = ceil(time.value/time.timescale);
//    return seconds;
//}

@end
