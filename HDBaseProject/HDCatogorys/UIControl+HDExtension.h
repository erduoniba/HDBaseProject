//
//  UIControl+HDExtension.h
//  HDBaseProject
//
//  Created by 邓立兵 on 2017/11/28.
//

#import <UIKit/UIKit.h>

@interface UIControl (HDExtension)


/**
 Set the sound for a particular control event (or events). ⚠️: this fuction should front of addTarget: action: forControlEvents:

 @param name The name of the file. The method looks for an image with the specified name in the application’s main bundle.
 @param controlEvent A bitmask specifying the control events for which the action message is sent. See “Control Events” for bitmask constants.
 */
- (void)hd_setSoundNamed:(NSString *)name forControlEvent:(UIControlEvents)controlEvent;

@end
