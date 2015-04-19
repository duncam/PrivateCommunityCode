//
//  Singleton.h
//  AcerSmartHome
//
//  Created by arvin wang on 14/11/1.
//  Copyright (c) 2014年 Arvin Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MBProgressHUD;
@class FMDatabase;

@interface Singleton : NSObject
{
    MBProgressHUD *_loadingView;
    NSUInteger _loadingCount;
}
+ (instancetype)shareInstance;
- (void)startLoading;
- (void)startLoadingInView:(UIView *)view;
- (void)stopLoading;
- (void)forceStopLoading;

@end
