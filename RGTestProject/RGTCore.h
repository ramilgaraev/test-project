//
//  RGTCore.h
//  RGTestProject
//
//  Created by Ramil Garaev on 15.12.16.
//  Copyright © 2016 Ramil Garaev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RGTArticle;

/*! @description Business logic class */
@interface RGTCore : NSObject

/*! @description Returns shared instance  */
+(instancetype) sharedInstance;

/*! @description  Async update articles from 4pda.ru and call completionBlock  */
-(void) updateArticlesWithCompletionBlock: (void(^)(NSError* error, NSArray<RGTArticle*>* newArticles)) completionBlock;

/*! @description  Async download article and call completionBlock after saving the article.  */
-(void) downloadArticle: (RGTArticle*) article withCompletion: (void(^)(RGTArticle* downloadedArticle)) completionBlock;

-(NSURL*) contentFileURLForArticle: (RGTArticle*) article;

@end
