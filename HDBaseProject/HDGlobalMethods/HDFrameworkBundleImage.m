//
//  HDFrameworkBundleImage.m
//  Pods
//
//  Created by 邓立兵 on 2017/9/7.
//
//

#import "HDFrameworkBundleImage.h"

@implementation HDFrameworkBundleImage

+ (NSBundle *)hdBundleWithFrameworkClass:(Class )class bundleName:(NSString *)bundleName {
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:class] pathForResource:bundleName ofType:@"bundle"]];
    return bundle;
}

+ (UIImage *)hdBundle:(NSBundle *)bundle imageName:(NSString *)imageName {
    CGFloat screenScale = [UIScreen mainScreen].scale;
    NSString *path = [bundle pathForResource:imageName ofType:@"png"];
    if (screenScale > 2) {
        //@3x
        path = [bundle pathForResource:[NSString stringWithFormat:@"%@@3x", imageName] ofType:@"png"];
    }
    else if (screenScale > 1) {
        //@2x
        path = [bundle pathForResource:[NSString stringWithFormat:@"%@@2x", imageName] ofType:@"png"];
    }
    UIImage *image = [[UIImage imageWithContentsOfFile:path] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

+ (UIImage *)hdBaseProjectBundleImage:(NSString *)imageName {
    static NSBundle *bundle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bundle = [self hdBundleWithFrameworkClass:self bundleName:@"HDBaseProject"];
    });
    return [self hdBundle:bundle imageName:imageName];
}

@end
