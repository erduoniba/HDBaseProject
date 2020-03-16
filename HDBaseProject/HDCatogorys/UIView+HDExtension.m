//
//  UIView+HDExtension.m
//  HDBaseProject
//
//  Created by 邓立兵 on 2017/11/28.
//

#import "UIView+HDExtension.h"

#import <objc/runtime.h>
static char hd_kActionHandlerTapBlockKey;
static char hd_kActionHandlerTapGestureKey;

@implementation UIView (HDExtension)


#pragma mark -
#pragma mark - UIView+Shake

- (void)hd_shake {
    [self hd_shake:10 withDelta:5 completion:nil];
}

- (void)hd_shake:(int)times withDelta:(CGFloat)delta {
    [self hd_shake:times withDelta:delta completion:nil];
}

- (void)hd_shake:(int)times withDelta:(CGFloat)delta completion:(void(^)(void))handler {
    [self hd_shake:times direction:1 currentTimes:0 withDelta:delta speed:0.03 shakeDirection:HDShakedDirectionHorizontal completion:handler];
}

- (void)hd_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval {
    [self hd_shake:times withDelta:delta speed:interval completion:nil];
}

- (void)hd_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval completion:(void(^)(void))handler {
    [self hd_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:HDShakedDirectionHorizontal completion:handler];
}

- (void)hd_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(HDShakedDirection)shakeDirection {
    [self hd_shake:times withDelta:delta speed:interval shakeDirection:shakeDirection completion:nil];
}

- (void)hd_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(HDShakedDirection)shakeDirection completion:(void(^)(void))handler {
    [self hd_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:shakeDirection completion:handler];
}

- (void)hd_shake:(int)times direction:(int)direction currentTimes:(int)current withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(HDShakedDirection)shakeDirection completion:(void(^)(void))handler {
    [UIView animateWithDuration:interval animations:^{
        self.transform = (shakeDirection == HDShakedDirectionHorizontal) ? CGAffineTransformMakeTranslation(delta * direction, 0) : CGAffineTransformMakeTranslation(0, delta * direction);
    } completion:^(BOOL finished) {
        if(current >= times) {
            [UIView animateWithDuration:interval animations:^{
                self.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if (handler) {
                    handler();
                }
            }];
            return;
        }
        [self hd_shake:(times - 1)
              direction:direction * -1
           currentTimes:current + 1
              withDelta:delta
                  speed:interval
         shakeDirection:shakeDirection
             completion:handler];
    }];
}


#pragma mark -
#pragma mark - UIView+BlockGesture

- (void)hd_addTapActionWithBlock:(void (^)(UIGestureRecognizer *gestureRecoginzer))block
{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &hd_kActionHandlerTapGestureKey);
    if (!gesture)
    {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hd_handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &hd_kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &hd_kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)hd_handleActionForTapGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        void (^ block)(UIGestureRecognizer *gestureRecoginzer) = objc_getAssociatedObject(self, &hd_kActionHandlerTapBlockKey);
        if (block)
        {
            block(gesture);
        }
    }
}


- (UIView *)hd_findFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView hd_findFirstResponder];
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    return nil;
}

- (UITableViewCell*)hd_superTableCell
{
    if ([self isKindOfClass:[UITableViewCell class]]) {
        return (UITableViewCell *)self;
    }
    if (self.superview) {
        UITableViewCell  * tableViewCell = [self.superview hd_superTableCell];
        if (tableViewCell != nil) {
            return tableViewCell;
        }
    }
    return nil;
}

@end
