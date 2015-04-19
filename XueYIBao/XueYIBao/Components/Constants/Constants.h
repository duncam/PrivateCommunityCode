//
//  Constants.h
//  AcerSmartHome
//
//  Created by arvin wang on 14/11/1.
//  Copyright (c) 2014年 Arvin Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

//各种常用颜色
#define kCommonBgColor [UIColor colorWithRed:9.0 / 255.0 green:138.0 / 255.0 blue:202.0 / 255.0 alpha:1.0]

#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

@interface Constants : NSObject

//状态栏颜色设置
+ (void)setStatusBarWhite:(UIViewController *)viewController;

//UITableView 常用方法
+ (void)setExtraCellLineHidden:(UITableView *)tableView;
+ (void)setSettingTableViewStyle:(UITableView *)tableView;
+ (void)changeCellBorder:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

//相应字符串转换
+ (NSString *)dealString:(NSString *)string;
+ (int)convertToInt:(NSString *)str;
+ (BOOL)isNumberOfString:(NSString *)str;
+ (BOOL)isEnglishAndNumberCharacter:(NSString *)str; // 是否含有中文字符
+ (BOOL)isEnglishAndNumberAndChiness:(NSString *)str;
+ (UIImage *)setImageAlpha:(UIImage *)image alpha:(CGFloat)alpha;

//图像亮度处理
+ (UIImage*) getBrighterImage:(UIImage *)originalImage withLevel:(NSString *)customLevel;
+ (void)changePictureBorder:(UIImageView *)originalView color:(UIColor *)currentColor;


@end
