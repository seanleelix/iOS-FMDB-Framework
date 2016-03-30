//
//  ViewController.m
//  FMDBFramework
//
//  Created by Sean Lee on 30/3/2016.
//  Copyright © 2016 Sean Lee. All rights reserved.
//

#import "ViewController.h"
#import "DatabaseOperation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DatabaseOperation *databaseOperation = [[DatabaseOperation alloc] init];
    [databaseOperation addPersonWithName:@"test" height:1.7f];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
