//
//  RGTDatastore.h
//  RGTestProject
//
//  Created by Ramil Garaev on 16.12.16.
//  Copyright © 2016 Ramil Garaev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RGTArticle;

/*! @description Class implements storing routine */
@interface RGTDatastore : NSObject

/*! @description  Returns all saved articles */
-(NSArray< RGTArticle*>*) savedArticles;
/*! @description  Save givwn article */
-(void) saveArticle: (RGTArticle*) article withContentData: (NSData*) contentData;
/*! @description  Delete givwn article */
-(void) deleteArticle: (RGTArticle*) article;
/*! @description  Delete old articles  */
-(void) deleteArticlesWithPublicationDateBefore: (NSDate*) date;

-(NSString*) pathToSavedContentOfArticle: (RGTArticle*) article;

@end
