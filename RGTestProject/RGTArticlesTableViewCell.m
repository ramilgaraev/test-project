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

@synthesize article = _article;

-(void)fillWithArticle:(RGTArticle *)article
{
    _article = article;
    [self.activity stopAnimating];
    self.actionButton.hidden = NO;
    UIImage* img = [UIImage imageNamed: _article.isDonwloaded ? @"del" : @"down"];
    [self.actionButton setImage: img
                       forState: UIControlStateNormal];
    self.titleLabel.text = _article.title;
}


-(IBAction) changeStatusOfArticle
{
    if (_article.isDonwloaded)
    {
        // delete
        [[RGTCore sharedInstance] deleteArticle: _article];
        [self.actionButton setImage: [UIImage imageNamed: @"down"]
                           forState: UIControlStateNormal];
    }
    else
    {
        // download
        [self.activity startAnimating];
        self.actionButton.hidden = YES;
        [[RGTCore sharedInstance] downloadArticle: _article
                                   withCompletion:^(RGTArticle *downloadedArticle) {
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           if ([downloadedArticle isEqual: _article])
                                           {
                                               [self.activity stopAnimating];
                                               self.actionButton.hidden = NO;
                                               [self.actionButton setImage: [UIImage imageNamed: @"del"]
                                                                  forState: UIControlStateNormal];
                                           }
                                       });
                                   }];
    }
}

@end
