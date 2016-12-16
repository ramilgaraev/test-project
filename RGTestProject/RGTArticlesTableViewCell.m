//
//  RGTArticlesTableViewCell.m
//  RGTestProject
//
//  Created by Ramil Garaev on 16.12.16.
//  Copyright © 2016 Ramil Garaev. All rights reserved.
//

#import "RGTArticlesTableViewCell.h"
#import "RGTArticle.h"

@interface RGTArticlesTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel* titleLabel;

@end

@implementation RGTArticlesTableViewCell

@synthesize article = _article;

-(void)fillWithArticle:(RGTArticle *)article
{
    _article = article;
    self.titleLabel.text = _article.title;
}

@end
