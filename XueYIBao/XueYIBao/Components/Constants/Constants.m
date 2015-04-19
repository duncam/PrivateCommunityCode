//
//  Constants.m
//  AcerSmartHome
//
//  Created by arvin wang on 14/11/1.
//  Copyright (c) 2014年 Arvin Wang. All rights reserved.
//

#import "Constants.h"
#import <UIKit/UIKit.h>

@implementation Constants

+ (void)setStatusBarWhite:(UIViewController *)viewController
{
    if (iOS7) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }else{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }
    
}

/**
 *  隐藏tableView中多余的cell
 *
 *  @param tableView UITableView
 */
+ (void)setExtraCellLineHidden:(UITableView *)tableView
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

/**
 *  修改设置中tableView的样色
 *
 *  @param tableView UITableView
 */
+ (void)setSettingTableViewStyle:(UITableView *)tableView
{
    CGRect frame = tableView.bounds;
    frame.origin.y = -frame.size.height;
    UIView *boundsView = [[UIView alloc] initWithFrame:frame];
    CGFloat value = 242.0 / 255;
    boundsView.backgroundColor = [UIColor colorWithRed:value green:value blue:value alpha:1];
    [tableView addSubview:boundsView];
    if (!iOS7) {
        tableView.backgroundView = nil;
    }
}

/**
 *  修改iOS 7下tableView位iOS 6下grouped样式
 *
 *  @param tableView tableView
 *  @param cell      cell
 *  @param indexPath 索引
 */
+ (void)changeCellBorder:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        CGFloat cornerRadius = 3.f;
        cell.backgroundColor = UIColor.clearColor;
        
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        layer.strokeColor = [UIColor colorWithRed:209 / 255.0 green:212.0 / 255.0 blue:212.0 / 255.0 alpha:1.0].CGColor;
        CGMutablePathRef pathRef = CGPathCreateMutable();
        
        CGRect bounds = CGRectInset(cell.bounds, 0.0, 0);
        BOOL addLine = NO;
        if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
            CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
        } else if (indexPath.row == 0) {
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
            addLine = YES;
        } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
        } else {
            CGPathAddRect(pathRef, nil, bounds);
            addLine = YES;
        }
        layer.path = pathRef;
        CFRelease(pathRef);
        layer.fillColor = [UIColor whiteColor].CGColor;
        
        if (addLine == YES) {
            CALayer *lineLayer = [[CALayer alloc] init];
            CGFloat lineHeight = 1.f / [UIScreen mainScreen].scale;
            lineLayer.frame = CGRectMake(CGRectGetMinX(bounds), bounds.size.height-lineHeight, bounds.size.width, lineHeight);
            lineLayer.backgroundColor = [UIColor colorWithRed:226.0 / 255.0 green:226.0 / 255.0 blue:226.0 / 255.0 alpha:1.0].CGColor;
            [layer addSublayer:lineLayer];
        }
        
        UIView *testView = [[UIView alloc] initWithFrame:bounds];
        [testView.layer insertSublayer:layer atIndex:0];
        testView.backgroundColor = [UIColor clearColor];
        cell.backgroundView = testView;
    }
}


/**
 *  将null字符串转换为空
 *
 *  @param string 需要转换的字符串
 *
 *  @return 转换好的字符串
 */
+ (NSString *)dealString:(NSString *)string
{
    NSString *returnString = @"";
    if (string) {
        if ([string isKindOfClass:[NSString class]]) {
            if (string.length > 0 && ![string isEqualToString:@"(null)"]) {
                returnString = string;
            }
        } else if ([string isKindOfClass:[NSNumber class]]) {
            returnString = [NSString stringWithFormat:@"%@", string];
        } else {
            returnString = (NSString *)string;
        }
    }
    return returnString;
}

/**
 *  将字符串转换为整型
 *
 *  @param str 字符串
 *
 *  @return 整型值
 */
+ (int)convertToInt:(NSString *)str
{
    int strLength = 0;
    char *p = (char *)[str cStringUsingEncoding:NSUnicodeStringEncoding];
    int length = [str lengthOfBytesUsingEncoding:NSUnicodeStringEncoding];
    
    for (int i = 0; i < length ; i ++) {
        if (*p) {
            strLength ++;
        }
        p ++;
    }
    
    return strLength;
}

/**
 *  检车字符串中是否含有字母和数字之外的字符
 *
 *  @param str 需要检查的字符串
 *
 *  @return 是否含有其他字符
 */
+ (BOOL)isEnglishAndNumberCharacter:(NSString *)str
{
    BOOL b = NO;
    if (str == nil) {
        return NO;
    } else {
        for (int i = 0; i < str.length; i ++) {
            unichar ch = [str characterAtIndex:i];
            
            if (!((ch >= 48 && ch <=57) || (ch >= 65 && ch <= 90) || (ch >= 97 && ch <= 122))) {
                b = YES;
                break;
            }
        }
    }
    return b;
}

/**
 *  检车字符串中是否含有字母、数字和中文之外的字符
 *
 *  @param str 需要检查的字符串
 *
 *  @return 是否含有其他字符
 */
+ (BOOL)isEnglishAndNumberAndChiness:(NSString *)str
{
    BOOL b = NO;
    if (str == nil) {
        return b;
    } else {
        for (int i = 0; i < str.length; i ++) {
            unichar ch = [str characterAtIndex:i];
            if (!((ch >= 48 && ch <=57) || (ch >= 65 && ch <= 90) || (ch >= 97 && ch <= 122) || ch > 127)) {
                b = YES;
                break;
            }
        }
    }
    return b;
}

/**
 *  检车字符串中是否含有数字之外的字符
 *
 *  @param str 需要检查的字符串
 *
 *  @return 是否含有其他字符
 */
+ (BOOL)isNumberOfString:(NSString *)str
{
    BOOL b = NO;
    if (str == nil) {
        b = NO;
    } else {
        for (int i = 0; i < str.length; i ++) {
            unichar ch = [str characterAtIndex:i];
            if ( ch < 48 || ch > 57) {
                b = YES;
                break;
            }
        }
    }
    return b;
}

/**
 *  设置图片alpha
 *
 *  @param image 图片
 *  @param alpha alpha
 *
 *  @return 图片
 */
+ (UIImage *)setImageAlpha:(UIImage *)image alpha:(CGFloat)alpha
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage*) getBrighterImage:(UIImage *)originalImage withLevel:(NSString *)customLevel
{
    UIImage *brighterImage;
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:originalImage.CGImage];
    
    CIFilter *lighten = [CIFilter filterWithName:@"CIColorControls"];
    [lighten setValue:inputImage forKey:kCIInputImageKey];
    [lighten setValue:customLevel forKey:@"inputBrightness"];
    
    CIImage *result = [lighten valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    brighterImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return brighterImage;
}
+ (void)changePictureBorder:(UIImageView *)originalView color:(UIColor *)currentColor
{
    CALayer * layer = [originalView layer];
    layer.borderColor = [currentColor CGColor];
    layer.borderWidth = 1.0f;
}
@end
