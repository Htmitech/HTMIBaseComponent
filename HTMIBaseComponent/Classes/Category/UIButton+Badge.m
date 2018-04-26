//
//  UIButton+Badge.m
//  MXClient
//
//  Created by 赵志国 on 2017/8/23.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "UIButton+Badge.h"

#import "Masonry.h"

@implementation UIButton (Badge)

- (void)isShowBadge:(BOOL)isShow {
    if (isShow) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor colorWithRed:220 green:86 blue:86 alpha:1];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 5;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 1.0;
        [self addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(6);
            make.right.equalTo(self).offset(10);
            make.width.height.mas_equalTo(10);
        }];
        
    }
}

@end
