//
//  AppDelegate.m
//  GestureTracker
//
//  Created by 张小刚 on 15/10/19.
//  Copyright © 2015年 DuoHuo Network Technology. All rights reserved.
//

#import "AppDelegate.h"
#import "DemoViewController.h"
#import "GestureIndicatorWindow.h"
#import "GestureIndicatorProviderImpl.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /**`
     使用：
     方式一.手动创建GestureIndicatorWindow
     方式二.将xib中window类修改为GestureIndicatorWindow
     */
    
    GestureIndicatorWindow * window = [[GestureIndicatorWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //create a pop style indicator
    GestureIndicatorPopProvider * popIndicatorProvider = [[GestureIndicatorPopProvider alloc] init];
    window.indicatorProvider = popIndicatorProvider;

    /*
    //create a picture indicator
    GestureIndicatorPictureProvider * pictureIndicatorProvider = [[GestureIndicatorPictureProvider alloc] init];
    window.indicatorProvider = pictureIndicatorProvider;
     */
    
    DemoViewController * demoVC = [[DemoViewController alloc] init];
    window.rootViewController = demoVC;
    [window makeKeyAndVisible];
    self.window = window;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
