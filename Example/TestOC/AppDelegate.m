//
//  AppDelegate.m
//  TestOC
//
//  Created by Ink on 2021/2/25.
//

#import "AppDelegate.h"
#import <Reader17kSDK/Reader17kSDK.h>
#import <BUAdSDK/BUAdSDK.h>

#define kBUAdAppKey @"5127936"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSDictionary *sdkOptions = @{@"enableService":@"1",@"servcie":@"客服urlStr"};
    [ReaderColSDK.shared configWithAppid:@"1207" secret:@"asdf!@" options:sdkOptions];
    
    NSLog(@"%@",ReaderColSDK.shared.version);
    [BUAdSDKManager setAppID:kBUAdAppKey];
    [BUAdSDKManager setIsPaidApp:false];
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
