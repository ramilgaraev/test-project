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
#import <SVProgressHUD/SVProgressHUD.h>
#import "NSMutableArray+RGTAdditions.h"

@interface RGTArticlesTableViewController ()<RGTArticlesTableViewCellDelegate, RGTCoreDelegate>
{
    NSMutableArray<RGTArticle*>* _articles;
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
    [SVProgressHUD setCornerRadius: 8.0f];
    [SVProgressHUD setContainerView: self.view];
    _articles = [NSMutableArray array];
    [SVProgressHUD showWithStatus:@"Обновляем"];
    [RGTCore sharedInstance].delegate = self;
    [[RGTCore sharedInstance] updateArticlesWithCompletionBlock: ^(NSError *error, NSArray<RGTArticle*>* newArticles) {
        [self updateViewWithAddedArticles: newArticles];
        if (error)
        {
            [SVProgressHUD showErrorWithStatus:@"Проблемы со связью"];
            [SVProgressHUD dismissWithDelay: 1.5];
        }
        else
            [SVProgressHUD dismiss];
    }];
}

-(void) fetchNewArticles
{
    [[RGTCore sharedInstance] updateArticlesWithCompletionBlock: ^(NSError *error, NSArray<RGTArticle*>* newArticles) {
        if (!error)
        {
            [self updateViewWithAddedArticles: newArticles];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"Проблемы со связью"];
            [SVProgressHUD dismissWithDelay: 1.5];
        }
        [self.refreshControl endRefreshing];
    }];
}

-(void) updateViewWithAddedArticles: (NSArray<RGTArticle*>*) articles
{
    if (articles.count > 0)
    {
        [_articles rgt_addToTheHeadObjectsFromArray: articles];
        NSMutableArray* indexPathes = [NSMutableArray arrayWithCapacity: articles.count];
        for (NSInteger i = 0; i < articles.count; i++) {
            [indexPathes addObject: [NSIndexPath indexPathForRow: i
                                                       inSection: 0]];
        }
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths: indexPathes
                              withRowAnimation: UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
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
    cell.delegate = self;
    return cell;
}

-(RGTArticle*) articleInCell: (RGTArticlesTableViewCell*) cell
{
    NSUInteger index = [[self.tableView indexPathForCell: cell] row];
    return _articles[index];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    RGTArticleContentViewController* vc = (RGTArticleContentViewController*)segue.destinationViewController;
    vc.article = [self articleInCell: sender];
}


#pragma mark split view controller delegate methods

-(void)actionButtonPressedInCell:(RGTArticlesTableViewCell *)cell
{
     [[RGTCore sharedInstance] changeDownloadStateOfArticle:[self articleInCell: cell]];
}

#pragma mark split view controller delegate methods

-(BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController
{
    if (![(RGTArticleContentViewController*)secondaryViewController article])
        return YES;
    else
        return NO;
}

#pragma mark Core delegate methods

-(void)updatePresentationForArticle:(RGTArticle *)article
{
    NSArray<NSIndexPath*>* indexpaths = [self.tableView indexPathsForVisibleRows];
    NSUInteger articleIndex = [_articles indexOfObject: article];
    [_articles replaceObjectAtIndex: articleIndex
                         withObject: article];
    // check if need to redraw
    if (([indexpaths firstObject].row <= articleIndex) && (articleIndex <= [indexpaths lastObject].row ))
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadRowsAtIndexPaths: @[[NSIndexPath indexPathForRow: articleIndex
                                                                         inSection: 0]]
                                  withRowAnimation: UITableViewRowAnimationNone];
        });
}


@end
