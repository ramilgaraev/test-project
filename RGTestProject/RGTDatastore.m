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
#import "RGTArticle+RGTDatastore.h"

static NSString* RGT_DB_PATH = @"4pda.db";
static NSString* RGT_ARTICLES_COLLECTION_KEY = @"RGT_ARTICLES_COLLECTION_KEY";

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
        [transaction enumerateKeysAndObjectsInCollection: RGT_ARTICLES_COLLECTION_KEY
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
    [_connectionForWriting readWriteWithBlock:^(YapDatabaseReadWriteTransaction * _Nonnull transaction) {
        [transaction setObject: article
                        forKey: article.dbKey
                  inCollection: RGT_ARTICLES_COLLECTION_KEY
                  withMetadata: nil];
    }];
}

-(void)deleteArticle:(RGTArticle *)article
{
    [[NSFileManager defaultManager] removeItemAtPath: [self pathToSavedContentOfArticle: article]
                                               error: nil];
    [_connectionForWriting asyncReadWriteWithBlock: ^(YapDatabaseReadWriteTransaction * _Nonnull transaction) {
        [transaction removeObjectForKey: article.dbKey
                           inCollection: RGT_ARTICLES_COLLECTION_KEY];
    }];
}

-(void) deleteArticlesWithPublicationDateBefore: (NSDate*) date
{
    __block NSMutableArray* articles = [NSMutableArray array];
    [_connectionForReading readWithBlock: ^(YapDatabaseReadTransaction * _Nonnull transaction) {
        [transaction enumerateKeysAndObjectsInCollection: RGT_ARTICLES_COLLECTION_KEY
                                              usingBlock:^(NSString * key, RGTArticle* article, BOOL * stop) {
                                                  if ([article.publicationDate compare: date] == NSOrderedDescending)
                                                      [articles addObject: article];
                                              }];
        for (RGTArticle* article in articles) {
            [self deleteArticle: article];
        }
    }];
}

@end
