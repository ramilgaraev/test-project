//
//  RGTAPIClientTests.m
//  RGTestProject
//
//  Created by Ramil Garaev on 15.12.16.
//  Copyright © 2016 Ramil Garaev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RGTAPIClient.h"

@interface RGTAPIClientTests : XCTestCase

@end

@implementation RGTAPIClientTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testFetchNewArticles{
    XCTestExpectation* exp = [self expectationWithDescription:@"testFetchNewArticles"];
    [RGTAPIClient fetchNewArticlesSince: nil
                         withCompletion:^(NSArray<RGTArticle *> * _Nullable fetchedArticles, NSError * _Nullable error) {
                             if (!error)
                             {
                                 [exp fulfill];
                                 XCTAssertGreaterThan(fetchedArticles.count, 0, @"empty rss");

                             }
                         }];
    [self waitForExpectationsWithTimeout: 30 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error, @"connection problems");
    }];
}

@end
