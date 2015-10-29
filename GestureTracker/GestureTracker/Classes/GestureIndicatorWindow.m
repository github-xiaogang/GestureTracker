//
//  GestureIndicatorProvider.m
//  GestureTracker
//
//  Created by 张小刚 on 15/10/28.
//  Copyright © 2015年 DuoHuo Network Technology. All rights reserved.
//

#import "GestureIndicatorWindow.h"

@interface IndicatorTouchMapper : NSObject

@property (nonatomic, retain) UIView * indicator;
@property (nonatomic, retain) UITouch * touch;

@end

@implementation IndicatorTouchMapper

+ (IndicatorTouchMapper *)mapperWithIndicator: (UIView *)indicator touch: (UITouch *)touch
{
    IndicatorTouchMapper * mapper = [[IndicatorTouchMapper alloc] init];
#if !__has_feature(objc_arc)
    [mapper autorelease];
#endif
    mapper.indicator = indicator;
    mapper.touch = touch;
    return mapper;
}

- (void)dealloc
{
#if !__has_feature(objc_arc)
    [_indicator release];
    [_touch release];
    [super dealloc];
#endif
}

@end

@interface GestureIndicatorWindow ()

@property (nonatomic, retain) NSMutableArray * indicatorTouchMappers;
@property (nonatomic, assign) CGSize indicatorCenterOffset;

@end

@implementation GestureIndicatorWindow

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self gestureIndicator_CommmonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self gestureIndicator_CommmonInit];
    }
    return self;
}

- (void)gestureIndicator_CommmonInit
{
    self.multipleTouchEnabled = YES;
    self.indicatorTouchMappers = [NSMutableArray array];
    self.indicatorCenterOffset = CGSizeMake(0, 0);
}

- (void)setIndicatorProvider:(id<GestureIndicatorProvider>)indicatorProvider
{
    _indicatorProvider = indicatorProvider;
    if([self.indicatorProvider respondsToSelector:@selector(indicatorCenterOffset)]){
        self.indicatorCenterOffset = [self.indicatorProvider indicatorCenterOffset];
    }
}

- (void)sendEvent:(UIEvent *)event
{
    [super sendEvent:event];
    if(event.type != UIEventTypeTouches) return;
    NSAssert(self.indicatorProvider, @"You should provide indicatorProvider for GestureIndicatorWindow !");
    NSSet * touches = event.allTouches;
    for (UITouch * touch in touches) {
        [self handleTouch:touch withEvent:event];
    }
}

- (void)handleTouch: (UITouch *)touch withEvent: (UIEvent *)event
{
    if(touch.phase == UITouchPhaseBegan){
        UIView * indicator = [self.indicatorProvider giveMeAnIndicator];
        IndicatorTouchMapper * mapper = [IndicatorTouchMapper mapperWithIndicator:indicator touch:touch];
        [self.indicatorTouchMappers addObject:mapper];
        CGPoint center = [touch locationInView:self];
        indicator.center = CGPointMake(center.x + self.indicatorCenterOffset.width, center.y + self.indicatorCenterOffset.height);
        [self addSubview:indicator];
    }else if(touch.phase == UITouchPhaseMoved){
        UIView * targetIndicator = nil;
        for (IndicatorTouchMapper * mapper in self.indicatorTouchMappers) {
            if(mapper.touch == touch){
                targetIndicator = mapper.indicator;;
                break;
            }
        }
        if(targetIndicator){
            CGPoint center = [touch locationInView:self];
            [self bringSubviewToFront:targetIndicator];
            targetIndicator.center = CGPointMake(center.x + self.indicatorCenterOffset.width, center.y + self.indicatorCenterOffset.height);
        }
    }else if(touch.phase == UITouchPhaseEnded || touch.phase == UITouchPhaseCancelled){
        IndicatorTouchMapper * targetMapper = nil;
        UIView * targetIndicator = nil;
        for (IndicatorTouchMapper * mapper in self.indicatorTouchMappers) {
            if(mapper.touch == touch){
                targetMapper = mapper;
                targetIndicator = mapper.indicator;
                break;
            }
        }
        if(targetIndicator){
            [self bringSubviewToFront:targetIndicator];
            __block typeof(self) bself = self;
            [UIView animateWithDuration:0.3 animations:^{
                targetIndicator.alpha = 0;
                targetIndicator.transform = CGAffineTransformMakeScale(1.2, 1.2);
            }completion:^(BOOL finished) {
                [targetIndicator removeFromSuperview];
                [bself.indicatorTouchMappers removeObject:targetMapper];
            }];
        }
    }
}

- (void)dealloc
{
#if !__has_feature(objc_arc)
    [_indicatorTouchMappers release];
    [super dealloc];
#endif
}

@end















