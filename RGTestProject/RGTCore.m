//
//  RGTCore.m
//  RGTestProject
//
//  Created by Ramil Garaev on 15.12.16.
//  Copyright © 2016 Ramil Garaev. All rights reserved.
//

#import "RGTCore.h"
#import "RGTAPIClient.h"
#import "RGTDatastore.h"
#import "RGTArticlesDownloder.h"
#import "RGTArticle.h"

@interface RGTCore()
{
    NSDate* _lastArticlesFetchingDate;
    RGTDatastore* _datastore;
    RGTArticlesDownloder* _articlesDownloader;
}
@end

@implementation RGTCore

+(instancetype) sharedInstance
{
    static RGTCore* core;
    static dispatch_once_t token;
    dispatch_once(&token,^{
        core = [RGTCore new];
    });
    return core;
}

-(id) init
{
    self = [super init];
    if (self)
    {
        _datastore = [RGTDatastore new];
    }
    return self;
}

-(void) updateArticlesWithCompletionBlock: (void(^)(NSError* error, NSArray<RGTArticle*>* newArticles)) completionBlock
{
    [RGTAPIClient fetchNewArticlesSince: _lastArticlesFetchingDate
                         withCompletion:^(NSArray<RGTArticle *> * _Nullable fetchedArticles, NSError * _Nullable error) {
                             NSMutableArray* resultArticles = [NSMutableArray array];
                             NSArray<RGTArticle*>* offlineArticles;
                             if (!_lastArticlesFetchingDate)
                             {
                                 // we started the app & need to get offline articles
                                 offlineArticles = [_datastore savedArticles];
                                 [resultArticles addObjectsFromArray: offlineArticles];
                             }
                             if (!error)
                             {
                                 // we recieved an answer from server
                                 if (offlineArticles)
                                 {
                                     // need to join
                                     for (RGTArticle* articleFromServer in fetchedArticles)
                                     {
                                         // for each article from server check existing offline duplicate
                                         BOOL foundDuplicate = false;
                                         NSInteger index =0;
                                         while (!foundDuplicate && index < offlineArticles.count)
                                         {
                                             if ([articleFromServer isEqual: offlineArticles[index]])
                                                 foundDuplicate = YES;
                                             index++;
                                         }
                                         // if duplicate is not found add the article to the result array 
                                         if (!foundDuplicate)
                                             [resultArticles addObject: articleFromServer];
                                     }
                                     // sort
                                     [resultArticles sortUsingComparator: ^NSComparisonResult(RGTArticle* article1, RGTArticle* article2) {
                                         return [article1.publicationDate compare: article2.publicationDate];
                                     }];
                                 }
                                 _lastArticlesFetchingDate = [NSDate date];
                             }
                             completionBlock(error, resultArticles);
                         }];
}

-(void)changeDownloadStateOfArticle:(RGTArticle *)article
{
    switch (article.state)
    {
        case RGTArticleStateIsDownloading:
            break;
        case RGTArticleStateIsDownloaded:
            article.state = RGTArticleStateIsNotDownloaded;
            [self.delegate updatePresentationForArticle: article];
            [_datastore deleteArticle: article];
            break;
        case RGTArticleStateIsNotDownloaded:
            article.state = RGTArticleStateIsDownloading;
            [self.delegate updatePresentationForArticle: article];
            if (!_articlesDownloader)
                _articlesDownloader = [[RGTArticlesDownloder alloc] initWithDatastore: _datastore];
            [_articlesDownloader downloadArticleContent: article
                                         withCompletion: ^(RGTArticle *downloadedArticle) {
                                             [self.delegate updatePresentationForArticle: downloadedArticle];
                                         }];
            break;
    }
}


-(NSURL*) contentFileURLForArticle: (RGTArticle*) article
{
    NSURL* url = [NSURL fileURLWithPath: [_datastore pathToSavedContentOfArticle: article]];
    return url;
}

@end
