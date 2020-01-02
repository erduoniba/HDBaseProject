//
//  HDBasePresenter.m
//  HDBaseProject
//
//  Created by 邓立兵 on 2017/9/17.
//
//

#import "HDBasePresenter.h"

@interface HDBasePresenter ()

@end

@implementation HDBasePresenter

#pragma mark - 公开方法
- (instancetype)initWithHDCarrier:(id <HDBasePresenterProtocol>)hdCarrier {
    self = [self init];
    if (self) {
        _hdCarrier = hdCarrier;
    }
    return self;
}

- (void)bindingHDCarrier:(id <HDBasePresenterProtocol>)hdCarrier {
    _hdCarrier = hdCarrier;
}

- (void)unbindingHDCarrier:(id <HDBasePresenterProtocol>)hdCarrier {
    _hdCarrier = nil;
}

- (void)hdRequestData {
    [self.hdRepository requestCache:^(id  _Nullable responseObject) {

    } success:^(NSURLSessionTask * _Nullable httpbase, id  _Nullable responseObject) {
        [self hdResposeCallback:responseObject];
        if (self.hdCarrier && [self.hdCarrier respondsToSelector:@selector(hdBasePresenter:resposeSuccess:)]) {
            [self.hdCarrier hdBasePresenter:self resposeSuccess:YES];
        }
    } failure:^(NSURLSessionTask * _Nullable httpbase, HDError * _Nullable error) {
        if (self.hdCarrier && [self.hdCarrier respondsToSelector:@selector(hdBasePresenter:resposeSuccess:)]) {
            [self.hdCarrier hdBasePresenter:self resposeSuccess:NO];
        }
    }];
}

- (void)hdResposeCallback:(id <HDBaseModelJsonResponseToModel>)resposeModel {

}

@end
