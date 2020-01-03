//
//  HDBasePresenter.h
//  HDBaseProject
//
//  Created by 邓立兵 on 2017/9/17.
//
//

#import <Foundation/Foundation.h>

#import "HDBaseRepository.h"
#import "HDBaseModel.h"

@class HDBasePresenter;

@protocol HDBasePresenterProtocol <NSObject>
@optional
- (void)hdBasePresenter:(HDBasePresenter *)hdPresenter resposeSuccess:(BOOL)success;
@end


/**
 MVP的Presenter层，负责获取数据及数据解析给UI想要的对象，负责业务模块的逻辑
 */
@interface HDBasePresenter : NSObject

/**
 数据获取对象类：负责网络数据请求及转换成model对象，不同子类需要初始化子类的hdRepository
 */
@property (nonatomic, strong) HDBaseRepository *hdRepository;

/**
 给VC的UI展示的数据
 */
@property (nonatomic, strong) id <HDBaseModelJsonResponseToModel> hdModel;

/**
 Presenter的载体，需要实现hdBasePresenterProtocol协议，负责Presenter的业务逻辑刷新UI，可以是
 view、viewController
 */
@property (nonatomic, weak, readonly) id <HDBasePresenterProtocol> hdCarrier;

/**
 初始化Presenter层并自动绑定载体类
 @param hdCarrier Presenter的载体，需要实现HDBasePresenterProtocol协议，负责Presenter的业务逻辑刷新UI，可以是
 view、viewController
 @return Presenter对象
 */
- (instancetype)initWithHDCarrier:(id <HDBasePresenterProtocol>)hdCarrier;

- (void)bindingHDCarrier:(id <HDBasePresenterProtocol>)hdCarrier;
- (void)unbindingHDCarrier:(id <HDBasePresenterProtocol>)hdCarrier;


/**
 请求数据，结果通过HDBasePresenterProtocol回调出去
 */
- (void)hdRequestData;

/**
 数据请求成功后，返回的数据

 @param resposeModel 这个是需要实现HDBaseModelJsonResponseToModel协议的model对象
 */
- (void)hdResposeCallback:(id <HDBaseModelJsonResponseToModel>)resposeModel;

@end
