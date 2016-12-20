//
//  RGTCore.h
//  RGTestProject
//
//  Created by Ramil Garaev on 15.12.16.
//  Copyright © 2016 Ramil Garaev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RGTArticle;

@protocol RGTCoreDelegate

-(void) updatePresentationForArticle: (RGTArticle*) article;

@end

/*! @description Business logic class */
@interface RGTCore : NSObject

@property (nonatomic, weak) id<RGTCoreDelegate> delegate;

/*! @description Returns shared instance  */
+(instancetype) sharedInstance;

/*! @description  Async update articles from 4pda.ru and call completionBlock  */
-(void) updateArticlesWithCompletionBlock: (void(^)(NSError* error, NSArray<RGTArticle*>* newArticles)) completionBlock;

/*! @description  Async change download state article.  */
-(void) changeDownloadStateOfArticle: (RGTArticle*) article;

-(NSURL*) contentFileURLForArticle: (RGTArticle*) article;

@end
