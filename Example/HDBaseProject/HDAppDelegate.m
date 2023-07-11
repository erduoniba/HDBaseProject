//
//  HDAppDelegate.m
//  HDBaseProject
//
//  Created by Harry on 09/15/2015.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "HDAppDelegate.h"

#import <HDBaseProject/HDBaseProject.h>

#import "HDRequestManager.h"
#import "HDHomeViewModel.h"

#import "HDLogDemo.h"

@implementation HDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [HDBaseViewController setBackgroundColor:[UIColor whiteColor]];
    [HDBaseViewController setBackImageName:@"back"];

    NSString *originUrl = @"http://www.example.com?name=京东";
    NSString *urlencode = [originUrl hd_urlEncode];
    NSString *urldencode = [urlencode hd_urlDecode];
    NSString *utf8encode = [originUrl hd_utf8Encode];
    NSString *utf8decode = [originUrl hd_utf8Decode];

    NSString *base64String = [originUrl hd_base64Encode];
    NSString *originString = [base64String hd_base64Decode];

    NSLog(@"\n originUrl:%@\n urlencode:%@\n urldencode:%@\n utf8encode:%@\n utf8decode:%@\n base64String:%@\n originString:%@", originUrl, urlencode, urldencode, utf8encode, utf8decode, base64String, originString);
    NSLog(@"[originUrl isEqualToString:urldencode] : %d", [originUrl isEqualToString:urldencode]);

    if (rand() % 2 == 0) {
        // 集约型api请求方式
        [[HDRequestManager sharedInstance] laughterListPageIndex:1 pageSize:3 cache:^(id  _Nullable responseObject) {
            DLog(@"cache: %@", responseObject);
        } success:^(NSURLSessionTask * _Nullable httpbase, id  _Nullable responseObject) {
            DLog(@"success: %@", responseObject);
        } failure:^(NSURLSessionTask * _Nullable httpbase, id  _Nullable responseObject) {
            DLog(@"failure: %@", responseObject);
        }];
    }
    else {
        // 分散型api请求方式
        HDHomeViewModel *homeVM = [HDHomeViewModel new];
        homeVM.pageSize = 3;
        homeVM.pageIndex = 1;
        [homeVM requestCache:^(id  _Nullable responseObject) {
            DLog(@"cache2: %@", responseObject);
        } success:^(NSURLSessionTask * _Nullable httpbase, id  _Nullable responseObject) {
            DLog(@"success2: %@", responseObject);
        } failure:^(NSURLSessionTask * _Nullable httpbase, id  _Nullable responseObject) {
            DLog(@"failure2: %@", responseObject);
        }];
    }

    NSString *encrypt = [HDGlobalMethods hd_aes128Encrypt:@"hello" key:@"hd"];
    NSString *decrypt = [HDGlobalMethods hd_aes128Decrypt:encrypt key:@"hd"];
    NSLog(@"decrypt %@", decrypt);
    
    [HDLogDemo hdlogDemo];
    
    #if DEBUG
//    Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()
//    //for tvOS:
//    Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/tvOSInjection.bundle")?.load()
//    //Or for macOS:
//    Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/macOSInjection.bundle")?.load()
    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
    #endif

    return YES;
}

- (void)injected {
    NSLog(@"I've been injected: %@", self);
    NSLog(@"I've been injected2: %@", self);
    NSLog(@"I've been injected2: %@", self);
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
