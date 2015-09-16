//
//  HDAppDelegate.m
//  HDBaseProject
//
//  Created by Harry on 09/15/2015.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "HDAppDelegate.h"

#import "HTTPRequest.h"

//易源接口:为了验证用户身份，以及确保参数不被中间人篡改，需要传递调用者的数字签名。
#define SHOWAPI_SIGN    @"983e97df16ff48cb984c8250024aa142"
#define SHOWAPI_APPID   @"5095"

@implementation HDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    NSString *time = [self getDateString:[NSDate date] withFormat:@"yyyyMMddHHmmss"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:SHOWAPI_SIGN     forKey:@"showapi_sign"];
    [dic setObject:SHOWAPI_APPID    forKey:@"showapi_appid"];
    [dic setObject:time             forKey:@"showapi_timestamp"];   //时间戳最好不要放在默认参数里面
    [dic setObject:@(20)            forKey:@"num"];

    HTTPRequest *rq = [HTTPRequest shareInstanceWithBaseDemail:@"https://route.showapi.com"];
    [rq setDefaultParamters:dic];
    
    return YES;
}

- (NSString *)getDateString:(NSDate *)date withFormat:(NSString*)format
{
    NSTimeZone *tzGMT = [NSTimeZone timeZoneWithName:@"GMT+8:00"];
    [NSTimeZone setDefaultTimeZone:tzGMT];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:tzGMT];
    [dateFormatter setDateFormat:format];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
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
