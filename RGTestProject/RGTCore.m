//
//  RGTCore.m
//  RGTestProject
//
//  Created by Ramil Garaev on 15.12.16.
//  Copyright © 2016 Ramil Garaev. All rights reserved.
//

#import "RGTCore.h"

@interface RGTCore()
{
    NSMutableArray<RGTArticle*>* _articles;
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
        _articles = [NSMutableArray new];
    }
    return self;
}

-(NSArray<RGTArticle *> *)articles
{
    return [NSArray arrayWithArray: _articles];
}

-(void) updateArticlesWithCompletionBlock: (void(^)(BOOL success)) completionBlock
{
#warning todo
}

@end
