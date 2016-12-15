//
//  RGTArticle.h
//  RGTestProject
//
//  Created by Ramil Garaev on 15.12.16.
//  Copyright © 2016 Ramil Garaev. All rights reserved.
//

#import <Foundation/Foundation.h>

/*! @description Class contains article from 4pda.ru */
@interface RGTArticle : NSObject

/*! @description  Unique identifier of the article */
@property (nonatomic) NSString* guid;
/*! @description A title of the article */
@property (nonatomic) NSString* title;
/*! @description Content in HTML format (just copy of HTML page) */
@property (nonatomic) NSString* htmlContent;

@end
