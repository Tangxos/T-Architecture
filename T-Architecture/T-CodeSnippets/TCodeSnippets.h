//
//  TCodeSnippets.h
//  T-Architecture
//
//  Created by T.J. on 15/7/20.
//  Copyright (c) 2015年 TJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TCodeSnippets : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) NSInteger age; /**< 小明的年龄 */

/** 做些什么呢？*/
- (void)doSomething;

@end
