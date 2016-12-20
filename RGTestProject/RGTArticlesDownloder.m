
//
//  RGTArticlesDownloder.m
//  RGTestProject
//
//  Created by Ramil Garaev on 17.12.16.
//  Copyright © 2016 Ramil Garaev. All rights reserved.
//

#import "RGTArticlesDownloder.h"
#import "RGTArticle.h"
#import "RGTDatastore.h"
#import "RGTAPIClient.h"

@interface RGTArticlesDownloder()
{
    NSOperationQueue* _operationQueue;
    RGTDatastore* _dataStore;
}
@end

@implementation RGTArticlesDownloder

-(instancetype)initWithDatastore:(RGTDatastore *)datastore
{
    self = [super init];
    if (self)
    {
        _operationQueue = [NSOperationQueue new];
        _operationQueue.maxConcurrentOperationCount = 1;
        _dataStore = datastore;
    }
    return self;
}

-(void)downloadArticleContent:(RGTArticle *)article withCompletion:(void (^)(RGTArticle *downloadedArticle))completionBlock
{
    [_operationQueue addOperationWithBlock:^{

        NSData *data = [RGTAPIClient downloadContentDataForArticle: article];
        if (data)
        {
            article.state = RGTArticleStateIsDownloaded;
            [_dataStore saveArticle: article
                    withContentData: data];
            completionBlock(article);
        }
        else
        {
            [self downloadArticleContent: article
                          withCompletion: completionBlock];
        }
    }];
}

@end
