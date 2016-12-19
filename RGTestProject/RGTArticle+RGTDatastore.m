//
//  RGTArticle+RGTDatastore.m
//  RGTestProject
//
//  Created by Ramil Garaev on 19.12.16.
//  Copyright © 2016 Ramil Garaev. All rights reserved.
//

#import "RGTArticle+RGTDatastore.h"
#import "RGTArticle.h"

@implementation RGTArticle(RGTDataStore)

-(NSString *) dbKey
{
    return  [self.link absoluteString];
}

@end
