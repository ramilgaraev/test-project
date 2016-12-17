//
//  RGTArticle.h
//  RGTestProject
//
//  Created by Ramil Garaev on 15.12.16.
//  Copyright © 2016 Ramil Garaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

/*! @description Class contains article from 4pda.ru */
@interface RGTArticle : MTLModel

/*! @description  Creation date of the article */
@property (nonatomic) NSDate* publicationDate;
/*! @description A title of the article */
@property (nonatomic) NSString* title;
/*! @description A link of the article */
@property (nonatomic) NSURL* link;
/*! @description HTML content of the article */
@property (nonatomic) NSString* content;

@end
