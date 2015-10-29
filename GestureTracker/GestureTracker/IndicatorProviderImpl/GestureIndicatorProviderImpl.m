//
//  GestureIndicatorProviderImpl.m
//  GestureTracker
//
//  Created by 张小刚 on 15/10/28.
//  Copyright © 2015年 DuoHuo Network Technology. All rights reserved.
//

#import "GestureIndicatorProviderImpl.h"

static CGFloat const INDICATOR_SIZE = 45.0f;

@implementation GestureIndicatorPopProvider

- (UIView *)giveMeAnIndicator
{
    UIView * indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, INDICATOR_SIZE * 2, INDICATOR_SIZE * 2)];
#if !__has_feature(objc_arc)
    [indicatorView autorelease];
#endif
    indicatorView.layer.cornerRadius = INDICATOR_SIZE;
    indicatorView.clipsToBounds = YES;
    indicatorView.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.6];
    return indicatorView;
}

@end

@implementation GestureIndicatorPictureProvider

- (UIView *)giveMeAnIndicator
{
    UIImage * image = [UIImage imageNamed:@"indicator.jpg"];
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize displaySize = CGSizeMake(image.size.width / scale , image.size.height / scale);
    UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
    imageView.bounds = CGRectMake(0, 0, displaySize.width, displaySize.height);
#if !__has_feature(objc_arc)
    [imageView autorelease];
#endif
    return imageView;
}

- (CGSize)indicatorCenterOffset
{
    return CGSizeMake(-20, -20);
}

@end



















