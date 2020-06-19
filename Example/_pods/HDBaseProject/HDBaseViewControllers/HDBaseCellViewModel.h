//
//  HDBaseViewModel.h
//  Pods
//
//  Created by denglibing on 2016/11/11.
//
//

#import <Foundation/Foundation.h>

/**
 选择cell的样式

 - HDCommonCellStyle_Default: 默认样式，左右有文字，无箭头
 - HDCommonCellStyle_Detail: 详细模式，左右有文字，有箭头
 */
typedef NS_ENUM(NSInteger, HDCommonCellStyle) {
    HDCommonCellStyle_Default = 0,
    HDCommonCellStyle_Detail,
};

// __unsafe_unretained 使用 http://stackoverflow.com/questions/8592289/arc-the-meaning-of-unsafe-unretained

@interface HDBaseCellViewModel : NSObject

@property (nonatomic, strong) id cellModel;                     //cell的数据源
@property (nonatomic, assign) Class cellClass;                    //cell的Class
@property (nonatomic, weak)      id delegate;                        //cell的代理
@property (nonatomic, assign) CGFloat cellHeight;               //cell的高度，提前计算好（竖屏的高度）
@property (nonatomic, assign) SEL selector;                     //cell的点击事件
@property (nonatomic, strong) UITableViewCell *staticCell;        //兼容静态的cell

@property (nonatomic, assign) CGFloat rotateCellHeight;     //cell的高度，提前计算好（横屏的高度）

@property (nonatomic, assign) HDCommonCellStyle commonCellType; //通用cell的類型

+ (instancetype) modelFromClass:(__unsafe_unretained Class)cellClass cellModel:(id)cellModel delegate:(id)delegate height:(CGFloat)height;
+ (instancetype) modelFromStaticCell:(UITableViewCell *)cell cellModel:(id)cellModel delegate:(id)delegate height:(CGFloat)height;

@end
