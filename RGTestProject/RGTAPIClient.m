//
//  APIClient.m
//  RGTestProject
//
//  Created by Ramil Garaev on 15.12.16.
//  Copyright © 2016 Ramil Garaev. All rights reserved.
//

#import "RGTAPIClient.h"
#import "RGTArticle.h"
#import "NSError+RGTErrorCodes.h"
#import <BNRSSFeedParser/BNRSSFeedParser.h>
#import <BNRSSFeedParser/BNRSSFeed.h>
#import <BNRSSFeedParser/BNRSSFeedItem.h>

static NSString* RSSURL = @"http://4pda.ru/feed";


@implementation RGTAPIClient

+(void) fetchNewArticlesSince: (NSDate* _Nullable) lastFetchingDate withCompletion: (RGTArticlesFetchingCompletionBlock _Nonnull) completionBlock
{
    BNRSSFeedParser* parser = [BNRSSFeedParser new];
    [parser parseFeedURL: [NSURL URLWithString: RSSURL]
                withETag: nil
            untilPubDate: lastFetchingDate
                 success: ^(NSHTTPURLResponse *resp, BNRSSFeed *feed) {
                     NSMutableArray<RGTArticle*>* articles = [NSMutableArray new];
                     for (BNRSSFeedItem* item in feed.items) {
                         RGTArticle* article = [RGTArticle new];
                         article.guid = item.guid;
                         article.title = item.title;
                         [articles addObject: article];
                     }
                     completionBlock(articles, nil);
                     
                 }
                 failure: ^(NSHTTPURLResponse *resp, NSError *error) {
                     completionBlock(nil, [NSError rgt_errorWithCode: RGTErrorCodeConnectionProblems]);
                 }];
}

+(void) downloadContentForArticle: (RGTArticle* _Nonnull) article withCompletionBlock: (RGTDownloadContentOfArticleCompletionBlock _Nonnull) completionBlock
{
#warning todo
}

@end
