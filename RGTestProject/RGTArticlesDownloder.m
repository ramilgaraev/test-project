
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

-(void)downloadArticle:(RGTArticle *)article withCompletion:(void (^)(RGTArticle *downloadedArticle))completionBlock
{
    [_operationQueue addOperationWithBlock:^{
        NSError* error;
        NSData *data = [NSData dataWithContentsOfURL: article.link
                                             options: NSDataReadingUncached
                                               error: &error];

        if (!error)
        {
            article.state = RGTArticleStateIsDownloaded;
            [_dataStore saveArticle: article
                    withContentData: data];
            completionBlock(article);
        }
        else
        {
            [self downloadArticle: article
                   withCompletion: completionBlock];
        }
    }];
}

@end
