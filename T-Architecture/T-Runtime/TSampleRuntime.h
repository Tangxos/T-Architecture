//
//  TSampleRuntime.h
//  T-Architecture
//
//  Created by T.J. on 15/6/14.
//  Copyright (c) 2015年 TJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSampleRuntime : NSObject

@property (nonatomic, assign) float myValue;

- (void)copyObject;
- (void)objectDispose;
- (void)setClass;
- (void)addMethodWithOneParam;
- (void)getClassAllMethod;
- (void)getInstanceVar;
- (void)setInstanceVar;
- (void)getVarType;
- (void)nameOfInstance;
- (void)methodExchange;
- (void)methodSetImplementation;
- (void)systemMethodExchange;

@end
