//
//  RGTArticlesTableViewCell.h
//  RGTestProject
//
//  Created by Ramil Garaev on 16.12.16.
//  Copyright © 2016 Ramil Garaev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  RGTArticle;

@interface RGTArticlesTableViewCell : UITableViewCell

@property (nonatomic, readonly) RGTArticle* article;

-(void) fillWithArticle: (RGTArticle*) article;

@end
