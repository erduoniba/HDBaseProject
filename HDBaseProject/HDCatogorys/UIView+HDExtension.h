//
//  UIView+HDExtension.h
//  HDBaseProject
//
//  Created by 邓立兵 on 2017/11/28.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HDShakedDirection) {
    HDShakedDirectionHorizontal,
    HDShakedDirectionVertical
};

@interface UIView (HDExtension)

#pragma mark -
#pragma mark - UIView+Shake

/** Shake the UIView https://github.com/andreamazz/UITextField-Shake
 *
 * Shake the uiview with default values: 10 times and 5 width 0.03s duration
 */
- (void)hd_shake;

/** Shake the UIView
 *
 * Shake the uiview a given number of times
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 */
- (void)hd_shake:(int)times withDelta:(CGFloat)delta;

/** Shake the UIView
 *
 * Shake the uiview a given number of times
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 * @param handler A block object to be executed when the shake sequence ends
 */
- (void)hd_shake:(int)times withDelta:(CGFloat)delta completion:(void((^)(void)))handler;

/** Shake the UIView at a custom speed
 *
 * Shake the uiview a given number of times with a given speed
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 * @param interval The duration of one shake
 */
- (void)hd_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval;

/** Shake the UIView at a custom speed
 *
 * Shake the uiview a given number of times with a given speed
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 * @param interval The duration of one shake
 * @param handler A block object to be executed when the shake sequence ends
 */
- (void)hd_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval completion:(void((^)(void)))handler;

/** Shake the UIView at a custom speed
 *
 * Shake the uiview a given number of times with a given speed
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 * @param interval The duration of one shake
 * @param shakeDirection of the shake
 */
- (void)hd_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(HDShakedDirection)shakeDirection;

/** Shake the UIView at a custom speed
 *
 * Shake the uiview a given number of times with a given speed
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 * @param interval The duration of one shake
 * @param shakeDirection of the shake
 * @param handler A block object to be executed when the shake sequence ends
 */
- (void)hd_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(HDShakedDirection)shakeDirection completion:(void((^)(void)))handler;


#pragma mark -
#pragma mark - UIView+BlockGesture

/**
 添加tap手势

 @param block 代码块
 */
- (void)hd_addTapActionWithBlock:(void (^)(UIGestureRecognizer *gestureRecoginzer))block;


#pragma mark -
#pragma mark - UIView+Responder

- (UIView *)hd_findFirstResponder;

- (UITableViewCell*)hd_superTableCell;

@end
