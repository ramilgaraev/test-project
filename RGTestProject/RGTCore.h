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

/*! @description Available articles */
@property (readonly) NSArray<RGTArticle*>* articles;


-(void) updateArticlesWithCompletionBlock: (void(^)(NSError* error, NSArray<RGTArticle*>* newArticles)) completionBlock;

@end
