//
//  HDTableViewConverter.h
//  HDUITableViewDemoObjC
//
//  Created by denglibing on 2017/2/14.
//  Copyright © 2017年 denglibing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HDBaseUITableViewCell;

@interface UITableView (HDIdentifierCell)

- (HDBaseUITableViewCell *)cellForIndexPath:(NSIndexPath *)indexPath cellClass:(Class)cellClass;

@end


typedef id (^resultBlock)(NSArray *params);

// tableView的delegate和datasource方法处理类模式
typedef NS_ENUM(NSInteger, HDTableViewConverterType) {
    //默认模式，使用注册方式处理tableView的一些协议
    HDTableViewConverter_Register = 0,
    
    //响应默认，优先使用 加载tableView的ViewController 中的tableView的协议
    HDTableViewConverter_Response,
};

// tableView的协议方法处理类
@interface HDTableViewConverter<TableViewCarrier>: NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) HDTableViewConverterType converterType;

- (instancetype)initWithTableViewCarrier:(TableViewCarrier)tableViewCarrier daraSources:(NSMutableArray *)dataArr;
- (void)reloadTableViewDataArr:(NSMutableArray *)dataArr;

// 只有在选择 HDTableViewConverter_Register 模式时，才会block回调
- (void)registerTableViewMethod:(SEL)selector handleParams:(resultBlock)block;

@end
