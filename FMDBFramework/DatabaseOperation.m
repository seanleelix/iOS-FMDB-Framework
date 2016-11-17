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

static DatabaseHelper *databaseHelper;
static DatabaseOperation *databaseOperation;

@interface DatabaseOperation()

@property (nonatomic, strong) FMDatabase *database;

@end

@implementation DatabaseOperation

+ (void) initializeInstance{
    if(databaseOperation == nil){
        databaseOperation = [DatabaseOperation new];
        databaseHelper = [DatabaseHelper new];
    }
}

+ (DatabaseOperation *)getDatabaseOperation{
    if(databaseOperation == nil){
        [self initializeInstance];
    }
    return databaseOperation;
}

- (FMDatabase *)openDatabase{
    if(self.database == nil){
        self.database = [databaseHelper getDatabase];
    }
    return self.database;
}

-(void) addPersonWithName:(NSString *)name andHeight:(float)height
{
    FMDatabase *database = [[DatabaseOperation getDatabaseOperation] openDatabase];
    
#ifdef DATABASE_SECRET_KEY
    if(DATABASE_SECRET_KEY.length)
        [database setKey:DATABASE_SECRET_KEY];
#endif
    
    NSString *query = [NSString stringWithFormat: @"INSERT INTO 'DemoTable' ('name', 'height') VALUES ('%@', '%f')", name, height];
    
    [database executeUpdate:query];
    
    [database close];
}

@end

