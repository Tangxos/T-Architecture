//
//  ViewController.m
//  T-Architecture
//
//  Created by T.J. on 15/6/13.
//  Copyright (c) 2015年 TJ. All rights reserved.
//

#import "ViewController.h"
#import "TSampleRuntime.h"
#import "TRuntimeTest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    TSampleRuntime *sampleRuntime = [TSampleRuntime new];
//    [sampleRuntime copyObject];
//    [sampleRuntime objectDispose];
//    [sampleRuntime setClass];
//    [sampleRuntime addMethodWithOneParam];
//    [sampleRuntime getClassAllMethod];
//    [sampleRuntime getInstanceVar];
//    [sampleRuntime setInstanceVar];
//    [sampleRuntime getVarType];
//    [sampleRuntime nameOfInstance];
//    [sampleRuntime methodExchange];
//    [sampleRuntime methodSetImplementation];

//    TRuntimeTest *runtimeTest = [TRuntimeTest new];
//    [runtimeTest testFun];

    [sampleRuntime systemMethodExchange];
    NSArray *array = @[@0, @1, @2, @3];
    NSLog(@"last array:%@", [array lastObject]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
