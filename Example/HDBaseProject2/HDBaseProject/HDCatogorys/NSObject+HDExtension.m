//
//  NSObject+HDExtension.m
//  HDBaseProject
//
//  Created by 邓立兵 on 2017/11/27.
//

#import "NSObject+HDExtension.h"

#import <objc/runtime.h>
#import <sys/utsname.h>

@implementation NSObject (HDExtension)

#pragma mark -
#pragma mark - NSObject+Copy

/**
 *  浅复制目标的所有属性 https://github.com/shaojiankui/JKCategories/blob/master/JKCategories/Foundation/NSObject/NSObject%2BJKEasyCopy.h
 *
 *  @param instance 目标对象
 *
 *  @return BOOL—YES:复制成功,NO:复制失败
 */
- (BOOL)hd_easyShallowCopy:(NSObject *)instance
{
    Class currentClass = [self class];
    Class instanceClass = [instance class];

    if (self == instance) {
        //相同实例
        return NO;
    }

    if (![instance isMemberOfClass:currentClass] ) {
        //不是当前类的实例
        return NO;
    }

    while (instanceClass != [NSObject class]) {
        unsigned int propertyListCount = 0;
        objc_property_t *propertyList = class_copyPropertyList(currentClass, &propertyListCount);
        for (int i = 0; i < propertyListCount; i++) {
            objc_property_t property = propertyList[i];
            const char *property_name = property_getName(property);
            NSString *propertyName = [NSString stringWithCString:property_name encoding:NSUTF8StringEncoding];

            //check if property is dynamic and readwrite
            char *dynamic = property_copyAttributeValue(property, "D");
            char *readonly = property_copyAttributeValue(property, "R");
            if (propertyName && !readonly) {
                id propertyValue = [instance valueForKey:propertyName];
                [self setValue:propertyValue forKey:propertyName];
            }
            free(dynamic);
            free(readonly);
        }
        free(propertyList);
        instanceClass = class_getSuperclass(instanceClass);
    }

    return YES;
}

/**
 *  深复制目标的所有属性 https://github.com/shaojiankui/JKCategories/blob/master/JKCategories/Foundation/NSObject/NSObject%2BJKEasyCopy.h
 *
 *  @param instance 目标对象
 *
 *  @return BOOL—YES:复制成功,NO:复制失败
 */
- (BOOL)hd_easyDeepCopy:(NSObject *)instance
{
    Class currentClass = [self class];
    Class instanceClass = [instance class];

    if (self == instance) {
        //相同实例
        return NO;
    }

    if (![instance isMemberOfClass:currentClass] ) {
        //不是当前类的实例
        return NO;
    }

    while (instanceClass != [NSObject class]) {
        unsigned int propertyListCount = 0;
        objc_property_t *propertyList = class_copyPropertyList(currentClass, &propertyListCount);
        for (int i = 0; i < propertyListCount; i++) {
            objc_property_t property = propertyList[i];
            const char *property_name = property_getName(property);
            NSString *propertyName = [NSString stringWithCString:property_name encoding:NSUTF8StringEncoding];

            //check if property is dynamic and readwrite
            char *dynamic = property_copyAttributeValue(property, "D");
            char *readonly = property_copyAttributeValue(property, "R");
            if (propertyName && !readonly) {
                id propertyValue = [instance valueForKey:propertyName];
                Class propertyValueClass = [propertyValue class];
                BOOL flag = [NSObject hd_isNSObjectClass:propertyValueClass];
                if (flag) {
                    if ([propertyValue conformsToProtocol:@protocol(NSCopying)]) {
                        NSObject *copyValue = [propertyValue copy];
                        [self setValue:copyValue forKey:propertyName];
                    }else{
                        NSObject *copyValue = [[[propertyValue class]alloc]init];
                        [copyValue hd_easyDeepCopy:propertyValue];
                        [self setValue:copyValue forKey:propertyName];
                    }
                }else{
                    [self setValue:propertyValue forKey:propertyName];
                }
            }
            free(dynamic);
            free(readonly);
        }
        free(propertyList);
        instanceClass = class_getSuperclass(instanceClass);
    }

    return YES;
}

+ (BOOL)hd_isNSObjectClass:(Class)clazz
{
    BOOL flag = class_conformsToProtocol(clazz, @protocol(NSObject));
    if (flag) {
        return flag;
    }else{
        Class superClass = class_getSuperclass(clazz);
        if (!superClass) {
            return NO;
        }else{
            return  [NSObject hd_isNSObjectClass:superClass];
        }
    }
}


#pragma mark -
#pragma mark - NSObject+AppInfo

-(NSString *)hd_version {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}

-(NSString *)hd_build {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    return app_build;
}

-(NSString *)hd_identifier {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString * bundleIdentifier = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    return bundleIdentifier;
}

-(NSString *)hd_currentLanguage {
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages firstObject];
    return [NSString stringWithString:currentLanguage];
}

-(UIImage *)hd_appicon {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *icon = [[infoDictionary valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    UIImage* image = [UIImage imageNamed:icon];
    return image;
}


#pragma mark -
#pragma mark - NSObject+Blocks

static inline dispatch_time_t hd_dTimeDelay(NSTimeInterval time)
{
    int64_t delta = (int64_t)(NSEC_PER_SEC * time);
    return dispatch_time(DISPATCH_TIME_NOW, delta);
}

+ (HDBlockCancel)hd_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
    if (!block) {
        return nil;
    }

    __block BOOL cancelled = NO;
    HDBlockCancel cancelBlock = ^(BOOL cancel) {
        if (cancel) {
            cancelled = YES;
            return;
        }
        if (!cancelled)block();
    };

    cancelBlock = [cancelBlock copy];
    dispatch_after(hd_dTimeDelay(delay), dispatch_get_main_queue(), ^{
        cancelBlock(NO);
    });

    return cancelBlock;
}

- (HDBlockCancel)hd_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
    if (!block) {
        return nil;
    }

    __block BOOL cancelled = NO;
    HDBlockCancel cancelBlock = ^(BOOL cancel) {
        if (cancel) {
            cancelled = YES;
            return;
        }
        if (!cancelled) block();
    };

    cancelBlock = [cancelBlock copy];
    dispatch_after(hd_dTimeDelay(delay), dispatch_get_main_queue(), ^{
        cancelBlock(NO);
    });

    return cancelBlock;
}

- (void)hd_performAsynchronous:(void(^)(void))block
{
    if (!block) {
        return ;
    }

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, block);
}

- (void)hd_performOnMainThread:(void(^)(void))block
{
    if (!block) {
        return ;
    }

    dispatch_async(dispatch_get_main_queue(), block);
}

- (void)hd_performAsynchronous:(void (^)(void))asycBlock afterPerformMainThread:(void(^)(void))mainThreadBlock
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        if (asycBlock) {
            asycBlock();
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (mainThreadBlock) {
                mainThreadBlock();
            }
        });
    });
}

- (void)hd_logTimeTakenToRunBlock:(void (^)(void)) block withPrefix:(NSString *)prefixString
{
    double a = CFAbsoluteTimeGetCurrent();
    block();
    double b = CFAbsoluteTimeGetCurrent();
    unsigned int m = ((b-a) * 1000.0f); // convert from seconds to milliseconds
    NSLog(@"%@: %d ms", prefixString ? prefixString : @"hd_log", m);
}


#pragma mark -
#pragma mark - NSObject+AssociatedObject

- (void)hd_associateValue:(id)value withKey:(void *)key
{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN);
}

- (void)hd_weaklyAssociateValue:(id)value withKey:(void *)key
{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

- (id)hd_associatedValueForKey:(void *)key
{
    return objc_getAssociatedObject(self, key);
}


#pragma mark -
#pragma mark - NSObject+Runtime
+ (BOOL)hd_swizzleMethod:(SEL)origSel withMethod:(SEL)altSel
{
    Method origMethod = class_getInstanceMethod(self, origSel);
    Method altMethod = class_getInstanceMethod(self, altSel);
    if (!origMethod || !altMethod) {
        return NO;
    }
    class_addMethod(self,
                    origSel,
                    class_getMethodImplementation(self, origSel),
                    method_getTypeEncoding(origMethod));
    class_addMethod(self,
                    altSel,
                    class_getMethodImplementation(self, altSel),
                    method_getTypeEncoding(altMethod));
    method_exchangeImplementations(class_getInstanceMethod(self, origSel),
                                   class_getInstanceMethod(self, altSel));
    return YES;
}

+ (BOOL)hd_swizzleClassMethod:(SEL)origSel withMethod:(SEL)altSel
{
    return [object_getClass((id)self) hd_swizzleMethod:origSel withMethod:altSel];
}

+ (BOOL)hd_appendMethod:(SEL)newMethod fromClass:(Class)klass
{
    if (!self.class || !klass || !newMethod)
        return NO;

    Method method = class_getInstanceMethod(klass, newMethod);

    if (!method)
        return NO;

    return class_addMethod(self.class, method_getName(method), method_getImplementation(method), method_getTypeEncoding(method));
}

+(void)hd_swizzleMethod:(SEL)srcSel tarClassName:(NSString *)tarClassName tarSel:(SEL)tarSel
{
    if (!tarClassName) {
        return;
    }
    Class srcClass = [self class];
    Class tarClass = NSClassFromString(tarClassName);
    [self hd_swizzleMethod:srcClass srcSel:srcSel tarClass:tarClass tarSel:tarSel];
}

+ (void)hd_swizzleMethod:(Class)srcClass srcSel:(SEL)srcSel tarClass:(Class)tarClass tarSel:(SEL)tarSel
{
    if (!srcClass) {
        return;
    }
    if (!srcSel) {
        return;
    }
    if (!tarClass) {
        return;
    }
    if (!tarSel) {
        return;
    }

    Method srcMethod = class_getInstanceMethod(srcClass, srcSel);
    Method tarMethod = class_getInstanceMethod(tarClass, tarSel);

    BOOL didAddMethod = class_addMethod(srcClass, srcSel, method_getImplementation(tarMethod), method_getTypeEncoding(tarMethod));
    if (didAddMethod) {
        class_replaceMethod(srcClass, tarSel, method_getImplementation(srcMethod), method_getTypeEncoding(srcMethod));
    }
    else {
        method_exchangeImplementations(srcMethod, tarMethod);
    }
}

@end
