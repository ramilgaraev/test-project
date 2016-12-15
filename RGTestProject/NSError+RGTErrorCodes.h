//
//  RGTError.h
//  RGTestProject
//
//  Created by Ramil Garaev on 15.12.16.
//  Copyright © 2016 Ramil Garaev. All rights reserved.
//

#import <Foundation/Foundation.h>

/*! @description Custom error codes. */
typedef NS_ENUM(NSInteger, RGTErrorCode)
{
    RGTErrorCodeConnectionProblems
};

/*! @description Category adds convinience method for  creating an error with custom error code. */
@interface NSError(RGTErrorCodes)

/*! @description Returns an error with given code. */
+(NSError*) rgt_errorWithCode: (RGTErrorCode) errorCode;

@end
