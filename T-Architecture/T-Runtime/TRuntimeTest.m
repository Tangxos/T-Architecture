//
//  TRuntimeTest.m
//  T-Architecture
//
//  Created by T.J. on 15/6/14.
//  Copyright (c) 2015年 TJ. All rights reserved.
//

#import "TRuntimeTest.h"

@interface TRuntimeTest ()
//{
//@private
//    float myValue;
//}

@end

@implementation TRuntimeTest

- (instancetype)init
{
    self = [super init];
    if (self) {
        myValue = 3.14;
        _str = @"hello";
    }
    return self;
}

- (void)testFun
{
    NSLog(@"this is test!");
    NSLog(@"myValue:%f", myValue);
}
@end


@implementation TNewRuntimeTest

- (void)newTestFun
{
    NSLog(@"this is new test!");
}

@end