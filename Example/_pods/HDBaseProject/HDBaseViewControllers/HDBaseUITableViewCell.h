//
//  BaseUITableViewCell.h
//  SecondHouseBroker
//
//  Created by Harry on 15-8-4.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HDBaseTableViewCellType) {
    HDBaseTableViewCellNone,       //上下线都隐藏
    HDBaseTableViewCellAtFirst,    //下线隐藏,按照group样式即第一个cell,originx=0
    HDBaseTableViewCellAtMiddle,   //下线隐藏,按照group样式即中间cell,originx=separateLineOffset
    HDBaseTableViewCellAtLast,     //上下线都显示,按照group样式即最后一个cell,上线originx=separateLineOffset 下线originx=0
    HDBaseTableViewCellNormal,     //下线隐藏,按照plain样式,originx=separateLineOffset
    HDBaseTableViewCellSingle,     //上下线都显示，originx=0
    HDBaseTableViewCellBottomLine, //下线都显示，originx=0
    HDBaseTableViewCellAtMiddleShowLine, //都显示，上下线originx=separateLineOffset
};

@class HDBaseUITableViewCell;

@protocol HDBaseUITableViewCellDelegate <NSObject>

@optional
- (void)msTableViewCell:(HDBaseUITableViewCell *)cell anyObject:(id)anyObject;
- (void)msReloadTableViewCell:(HDBaseUITableViewCell *)cell;

@end

@interface HDBaseUITableViewCell<ObjectType> : UITableViewCell

@property (nonatomic,weak) id<HDBaseUITableViewCellDelegate> hdDelegate;
@property (nonatomic,strong) ObjectType hdCellData;
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic, copy) void (^ handleCellAction)(Class className, id anyObject);

#pragma mark - 分割线属性设置
/**
 *  分隔线的颜色值,默认为(208,208,208)
 */
@property (nonatomic,strong) UIColor *lineColor;

/**
 *  分割线了偏移量,默认是0
 */
@property(nonatomic, assign) NSInteger separateLineOffset;

/**
 *  分隔线是上,还是下,还是中间的
 */
@property(nonatomic, assign) HDBaseTableViewCellType cellType;


+ (CGFloat)cellHeightWithCellData:(ObjectType)cellData;
+ (CGFloat)cellHeightWithCellData:(ObjectType)cellData boundWidth:(CGFloat)width;

// 兼容横屏的高度，这个缓存横屏时cell的高度
+ (CGFloat)rotateCellHeightWithCellData:(ObjectType)cellData;

- (void)setCellData:(ObjectType)MSCellData;
- (void)setCellData:(ObjectType)MSCellData delegate:(id)delegate;
- (void)setSeperatorLine:(NSIndexPath *)indexPath numberOfRowsInSection:(NSInteger)numberOfRowsInSection;

- (CGFloat)cellHeightWithCellData:(ObjectType)cellData;

@end
