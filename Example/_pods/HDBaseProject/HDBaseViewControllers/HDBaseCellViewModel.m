//
//  HDBaseViewModel.m
//  Pods
//
//  Created by denglibing on 2016/11/11.
//
//

#import "HDBaseCellViewModel.h"

#import "HDGlobalVariable.h"

@implementation HDBaseCellViewModel

+ (instancetype) modelFromClass:(Class)cellClass cellModel:(id)cellModel delegate:(id)delegate height:(NSInteger)height {
    HDBaseCellViewModel *model = [[self alloc] init];
    model.cellClass = cellClass;
    model.delegate = delegate;
    model.cellHeight = height;
    model.rotateCellHeight = height;
    model.cellModel = cellModel;
    return model;
}

+ (instancetype) modelFromStaticCell:(UITableViewCell *)cell cellModel:(id)cellModel delegate:(id)delegate height:(NSInteger)height{
    HDBaseCellViewModel *model = [[self alloc] init];
    model.staticCell = cell;
    model.cellModel = cellModel;
    model.delegate = delegate;
    model.cellHeight = height;
    model.rotateCellHeight = height;
    return model;
}

- (CGFloat)cellHeight {
    if ([self hd_interfaceOrientationPortrait]) {
        return _cellHeight;
    }
    return _rotateCellHeight;
}

- (BOOL)hd_interfaceOrientationPortrait {
    if(([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) ||
       ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)){
        return YES;
    }
    return NO;
}

@end
