//
//  RGTCoreTests.m
//  RGTestProject
//
//  Created by Ramil Garaev on 15.12.16.
//  Copyright © 2016 Ramil Garaev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RGTCore.h"

@interface RGTCoreTests : XCTestCase

@end

@implementation RGTCoreTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testUpdateArticles{
    XCTestExpectation* exp = [self expectationWithDescription:@"testUpdateArticles"];
    [[RGTCore sharedInstance] updateArticlesWithCompletionBlock:^(NSError *error) {
        [exp fulfill];
        XCTAssertNotNil([[RGTCore sharedInstance] articles]);
    }];
    [self waitForExpectationsWithTimeout: 30 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"connection problems");
    }];

}

@end
