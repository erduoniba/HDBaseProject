//
//  HDBaseModel.h
//  HDBaseProject
//
//  Created by 邓立兵 on 2017/9/17.
//
//

#import <Foundation/Foundation.h>

/**
 因为数据的解析方法在base层做好，但是具体的实现会有差异化，所以使用该协议来处理特殊的情况（model可以不继承MSBaseModel）。
 */
@protocol HDBaseModelJsonResponseToModel <NSObject>

@required
/**
 该方法解析来自服务器获取缓存的数据

 @param jsonResponse 服务器获取缓存的数据
 @return 服务器获取缓存的数据转换后的对象
 */
+ (id)disposeJsonRepose:(id)jsonResponse;

@end

@interface HDBaseModel : NSObject <HDBaseModelJsonResponseToModel>

@end
