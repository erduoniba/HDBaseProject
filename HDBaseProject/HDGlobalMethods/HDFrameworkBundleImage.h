//
//  HDFrameworkBundleImage.h
//  Pods
//
//  Created by 邓立兵 on 2017/9/7.
//
//

#import <Foundation/Foundation.h>

@interface HDFrameworkBundleImage : NSObject

+ (NSBundle *)hdBundleWithFrameworkClass:(Class )class bundleName:(NSString *)bundleName;

+ (UIImage *)hdBundle:(NSBundle *)bundle imageName:(NSString *)imageName;

+ (UIImage *)hdBaseProjectBundleImage:(NSString *)imageName;

@end
