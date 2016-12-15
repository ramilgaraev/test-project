//
//  RGTError.m
//  RGTestProject
//
//  Created by Ramil Garaev on 15.12.16.
//  Copyright © 2016 Ramil Garaev. All rights reserved.
//

#import "NSError+RGTErrorCodes.h"

@implementation NSError(RGTErrorCodes)

+(NSError*) rgt_errorWithCode: (RGTErrorCode) errorCode
{
    NSError* error = [NSError errorWithDomain: @"RGTCommonErrorDomain"
                                        code: errorCode
                                    userInfo: nil];
    return error;
}

@end
