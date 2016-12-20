//
//  RGTCoreTests.m
//  RGTestProject
//
//  Created by Ramil Garaev on 15.12.16.
//  Copyright © 2016 Ramil Garaev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RGTCore.h"
#import "RGTAPIClient.h"

@interface RGTTests : XCTestCase <RGTCoreDelegate>
{
    RGTCore* _core;
}

@end

@implementation RGTTests

- (void)setUp {
    [super setUp];
    _core =[RGTCore sharedInstance];
    _core.delegate = self;
}

- (void)tearDown {
    [super tearDown];
}


-(void) testWorkFlow
{
    XCTestExpectation* exp = [self expectationWithDescription:@"testFetchNewArticles"];
    [RGTAPIClient fetchNewArticlesSince: nil
                         withCompletion:^(NSArray<RGTArticle *> * _Nullable fetchedArticles, NSError * _Nullable error) {
                             [exp fulfill];
                             XCTAssertNil(error);
                             if (!error)
                             {
                                 XCTAssertGreaterThan(fetchedArticles.count, 0, @"empty rss");
                                 if (fetchedArticles.count > 0)
                                 {
                                     RGTArticle* article = fetchedArticles[0];
                                     [_core changeDownloadStateOfArticle: article];
                                 }
                             }
                         }];
    [self waitForExpectationsWithTimeout: 30
                                 handler: ^(NSError * _Nullable error) {
        XCTAssertNil(error, @"connection problems");
    }];
}

-(void)updatePresentationForArticle:(RGTArticle *)article
{
    XCTAssertNotNil([_core contentFileURLForArticle: article], @"Article was not downloaded");
}

@end
