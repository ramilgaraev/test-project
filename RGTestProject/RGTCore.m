//
//  RGTCore.m
//  RGTestProject
//
//  Created by Ramil Garaev on 15.12.16.
//  Copyright © 2016 Ramil Garaev. All rights reserved.
//

#import "RGTCore.h"
#import "RGTAPIClient.h"

@interface RGTCore()
{
    NSDate* _lastArticlesFetchingDate;
}

@end

@implementation RGTCore

@synthesize articles = _articles;

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
    }
    return self;
}

-(NSArray<RGTArticle *> *)articles
{
    return _articles;
}

-(void) updateArticlesWithCompletionBlock: (void(^)(NSError* error)) completionBlock
{
    [RGTAPIClient fetchNewArticlesSince: _lastArticlesFetchingDate
                         withCompletion:^(NSArray<RGTArticle *> * _Nullable fetchedArticles, NSError * _Nullable error) {
                             if (error)
                             {
                                 completionBlock(error);
                             }
                             else
                             {
                                 if (fetchedArticles.count > 0)
                                 {
                                     NSMutableArray* newArray = [NSMutableArray arrayWithArray: fetchedArticles];
                                     [newArray addObjectsFromArray: _articles];
                                     _articles = [NSArray arrayWithArray: newArray];
                                     _lastArticlesFetchingDate = [NSDate date];
                                     completionBlock(nil);
                                 }
                             }

                         }];
}

@end
