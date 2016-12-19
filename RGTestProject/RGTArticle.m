//
//  RGTArticle.m
//  RGTestProject
//
//  Created by Ramil Garaev on 15.12.16.
//  Copyright © 2016 Ramil Garaev. All rights reserved.
//

#import "RGTArticle.h"

@implementation RGTArticle

-(BOOL) isEqual:(id)object
{
    return ([object isKindOfClass: [RGTArticle class]]
            && [self.publicationDate isEqualToDate: ((RGTArticle*)object).publicationDate]);
}

@end
