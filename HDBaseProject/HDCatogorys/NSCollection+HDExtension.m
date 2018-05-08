//
//  NSArray+HDExtension.m
//  HDCommonTools
//
//  Created by 邓立兵 on 2017/12/4.
//

#import "NSCollection+HDExtension.h"

#import "NSObject+HDExtension.h"

static BOOL safeEnable = NO;
static BOOL logEnable = NO;

#define MSSafeLog(...) safeCollectionLog(__VA_ARGS__)

void safeCollectionLog(NSString *fmt, ...) NS_FORMAT_FUNCTION(1, 2);
void safeCollectionLog(NSString *fmt, ...)
{
    if (!logEnable)
    {
        return;
    }
    va_list ap;
    va_start(ap, fmt);
    NSString *content = [[NSString alloc] initWithFormat:fmt arguments:ap];
    NSLog(@"%@", content);
    va_end(ap);

    NSLog(@"\n ============= call stack start ========== \n%@", [NSThread callStackSymbols]);
    NSLog(@"\n ============= call stack end ========== ");
}

@implementation HDSafeCollection

/**
 是否使用安全的访问方式去请求 集合（NSArray/NSMutableArray、NSDictionary/NSMutableDictionary）
 类型的可能Crash的接口方法

 @param enabled 默认是NO，使用不当Crash的地方还是会Crash
 */
+ (void)hd_safeCollectionEnable:(BOOL)enabled
{
    safeEnable = enabled;
}

/**
 是否需要在即将Crash的时候打印相关信息

 @param enabled 默认为NO，不打印
 */
+ (void)hd_safeCollectionLogEnable:(BOOL)enabled
{
    logEnable = enabled;
}

@end


@implementation NSArray (HDSafeKit)

#pragma mark - NSArray

- (id)hd_objectAtIndex:(NSUInteger)index {
    if (!safeEnable) {
        return [self hd_objectAtIndex:index];
    }

    if (!self) {
        return nil;
    }

    if (index >= [self count]) {
        MSSafeLog(@"[%@ %@] index {%lu} beyond bounds [0...%lu]",
                  NSStringFromClass([self class]),
                  NSStringFromSelector(_cmd),
                  (unsigned long)index,
                  MAX((unsigned long)self.count - 1, 0));
        return nil;
    }
    return [self hd_objectAtIndex:index];
}

- (id)hd_objectAtIndexedSubscript:(NSUInteger)index {
    if (!safeEnable) {
        return [self hd_objectAtIndexedSubscript:index];
    }
    if (!self) {
        return nil;
    }

    if (index >= [self count]) {
        MSSafeLog(@"[%@ %@] index {%lu} beyond bounds [0...%lu]",
                  NSStringFromClass([self class]),
                  NSStringFromSelector(_cmd),
                  (unsigned long)index,
                  MAX((unsigned long)self.count - 1, 0));
        return nil;
    }
    return [self hd_objectAtIndexedSubscript:index];
}

- (id)hd_objectAtIndexedSubscriptM:(NSUInteger)index {
    if (!safeEnable) {
        return [self hd_objectAtIndexedSubscriptM:index];
    }
    if (!self) {
        return nil;
    }

    if (index >= [self count]) {
        MSSafeLog(@"[%@ %@] index {%lu} beyond bounds [0...%lu]",
                  NSStringFromClass([self class]),
                  NSStringFromSelector(_cmd),
                  (unsigned long)index,
                  MAX((unsigned long)self.count - 1, 0));
        return nil;
    }
    return [self hd_objectAtIndexedSubscriptM:index];
}

- (NSArray *)hd_arrayByAddingObject:(id)anObject {
    if (!safeEnable) {
        return [self hd_arrayByAddingObject:anObject];
    }

    if (!anObject) {
        MSSafeLog(@"[%@ %@] arrayByAddingObject object is nil",
                  NSStringFromClass([self class]),
                  NSStringFromSelector(_cmd));
        return self;
    }
    return [self hd_arrayByAddingObject:anObject];
}

#pragma mark - NSMutableArray

- (void)hd_addObject:(id)anObject {
    if (!safeEnable) {
        return [self hd_addObject:anObject];
    }

    if (!anObject) {
        MSSafeLog(@"[%@ %@] addObject object is nil",
                  NSStringFromClass([self class]),
                  NSStringFromSelector(_cmd));
        return;
    }
    [self hd_addObject:anObject];
}

- (void)hd_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (!safeEnable) {
        return [self hd_insertObject:anObject atIndex:index];
    }

    if (!anObject) {
        MSSafeLog(@"[%@ %@] insertObject object is nil",
                  NSStringFromClass([self class]),
                  NSStringFromSelector(_cmd));
        return;
    }

    if (index > [self count]) {
        MSSafeLog(@"[%@ %@] insertObject index {%lu} beyond bounds [0...%lu]",
                  NSStringFromClass([self class]),
                  NSStringFromSelector(_cmd),
                  (unsigned long)index,
                  MAX((unsigned long)self.count - 1, 0));
        return;
    }

    [self hd_insertObject:anObject atIndex:index];
}

- (void)hd_removeObjectAtIndex:(NSUInteger)index {
    if (!safeEnable) {
        return [self hd_removeObjectAtIndex:index];
    }

    if (index >= [self count]) {
        MSSafeLog(@"[%@ %@] removeObjectAtIndex index {%lu} beyond bounds [0...%lu]",
                  NSStringFromClass([self class]),
                  NSStringFromSelector(_cmd),
                  (unsigned long)index,
                  MAX((unsigned long)self.count - 1, 0));
        return;
    }

    return [self hd_removeObjectAtIndex:index];
}
- (void)hd_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (!safeEnable) {
        return [self hd_replaceObjectAtIndex:index withObject:anObject];
    }

    if (index >= [self count]) {
        MSSafeLog(@"[%@ %@] replaceObjectAtIndex index {%lu} beyond bounds [0...%lu]",
                  NSStringFromClass([self class]),
                  NSStringFromSelector(_cmd),
                  (unsigned long)index,
                  MAX((unsigned long)self.count - 1, 0));
        return;
    }
    if (!anObject) {
        MSSafeLog(@"[%@ %@] replaceObjectAtIndex object is nil",
                  NSStringFromClass([self class]),
                  NSStringFromSelector(_cmd));
        return;
    }
    [self hd_replaceObjectAtIndex:index withObject:anObject];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //NSArray
        Class class1 = NSClassFromString(@"__NSArrayI");
        [self hd_swizzleMethod:class1 srcSel:@selector(objectAtIndex:)
                      tarClass:class1 tarSel:@selector(hd_objectAtIndex:)];
        [self hd_swizzleMethod:class1 srcSel:@selector(arrayByAddingObject:)
                      tarClass:class1 tarSel:@selector(hd_arrayByAddingObject:)];
        [self hd_swizzleMethod:class1 srcSel:@selector(objectAtIndexedSubscript:)
                      tarClass:class1 tarSel:@selector(hd_objectAtIndexedSubscript:)];


        //NSMutableArray
        Class class2 = NSClassFromString(@"__NSArrayM");
        [self hd_swizzleMethod:class2 srcSel:@selector(addObject:)
                      tarClass:class2 tarSel:@selector(hd_addObject:)];
        [self hd_swizzleMethod:class2 srcSel:@selector(insertObject:atIndex:)
                      tarClass:class2 tarSel:@selector(hd_insertObject:atIndex:)];
        [self hd_swizzleMethod:class2 srcSel:@selector(removeObjectAtIndex:)
                      tarClass:class2 tarSel:@selector(hd_removeObjectAtIndex:)];
        [self hd_swizzleMethod:class2 srcSel:@selector(replaceObjectAtIndex:withObject:)
                      tarClass:class2 tarSel:@selector(hd_replaceObjectAtIndex:withObject:)];
        [self hd_swizzleMethod:class2 srcSel:@selector(objectAtIndexedSubscript:)
                      tarClass:class2 tarSel:@selector(hd_objectAtIndexedSubscriptM:)];
    });
}

@end



@implementation NSDictionary (HDSafeKit)

- (void)hd_removeObjectForKey:(id)aKey {
    if (!safeEnable) {
        return [self hd_removeObjectForKey:aKey];
    }

    if (!aKey) {
        MSSafeLog(@"[%@ %@] removeObjectForKey key is nil",
                  NSStringFromClass([self class]),
                  NSStringFromSelector(_cmd));
        return;
    }
    [self hd_removeObjectForKey:aKey];
}

- (void)hd_setObject:(id)anObject forKey:(id <NSCopying>)aKey {
    if (!safeEnable) {
        return [self hd_setObject:anObject forKey:aKey];
    }

    if (!anObject) {
        MSSafeLog(@"[%@ %@] setObject:forKey object is nil",
                  NSStringFromClass([self class]),
                  NSStringFromSelector(_cmd));
        return;
    }
    if (!aKey) {
        MSSafeLog(@"[%@ %@] setObject:forKey key is nil",
                  NSStringFromClass([self class]),
                  NSStringFromSelector(_cmd));
        return;
    }
    [self hd_setObject:anObject forKey:aKey];
}

+ (void) load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class1 = NSClassFromString(@"__NSDictionaryM");
        [self hd_swizzleMethod:class1 srcSel:@selector(removeObjectForKey:)
                      tarClass:class1 tarSel:@selector(hd_removeObjectForKey:)];
        [self hd_swizzleMethod:class1 srcSel:@selector(setObject:forKey:)
                      tarClass:class1 tarSel:@selector(hd_setObject:forKey:)];
    });
}

@end


@implementation NSString (HDSafeKit)

#pragma mark - NSString
- (unichar)hd_characterAtIndex:(NSUInteger)index {
    if (!safeEnable) {
        return [self hd_characterAtIndex:index];
    }

    if (index >= [self length]) {
        MSSafeLog(@"[%@ %@] characterAtIndex index {%lu} beyond bounds [0...%lu]",
                  NSStringFromClass([self class]),
                  NSStringFromSelector(_cmd),
                  (unsigned long)index,
                  MAX((unsigned long)self.length - 1, 0));
        return 0;
    }
    return [self hd_characterAtIndex:index];
}

- (NSString *)hd_substringWithRange:(NSRange)range {
    if (!safeEnable) {
        return [self hd_substringWithRange:range];
    }

    if (range.location + range.length > self.length) {
        MSSafeLog(@"[%@ %@] substringWithRange range {%lu, %lu} beyond bounds [0...%lu]",
                  NSStringFromClass([self class]),
                  NSStringFromSelector(_cmd),
                  (unsigned long)range.location,
                  (unsigned long)range.length,
                  MAX((unsigned long)self.length - 1, 0));
        return @"";
    }
    return [self hd_substringWithRange:range];
}

#pragma mark - NSMutableString
- (void)hd_appendString:(NSString *)aString {
    if (!safeEnable) {
        return [self hd_appendString:aString];
    }

    if (!aString) {
        MSSafeLog(@"[%@ %@] appendString string is nil",
                  NSStringFromClass([self class]),
                  NSStringFromSelector(_cmd));
        return;
    }
    [self hd_appendString:aString];
}

- (void)hd_appendFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2) {
    if (!safeEnable) {
        va_list arguments;
        va_start(arguments, format);
        NSString *formatStr = [[NSString alloc]initWithFormat:format arguments:arguments];
        [self hd_appendFormat:@"%@",formatStr];
        va_end(arguments);
        return ;
    }

    if (!format) {
        MSSafeLog(@"[%@ %@] appendFormat format is nil",
                  NSStringFromClass([self class]),
                  NSStringFromSelector(_cmd));
        return;
    }
    va_list arguments;
    va_start(arguments, format);
    NSString *formatStr = [[NSString alloc]initWithFormat:format arguments:arguments];
    [self hd_appendFormat:@"%@",formatStr];
    va_end(arguments);
}

- (void)hd_setString:(NSString *)aString {
    if (!safeEnable) {
        [self hd_setString:aString];
        return;
    }

    if (!aString) {
        MSSafeLog(@"[%@ %@] setString string is nil",
                  NSStringFromClass([self class]),
                  NSStringFromSelector(_cmd));
        return;
    }
    [self hd_setString:aString];
}

- (void)hd_insertString:(NSString *)aString atIndex:(NSUInteger)index {
    if (!safeEnable) {
        [self hd_insertString:aString atIndex:index];
        return ;
    }

    if (index > [self length]) {
        MSSafeLog(@"[%@ %@] insertString:atIndex index {%lu} beyond bounds [0...%lu]",
                  NSStringFromClass([self class]),
                  NSStringFromSelector(_cmd),
                  (unsigned long)index,
                  MAX((unsigned long)self.length - 1, 0));
        return;
    }
    if (!aString) {
        MSSafeLog(@"[%@ %@] insertString:atIndex string is nil",
                  NSStringFromClass([self class]),
                  NSStringFromSelector(_cmd));
        return;
    }

    [self hd_insertString:aString atIndex:index];
}

+ (void) load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //NSString
        Class class1 = NSClassFromString(@"__NSCFString");
        [self hd_swizzleMethod:class1 srcSel:@selector(characterAtIndex:)
                      tarClass:class1 tarSel:@selector(hd_characterAtIndex:)];
        [self hd_swizzleMethod:class1 srcSel:@selector(substringWithRange:)
                      tarClass:class1 tarSel:@selector(hd_substringWithRange:)];

        //NSMutableString，MacOS10.12.6中对应的是__NSCFString，有些版本是__NSCFConstantString
        Class class2 = NSClassFromString(@"__NSCFString");
        [self hd_swizzleMethod:class2 srcSel:@selector(appendString:)
                      tarClass:class2 tarSel:@selector(hd_appendString:)];
        [self hd_swizzleMethod:class2 srcSel:@selector(appendFormat:)
                      tarClass:class2 tarSel:@selector(hd_appendFormat:)];
        [self hd_swizzleMethod:class2 srcSel:@selector(setString:)
                      tarClass:class2 tarSel:@selector(hd_setString:)];
        [self hd_swizzleMethod:class2 srcSel:@selector(insertString:atIndex:)
                      tarClass:class2 tarSel:@selector(hd_insertString:atIndex:)];
    });
}

@end


