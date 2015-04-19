//
//  Singleton.m
//  AcerSmartHome
//
//  Created by arvin wang on 14/11/1.
//  Copyright (c) 2014年 Arvin Wang. All rights reserved.
//

#import "Singleton.h"
#import "Singleton.h"
#import "MBProgressHUD.h"
#import "FMDatabase.h"

@implementation Singleton

// 获取单例
+ (instancetype)shareInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
	return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark Loading

// 网络开始
- (void)startLoading
{
    [self startLoadingInView:[UIApplication sharedApplication].delegate.window];
}

- (void)startLoadingInView:(UIView *)view
{
    _loadingCount++;
    
    if (_loadingCount == 1) {
        _loadingView = [[MBProgressHUD alloc] initWithView:view];
        _loadingView.labelText = @"正在加载...";
        [_loadingView show:YES];
    } else {
        [_loadingView removeFromSuperview];
    }
    [view addSubview:_loadingView];
}

// 网络结束
- (void)stopLoading
{
    if (_loadingCount > 0) {
        _loadingCount--;
    }
    
    // 当没有请求web的时候才移除loading
    if (_loadingCount == 0) {
        [_loadingView hide:YES];
        [_loadingView removeFromSuperview];
        _loadingView = nil;
        
        // 网络加载标志停止转动
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}

- (void)forceStopLoading
{
    _loadingCount = 0;
    [self stopLoading];
}

@end
