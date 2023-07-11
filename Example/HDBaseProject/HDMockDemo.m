//
//  HDMockDemo.m
//  HDBaseProject_Example
//
//  Created by 邓立兵 on 2021/4/12.
//  Copyright © 2021 Harry. All rights reserved.
//

#import "HDMockDemo.h"

@implementation HDMockDemo

- (NSString *)mockTest:(NSString *)tt {
    return [NSString stringWithFormat:@"mockTest_%@", tt];
}

- (NSString *)mockTest2:(NSString *)tt {
    return [NSString stringWithFormat:@"mockTest2_%@", tt];
}

@end
