//
//  TSampleViewController.m
//  T-Architecture
//
//  Created by T.J. on 15/6/13.
//  Copyright (c) 2015年 TJ. All rights reserved.
//

#import "TSampleViewController.h"

@interface TSampleViewController ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation TSampleViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.button];
    // ...
    [self layoutPageSubviews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // ...
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    // ...
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    // set and update view frame
    // 在viewDidLoad中开一个方法去设置view的约束
}

// ...

#pragma mark - UITableViewDelegate
// methods

#pragma mark - CustomDelegate
// methods

#pragma mark - event response
- (void)clickButton:(UIButton *)button
{

}

#pragma mark - public methods
//public methods

#pragma mark - private methods
- (void)layoutPageSubviews
{
    // 增加约束条件
//    [self.view addConstraints:XXX];
}

#pragma mark - getters & setters
- (UIButton *)button
{
    if (!_button) {
        _button = [[UIButton alloc] init];
    }
    return _button;
}

@end
