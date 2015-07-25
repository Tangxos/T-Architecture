//
//  TRuntimeTest.h
//  T-Architecture
//
//  Created by T.J. on 15/6/14.
//  Copyright (c) 2015年 TJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRuntimeTest : NSObject
{
    @private
    float myValue;
}

@property (nonatomic, strong) NSString *str;

- (void)testFun;

@end

@interface TNewRuntimeTest : NSObject

- (void)newTestFun;

@end