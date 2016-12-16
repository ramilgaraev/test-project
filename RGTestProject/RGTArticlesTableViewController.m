//
//  RGTArticlesTableViewController.m
//  RGTestProject
//
//  Created by Ramil Garaev on 15.12.16.
//  Copyright © 2016 Ramil Garaev. All rights reserved.
//

#import "RGTArticlesTableViewController.h"
#import "RGTCore.h"
#import "RGTArticle.h"
#import "RGTArticleContentViewController.h"
#import "RGTArticlesTableViewCell.h"

@interface RGTArticlesTableViewController ()
{
    NSArray<RGTArticle*>* _articles;
}

@end

@implementation RGTArticlesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.splitViewController.delegate = self;
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget: self
                            action: @selector(fetchNewArticles)
                  forControlEvents: UIControlEventValueChanged];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    [[RGTCore sharedInstance] updateArticlesWithCompletionBlock: ^(NSError *error) {
        if (!error)
        {
            _articles = [[RGTCore sharedInstance] articles];
            [self.tableView reloadData];
        }
    }];
}


-(void) fetchNewArticles
{
    [[RGTCore sharedInstance] updateArticlesWithCompletionBlock: ^(NSError *error) {
        if (!error)
        {
            _articles = [[RGTCore sharedInstance] articles];
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
        }
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _articles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RGTArticlesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"RGTArticleCell"
                                                            forIndexPath: indexPath];
    [cell fillWithArticle: _articles[indexPath.row]];
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    RGTArticleContentViewController* vc = (RGTArticleContentViewController*)segue.destinationViewController;
    vc.article = [(RGTArticlesTableViewCell*)sender article];
}


#pragma mark 

-(BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController
{
    return YES;
}


@end
