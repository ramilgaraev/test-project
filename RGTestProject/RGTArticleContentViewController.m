//
//  RGTArticleContentViewController.m
//  RGTestProject
//
//  Created by Ramil Garaev on 16.12.16.
//  Copyright © 2016 Ramil Garaev. All rights reserved.
//

#import "RGTArticleContentViewController.h"
#import "RGTArticle.h"
@import WebKit;
#import <SVProgressHUD/SVProgressHUD.h>

@interface RGTArticleContentViewController ()<WKNavigationDelegate>

@property (nonatomic) WKWebView* webView;

@end

@implementation RGTArticleContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[WKWebView alloc] initWithFrame: CGRectZero];
    [self.view addSubview: self.webView];
    [self.webView setNavigationDelegate: self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    self.webView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    if (self.article)
    {
        [SVProgressHUD setContainerView: self.webView];
        [SVProgressHUD showWithStatus:@"Загружаем.."];
        [self.webView loadRequest: [NSURLRequest requestWithURL: self.article.link]];
    }
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [SVProgressHUD dismiss];
}

@end
