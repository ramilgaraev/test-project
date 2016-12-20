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
/*! @description  Save given article */
-(void) saveArticle: (RGTArticle*) article withContentData: (NSData*) contentData;
/*! @description  Delete given article */
-(void) deleteArticle: (RGTArticle*) article;
/*! @description  Delete old articles  */
-(void) deleteArticlesWithPublicationDateBefore: (NSDate*) date;
/*! @description  Returns path to file with saved artivle content  */
-(NSString*) pathToSavedContentOfArticle: (RGTArticle*) article;

@end
