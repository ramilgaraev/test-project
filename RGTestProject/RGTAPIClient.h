//
//  APIClient.h
//  RGTestProject
//
//  Created by Ramil Garaev on 15.12.16.
//  Copyright © 2016 Ramil Garaev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RGTArticle;

/*! @description Block for handling fetched articles. */
typedef void (^RGTArticlesFetchingCompletionBlock)(NSArray<RGTArticle*>* _Nullable fetchedArticles, NSError* _Nullable error);
/*! @description Block for handling downloaded article's content. */
typedef void (^RGTDownloadContentOfArticleCompletionBlock)(NSArray<RGTArticle*>* _Nonnull filledArticle, NSError* _Nullable error);


/*! @description The class implements data fetching from 4da.ru. */
@interface RGTAPIClient : NSObject

/*! @description Async fetch new articles since lastFetchingDate till now. if lastFetchingDate is nil method returns all available articles. After finishing fetching completionBlock with found articles will be called. */
+(void) fetchNewArticlesSince: (NSDate* _Nullable) lastFetchingDate withCompletion: (RGTArticlesFetchingCompletionBlock _Nonnull) completionBlock;

/*! @description Async donwload the article content. After finishing downloading completionBlock with article  filled with content will be called. */
+(void) downloadContentForArticle: (RGTArticle* _Nonnull) article withCompletionBlock: (RGTDownloadContentOfArticleCompletionBlock _Nonnull) completionBlock;

@end
