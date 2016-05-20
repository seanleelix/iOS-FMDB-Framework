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

@property (nonatomic, strong, readonly) DatabaseHelper *databaseHelper;

@end

@implementation DatabaseOperation

- (instancetype)init
{
    self = [super init];
    if (self) {
        _databaseHelper = [[DatabaseHelper alloc] init];
    }
    return self;
}

-(void) addPersonWithName:(NSString *)name andHeight:(float)height
{
    FMDatabase *database = [self.databaseHelper getDatabase];
    
    #ifdef DATABASE_SECRET_KEY
    if(DATABASE_SECRET_KEY.length)
        [database setKey:DATABASE_SECRET_KEY];
    #endif
    
    NSString *query = [NSString stringWithFormat: @"INSERT INTO 'DemoTable' ('name', 'height') VALUES ('%@', '%f')", name, height];
    
    [database executeUpdate:query];
    
    [database close];
}

@end

