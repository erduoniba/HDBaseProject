//
//  HDBaseProjectTests.m
//  HDBaseProjectTests
//
//  Created by Harry on 09/15/2015.
//  Copyright (c) 2015 Harry. All rights reserved.
//

@import XCTest;

#import "HDViewController.h"
#import <HDBaseProject/HDBaseProject.h>
#import <AFNetworking/AFNetworking.h>
#import <OCMock/OCMock.h>

#import "HDMockDemo.h"

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    NSString *originUrl = @"http://www.example.com?name=123";
    NSString *urlencode = [originUrl hd_urlEncode];
    NSString *urldencode = [urlencode hd_urlDecode];
    NSLog(@"== originUrl: %@ urlencode: %@ urldencode: %@ [originUrl isEqualToString:urlencode]: %d", originUrl, urlencode, urldencode, [originUrl isEqualToString:urldencode]);
    XCTAssertTrue([originUrl isEqualToString:urldencode]);
}

- (void)testMock {
    // 设置预期返回的值和结果进行对比
    HDMockDemo *model1 = OCMStrictClassMock([HDMockDemo class]);
    OCMStub([model1 mockTest:@"22"]).andReturn(@"mockTest_22");
    NSString *res1 = [model1 mockTest:@"22"];
    
    HDMockDemo *model2 = HDMockDemo.new;
    NSString *res2 = [model2 mockTest:@"22"];
    NSLog(@"res1:%@, res2:%@", res1, res2);
    XCTAssertEqualObjects(res1, res2);
}

- (void)testMock2 {
    // 将方法的实现代理给其他类实现，然后对比
    HDMockDemo *model1 = OCMStrictClassMock([HDMockDemo class]);
    HDMockDemo *model2 = HDMockDemo.new;
    OCMStub([model1 mockTest:@"22"])._andCall(model2, @selector(mockTest2:));
    
    NSString *res1 = [model1 mockTest:@"22"];
    NSString *res2 = [model2 mockTest:@"22"];
    NSLog(@"res1:%@, res2:%@", res1, res2);
    
    XCTAssertEqualObjects(res1, res2);
}

@end

