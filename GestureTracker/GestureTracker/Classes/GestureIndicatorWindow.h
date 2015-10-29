//
//  GestureIndicatorProvider.h
//  GestureTracker
//
//  Created by 张小刚 on 15/10/28.
//  Copyright © 2015年 DuoHuo Network Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GestureIndicatorProvider;

@interface GestureIndicatorWindow : UIWindow

@property (nonatomic, retain) id<GestureIndicatorProvider> indicatorProvider;

@end

@protocol GestureIndicatorProvider <NSObject>

//提供indicator view
@required
- (UIView *)giveMeAnIndicator;

//indicator中心位置偏移, indicator.center = touch.center + indicatorCenterOffset
@optional
- (CGSize)indicatorCenterOffset;

@end
