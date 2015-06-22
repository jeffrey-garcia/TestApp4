//
//  AppDelegate.m
//  TestApp4
//
//  Created by jeffrey on 29/4/15.
//  Copyright (c) 2015 jeffrey. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "HsbcUIViewController.h"
#import "HsbcUIWebviewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"%@ - didFinishLaunchingWithOptions", NSStringFromClass([self class]));
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self setWindow:window];
    
    HsbcUIWebviewController *viewController = [[HsbcUIWebviewController alloc] initWithNibName:@"T_C" bundle:[NSBundle mainBundle]];
    //[viewController setValue:[NSURL URLWithString:@"https://services.mobile.hsbc.com/pages/mobile/version1.1/eula.html?page=agree"] forKey:@"url"];
    //[viewController setValue:[NSURL URLWithString:@"https://www.ebanking.hsbc.com.hk/1/content/hongkong/services/cards/sim_payments/html/terms.html"] forKey:@"url"];
    
    // get localized path for file from app bundle
    NSString *path;
    NSBundle *mainBundle = [NSBundle mainBundle];
    path = [mainBundle pathForResource:@"tc" ofType:@"html"];
    if (path != nil) {
        // make a file: URL out of the path
        [viewController setValue:[NSURL fileURLWithPath:path] forKey:@"url"];
    }
    
    [window addSubview:viewController.view];
    [window setRootViewController:viewController];
    
    [window setBackgroundColor:[UIColor whiteColor]];
    [window makeKeyAndVisible];
    
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
    NSLog(@"%@ - applicationDidBecomeActive", NSStringFromClass([self class]));
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
