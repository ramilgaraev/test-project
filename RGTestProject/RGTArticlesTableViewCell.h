//
//  RGTArticlesTableViewCell.h
//  RGTestProject
//
//  Created by Ramil Garaev on 16.12.16.
//  Copyright © 2016 Ramil Garaev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  RGTArticle;
@class RGTArticlesTableViewCell;

@protocol RGTArticlesTableViewCellDelegate

-(void) actionButtonPressedInCell: (RGTArticlesTableViewCell*) cell;

@end

@interface RGTArticlesTableViewCell : UITableViewCell

@property (nonatomic, weak) id<RGTArticlesTableViewCellDelegate> delegate;

-(void) fillWithArticle: (RGTArticle*) article;

@end
