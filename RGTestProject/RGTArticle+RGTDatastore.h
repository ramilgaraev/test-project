//
//  RGTArticle+RGTDatastore.h
//  RGTestProject
//
//  Created by Ramil Garaev on 19.12.16.
//  Copyright © 2016 Ramil Garaev. All rights reserved.
//

#import "RGTArticle.h"

/*! @description  Category for article contains db routine  */
@interface RGTArticle(RGTDataStore)

/*! @description  Returns unique key for store */
-(NSString*) dbKey;

@end
