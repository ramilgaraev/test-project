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

@interface RGTArticlesTableViewController ()
{
    NSArray<RGTArticle*>* _articles;
}

@end

@implementation RGTArticlesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _articles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"RGTArticleCell"
                                                            forIndexPath: indexPath];
    RGTArticle* article = _articles[indexPath.row];
    cell.textLabel.text = article.title;
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
