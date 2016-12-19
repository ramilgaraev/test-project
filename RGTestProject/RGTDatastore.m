//
//  RGTDatastore.m
//  RGTestProject
//
//  Created by Ramil Garaev on 16.12.16.
//  Copyright © 2016 Ramil Garaev. All rights reserved.
//

#import "RGTDatastore.h"
#import <YapDatabase/YapDatabase.h>
#import "RGTArticle.h"

static NSString* RGT_DB_PATH = @"4pda.db";
static NSString* RGT_ARTICLES_KEY = @"RGT_ARTICLES_KEY";

@interface RGTDatastore()
{
    YapDatabaseConnection* _connectionForReading;
    YapDatabaseConnection* _connectionForWriting;
}

@end

@implementation RGTDatastore

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        YapDatabase* database = [[YapDatabase alloc] initWithPath: [[self documentsDirPath] stringByAppendingPathComponent: RGT_DB_PATH]];
        _connectionForReading = [database newConnection];
        _connectionForWriting = [database newConnection];
    }
    return self;
}


-(NSString*) pathToSavedContentOfArticle: (RGTArticle*) article
{
    NSMutableString* fileName = [NSMutableString stringWithString: [[article.link absoluteString] substringFromIndex: 15]];
    [fileName replaceOccurrencesOfString: @"/"
                              withString: @""
                                 options: NSCaseInsensitiveSearch
                                   range: NSMakeRange(0, fileName.length)];
    [fileName appendString:@".html"];
    NSString* path =  [[self documentsDirPath] stringByAppendingPathComponent: fileName];
    return path;
}

-(NSString*) documentsDirPath
{
    NSString* documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return documentsDir;
}

-(NSArray< RGTArticle*>*) savedArticles
{
    __block NSMutableArray* articles = [NSMutableArray array];
    [_connectionForReading readWithBlock:^(YapDatabaseReadTransaction * transaction) {
        [transaction enumerateKeysAndObjectsInCollection: RGT_ARTICLES_KEY
                                              usingBlock:^(NSString * _Nonnull key, id  _Nonnull object, BOOL * _Nonnull stop) {
                                                  [articles addObject: object];
                                              }
                                              withFilter: nil];
    }];
    return articles;
}

-(void) saveArticle: (RGTArticle*) article withContentData: (NSData*) contentData
{
    [contentData writeToFile: [self pathToSavedContentOfArticle: article]
                  atomically: YES];
    NSError* error;
    NSString* key = [article.link absoluteString];
    [_connectionForWriting readWriteWithBlock:^(YapDatabaseReadWriteTransaction * _Nonnull transaction) {
        [transaction setObject: article
                        forKey: key
                  inCollection: RGT_ARTICLES_KEY
                  withMetadata: nil];
    }];
}

-(void) deleteArticlesWithPublicationDateBefore: (NSDate*) date
{

}

@end
