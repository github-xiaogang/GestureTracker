# GestureTracker

## what is it
实时显示手势操作，可以用于app演示等。

## how it work
`- (void)sendEvent:(UIEvent *)event; // called by UIApplication to dispatch events to views inside the window`

`UIWindow` 的`sendEvent:`方法是整个app分发事件的入口

`GestureIndicatorWindow`重写此方法：
1. 调用super正常分发事件
2. 处理手势

``` objective-c
- (void)sendEvent:(UIEvent *)event
{
//调用super正常配发事件
    [super sendEvent:event];
    
    if(event.type != UIEventTypeTouches) return;
    NSSet * touches = event.allTouches;
    for (UITouch * touch in touches) {
        [self handleTouch:touch withEvent:event];
    }
}
```

## how to use
1. 替换`UIWindow`为`GestureIndicatorWindow`
2. 自定义手势跟踪样式

``` objective-c
    GestureIndicatorWindow * window = [[GestureIndicatorWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //create a pop style indicator
    GestureIndicatorPopProvider * popIndicatorProvider = [[GestureIndicatorPopProvider alloc] init];
    window.indicatorProvider = popIndicatorProvider;
```



