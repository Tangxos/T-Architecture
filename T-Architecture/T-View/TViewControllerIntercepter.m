//
//  TViewControllerIntercepter.m
//  T-Architecture
//
//  Created by T.J. on 15/6/13.
//  Copyright (c) 2015年 TJ. All rights reserved.
//

#import "TViewControllerIntercepter.h"
#import <Aspects/Aspects.h>

@implementation TViewControllerIntercepter

+ (void)load
{
    /*
        + (void)load 会在应用启动的时候自动被runtime调用，通过调用这个方法来实现最小的对业务方的“代码入侵”
     */
    [super load];
    [TViewControllerIntercepter sharedInstance];
}

+ (instancetype)sharedInstance
{
    static TViewControllerIntercepter *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TViewControllerIntercepter alloc] init];
    });

    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        /*
            方法拦截
         */
        
        [UIViewController aspect_hookSelector:@selector(loadView) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo) {
            [self loadView:[aspectInfo instance]];
        } error:NULL];
    }
    
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo, BOOL animated) {
        [self viewWillAppear:animated viewController:[aspectInfo instance]];
    } error:NULL];
    
    return self;
}

#pragma mark - fake methods
- (void)loadView:(UIViewController *)viewController
{
    // 可以使用这个方法进行打日志，初始化基础业务相关的内容
    NSLog(@"[%@ loadView]", [viewController class]);
}

- (void)viewWillAppear:(BOOL)animated viewController:(UIViewController *)viewController
{
    // 可以使用这个方法进行打日志，初始化基础业务相关的内容
    NSLog(@"[%@ viewWillAppear:%@]", [viewController class], animated ? @"YES" : @"NO");
}

@end
