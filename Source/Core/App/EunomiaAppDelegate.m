//
//  EunomiaAppDelegate.m
//  Eunomia
//
//  Created by Ian on 4/22/15.
//  Copyright (c) 2015 Eunomia. All rights reserved.
//

#import "EunomiaAppDelegate.h"

@implementation EunomiaAppDelegate

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return NO;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return YES;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

- (void)applicationSignificantTimeChange:(UIApplication *)application
{
}

- (void)application:(UIApplication *)application willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration
{
}

- (void)application:(UIApplication *)application didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation
{
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
}

// Called when your app has been activated by the user selecting an action from a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling the action.
//- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler NS_AVAILABLE_IOS(8_0);

// Called when your app has been activated by the user selecting an action from a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling the action.
//- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler NS_AVAILABLE_IOS(8_0);

/*! This delegate method offers an opportunity for applications with the "remote-notification" background mode to fetch appropriate new data in response to an incoming remote notification. You should call the fetchCompletionHandler as soon as you're finished performing that operation, so the system can accurately estimate its power and data cost.
 
 This method will be invoked even if the application was launched or resumed because of the remote notification. The respective delegate methods will be invoked first. Note that this behavior is in contrast to application:didReceiveRemoteNotification:, which is not called in those cases, and which will not be invoked if this method is implemented. !*/
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler NS_AVAILABLE_IOS(7_0);

/// Applications with the "fetch" background mode may be given opportunities to fetch updated content in the background or when it is convenient for the system. This method will be called in these situations. You should call the fetchCompletionHandler as soon as you're finished performing that operation, so the system can accurately estimate its power and data cost.
//- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler NS_AVAILABLE_IOS(7_0);

// Applications using an NSURLSession with a background configuration may be launched or resumed in the background in order to handle the
// completion of tasks in that session, or to handle authentication. This method will be called with the identifier of the session needing
// attention. Once a session has been created from a configuration object with that identifier, the session's delegate will begin receiving
// callbacks. If such a session has already been created (if the app is being resumed, for instance), then the delegate will start receiving
// callbacks without any action by the application. You should call the completionHandler as soon as you're finished handling the callbacks.
//- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler NS_AVAILABLE_IOS(7_0);

//- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void(^)(NSDictionary *replyInfo))reply NS_AVAILABLE_IOS(8_2);

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

/*
 - (void)applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application NS_AVAILABLE_IOS(4_0);
 - (void)applicationProtectedDataDidBecomeAvailable:(UIApplication *)application    NS_AVAILABLE_IOS(4_0);
 */

@end
