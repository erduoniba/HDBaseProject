//
//  NSObject+HDExtension.h
//  HDBaseProject
//
//  Created by 邓立兵 on 2017/11/27.
//

#import <Foundation/Foundation.h>

@interface NSObject (HDExtension)

#pragma mark -
#pragma mark - NSObject+Copy

/**
 *  浅复制目标的所有属性 https://github.com/shaojiankui/JKCategories
 *
 *  @param instance 目标对象
 *
 *  @return BOOL—YES:复制成功,NO:复制失败
 */
- (BOOL)hd_easyShallowCopy:(NSObject *)instance;

/**
 *  深复制目标的所有属性
 *
 *  @param instance 目标对象
 *
 *  @return BOOL—YES:复制成功,NO:复制失败
 */
- (BOOL)hd_easyDeepCopy:(NSObject *)instance;


#pragma mark -
#pragma mark - NSObject+AppInfo

-(NSString *)hd_version;
-(NSString *)hd_build;
-(NSString *)hd_identifier;
-(NSString *)hd_currentLanguage;
-(UIImage *)hd_appicon;


#pragma mark -
#pragma mark - NSObject+Blocks

typedef void (^HDBlockCancel)(BOOL cancel);

/**
 Class execute block after delay, return HDBlockCancel obj to cancel block. At current thread.

 @param block after delay to execute
 @param delay delay
 @return HDBlockCancel obj, to cancel block
 */
+ (HDBlockCancel)hd_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;

/**
 Instance execute block after delay, return HDBlockCancel obj to cancel block. At current thread.

 @param block after delay to execute
 @param delay delay
 @return HDBlockCancel obj, to cancel block
 */
- (HDBlockCancel)hd_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;

/**
 Instance execute block at dispatch_get_global_queue thread.

 @param block block
 */
- (void)hd_performAsynchronous:(void(^)(void))block;

/**
 Instance execute block at dispatch_get_main_queue thread.

 @param block block
 */
- (void)hd_performOnMainThread:(void(^)(void))block;

/**
 Instance execute block at dispatch_get_global_queue thread, afterwards execute block at dispatch_get_main_queue thread

 @param asycBlock dispatch_get_global_queue thread's block
 @param mainThreadBlock dispatch_get_main_queue thread's block
 */
- (void)hd_performAsynchronous:(void (^)(void))asycBlock afterPerformMainThread:(void(^)(void))mainThreadBlock;


/**
 Log execute block need time consuming, unit is milliseconds.

 @param block block
 @param prefixString Log add prefixString
 */
- (void)hd_logTimeTakenToRunBlock:(void (^)(void)) block withPrefix:(NSString *)prefixString;


#pragma mark -
#pragma mark - NSObject+AssociatedObject

/**
 附加一个stong对象 https://github.com/shaojiankui/JKCategories

 @param value 被附加的对象
 @param key 被附加对象的key
 */
- (void)hd_associateValue:(id)value withKey:(void *)key;

/**
 附加一个weak对象

 @param value 被附加的对象
 @param key 被附加对象的key
 */
- (void)hd_weaklyAssociateValue:(id)value withKey:(void *)key;

/**
 根据附加对象的key取出附加对象

 @param key 附加对象的key
 @return 附加对象
 */
- (id)hd_associatedValueForKey:(void *)key;


#pragma mark -
#pragma mark - NSObject+Runtime

/**
 Exchange Instance methods' implementations.

 @param origSel Instance origSel to exchange
 @param altSel Instance altSel to exchange
 @return YES: exchange success
 */
+ (BOOL)hd_swizzleMethod:(SEL)origSel withMethod:(SEL)altSel;

/**
 Exchange Class methods' implementations.

 @param origSel Class origSel to exchange
 @param altSel Class altSel to exchange
 @return YES: exchange success
 */
+ (BOOL)hd_swizzleClassMethod:(SEL)origSel withMethod:(SEL)altSel;

/**
 Append a new method to an object.

 @param newMethod Method to exchange.
 @param klass Host class.
 @return YES: add success
 */
+ (BOOL)hd_appendMethod:(SEL)newMethod fromClass:(Class)klass;

/**
 To swizzle two selector from self class to target class.

 @param srcSel source selector
 @param tarClassName target class name string
 @param tarSel target selector
 */
+(void)hd_swizzleMethod:(SEL)srcSel tarClassName:(NSString *)tarClassName tarSel:(SEL)tarSel;

/**
 To swizzle two selector from self class to target class.

 @param srcClass source class
 @param srcSel source selector
 @param tarClass target class
 @param tarSel target selector
 */
+ (void)hd_swizzleMethod:(Class)srcClass srcSel:(SEL)srcSel tarClass:(Class)tarClass tarSel:(SEL)tarSel;

@end
