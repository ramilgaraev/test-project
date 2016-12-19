//
//  NSMutableArray+RGTAdditions.m
//  RGTestProject
//
//  Created by Ramil Garaev on 18.12.16.
//  Copyright © 2016 Ramil Garaev. All rights reserved.
//

#import "NSMutableArray+RGTAdditions.h"

@implementation NSMutableArray(RGTAdditions)

-(void)rgt_addToTheHeadObjectsFromArray:(NSArray *)array
{
    NSIndexSet* indexSet = [NSIndexSet indexSetWithIndexesInRange: NSMakeRange(0, array.count)];
    [self insertObjects: array
              atIndexes: indexSet];
}

@end
