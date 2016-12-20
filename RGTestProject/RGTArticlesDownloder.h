//
//  RGTArticlesDownloder.h
//  RGTestProject
//
//  Created by Ramil Garaev on 17.12.16.
//  Copyright © 2016 Ramil Garaev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RGTArticle;
@class RGTDatastore;

/*! @description  Class implement methods for downloading and saving articles*/
@interface RGTArticlesDownloder : NSObject

/*! @description  Return an instance  */
-(instancetype) initWithDatastore: (RGTDatastore*) datastore;

/*! @description  Async download article content and call completionBlock after saving the article. An instance of RGTArticlesDownloder will be download articles one by one */
-(void) downloadArticleContent: (RGTArticle*) article withCompletion: (void(^)(RGTArticle* downloadedArticle)) completionBlock;

@end
