//
//  JSAppDelegate.m
//  TestJson
//
//  Created by Navin Goel on 9/27/12.
//  Copyright (c) 2012 Navin Goel. All rights reserved.
//

#import "JSAppDelegate.h"
#import "JSNetworkRequestHandler.h"
#import "JSTableViewController.h"
#import "JSKeyValueConstants.h"

@implementation JSAppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    // singleton
    JSNetworkRequestHandler* l_networkRequestHandler = [JSNetworkRequestHandler sharedNetworkRequestHandler];
    [l_networkRequestHandler loadDataForNetworkRequest:JSNRT_LoadObjectsList fromURLString:sHerokuAppFeedURL];

    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    JSTableViewController* l_tableVC = [[JSTableViewController alloc] init];
	UINavigationController* l_navigationController = [[[UINavigationController alloc] initWithRootViewController:l_tableVC] autorelease];
    [l_tableVC release];
    
	//l_navigationController.navigationBar.tintColor = OSN_PHONE_NAVIGATION_BAR_COLOR;
    
    [self.window setRootViewController:l_navigationController];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
