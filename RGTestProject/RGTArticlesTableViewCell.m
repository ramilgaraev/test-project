//
//  RGTArticlesTableViewCell.m
//  RGTestProject
//
//  Created by Ramil Garaev on 16.12.16.
//  Copyright © 2016 Ramil Garaev. All rights reserved.
//

#import "RGTArticlesTableViewCell.h"
#import "RGTArticle.h"
#import "RGTCore.h"

@interface RGTArticlesTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel* titleLabel;
@property (weak, nonatomic) IBOutlet UIButton* actionButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView* activity;

@end

@implementation RGTArticlesTableViewCell

-(void)fillWithArticle:(RGTArticle *)article
{
    self.titleLabel.text = article.title;
    if (article.state == RGTArticleStateIsDownloading)
    {
        [self.activity startAnimating];
        self.actionButton.hidden = YES;
    }
    else
    {
        [self.activity stopAnimating];
        self.actionButton.hidden = NO;
        if (article.state == RGTArticleStateIsNotDownloaded)
        {
            [self.actionButton setImage: [UIImage imageNamed: @"down"]
                               forState: UIControlStateNormal];
        }
        else
        {
            [self.actionButton setImage: [UIImage imageNamed: @"del"]
                               forState: UIControlStateNormal];
        }
    }
}

-(IBAction) changeStatusOfArticle
{
    [self.delegate actionButtonPressedInCell: self];
}

@end
