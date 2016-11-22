//
//  DatabaseOperation.m
//  FMDBTest
//
//  Created by Sean Lee on 30/3/2016.
//  Copyright © 2016 Sean Lee. All rights reserved.
//

#import "DatabaseOperation.h"
#import "DatabaseHelper.h"
#import "FMDatabase.h"
#import "DatabaseConstants.h"

@interface DatabaseOperation()

@property (nonatomic, strong) FMDatabase *database;
@property (nonatomic, strong) DatabaseHelper *databaseHelper;

@end

@implementation DatabaseOperation

+ (DatabaseOperation *)sharedDatabaseOperation{
    static dispatch_once_t once;
    static DatabaseOperation *databaseOperation;
    dispatch_once(&once, ^ { databaseOperation = [[DatabaseOperation alloc] init]; });
    return databaseOperation;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.databaseHelper = [[DatabaseHelper alloc] init];
        self.database = [self.databaseHelper getDatabase];
        
#ifdef DATABASE_SECRET_KEY
        if(DATABASE_SECRET_KEY.length)
            [database setKey:DATABASE_SECRET_KEY];
#endif
    }
    return self;
}

-(void) addPersonWithName:(NSString *)name andHeight:(float)height
{
    
    NSString *query = [NSString stringWithFormat: @"INSERT INTO 'DemoTable' ('name', 'height') VALUES ('%@', '%f')", name, height];
    
    [self.database executeUpdate:query];
    
    [self.database close];
}

@end

