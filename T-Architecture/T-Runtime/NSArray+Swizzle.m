//
//  NSArray+Swizzle.m
//  T-Architecture
//
//  Created by T.J. on 15/6/15.
//  Copyright (c) 2015年 TJ. All rights reserved.
//

#import "NSArray+Swizzle.h"

@implementation NSArray (Swizzle)

- (id)myLastObject
{
    id ret = [self myLastObject];
    NSLog(@"this is my last Object method!");
    
    return ret;
}

@end
