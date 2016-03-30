//
//  DatabaseHelper.m
//  FMDBTest
//
//  Created by Sean Lee on 30/3/2016.
//  Copyright © 2016 Sean Lee. All rights reserved.
//

#import "DatabaseHelper.h"
#import "DatabaseConstants.h"
#import "FMDatabase.h"
#import "sqlite3.h"

@implementation DatabaseHelper

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:DATABASE_NAME];
        
        NSLog(@"DB PATH:%@", dbPath);
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL dbExist = [fileManager fileExistsAtPath:dbPath];
        
        if(dbExist){
            if(DATABASE_VERSION != [self queryDatabaseVersion:(_database = [FMDatabase databaseWithPath:dbPath])])
                [self upgradeDatabase: self.database];
        }else{
            _database = [self createDatabase:fileManager databasePath:dbPath];
        }
    }
    return self;
}

-(FMDatabase *) createDatabase:(NSFileManager *) fileManager databasePath:(NSString *)dbPath{
    
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DATABASE_NAME];
    
    #ifdef DATABASE_SECRET_KEY
    
    NSLog(@"createDatabase with sqlcipher");
    
    const char* sqlQ = [[NSString stringWithFormat:@"ATTACH DATABASE '%@' AS encrypted KEY '%@';", dbPath, DATABASE_SECRET_KEY] UTF8String];
    sqlite3 *unencrypted_DB;
    if (sqlite3_open([databasePathFromApp UTF8String], &unencrypted_DB) == SQLITE_OK) {
        sqlite3_exec(unencrypted_DB, sqlQ, NULL, NULL, NULL);
        sqlite3_exec(unencrypted_DB, "SELECT sqlcipher_export('encrypted');", NULL, NULL, NULL);
        sqlite3_exec(unencrypted_DB, "DETACH DATABASE encrypted;", NULL, NULL, NULL);
        sqlite3_close(unencrypted_DB);
    }
    else {
        sqlite3_close(unencrypted_DB);
        NSAssert1(NO, @"Failed to open database with message '%s'.", sqlite3_errmsg(unencrypted_DB));
    }
    #else
    NSLog(@"createDatabase");
    
    [fileManager copyItemAtPath:databasePathFromApp toPath:dbPath error:nil];
    #endif
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    
    [self upgradeDatabase: database];
    [self updateDatabaseVersion: database];
    
    return database;
}

-(void) upgradeDatabase:(FMDatabase *) database{
    
    NSLog(@"upgradeDatabase");
    
    switch (DATABASE_VERSION) {
        case 3:{
            
        }
        case 2:{
        
        }
        default:
            break;
    }
    
    [self updateDatabaseVersion: database];
}

-(int)queryDatabaseVersion:(FMDatabase *) database{

    int databaseVersion;
    [database open];
    
    #ifdef DATABASE_SECRET_KEY
    if(DATABASE_SECRET_KEY.length)
        [database setKey:DATABASE_SECRET_KEY];
    #endif
    
    FMResultSet *result = [database executeQuery:@"PRAGMA user_version"];
    if([result next]){
        databaseVersion = [result intForColumn:@"user_version"];
    }
    
    [database close];
    return databaseVersion;
}

-(void)updateDatabaseVersion:(FMDatabase *) database{

    [database open];
    
    #ifdef DATABASE_SECRET_KEY
    if(DATABASE_SECRET_KEY.length)
        [database setKey:DATABASE_SECRET_KEY];
    #endif
    
    [database executeUpdate:[NSString stringWithFormat:@"PRAGMA user_version = %d", DATABASE_VERSION]];
    
    [database close];
}
    
@end
