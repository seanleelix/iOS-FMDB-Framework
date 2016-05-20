//
//  DatabaseHelper.h
//  FMDBTest
//
//  Created by Sean Lee on 30/3/2016.
//  Copyright © 2016 Sean Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabase;

@interface DatabaseHelper : NSObject

-(FMDatabase *)getDatabase;

@end
