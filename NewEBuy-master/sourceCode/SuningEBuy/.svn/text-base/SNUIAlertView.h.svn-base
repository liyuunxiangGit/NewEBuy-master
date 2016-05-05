//
//  SNAlertView.h
//  SNFramework
//
//  Created by  liukun on 13-1-15.
//  Copyright (c) 2013年 liukun. All rights reserved.
//

#import <UIKit/UIKit.h>

#undef  AlertMessage
#define AlertMessage(__MSG)   [SNUIAlertView alertMessage:(__MSG) btnTitle:L(@"Ok") block:nil]

@interface SNUIAlertView : UIAlertView <UIAlertViewDelegate>
{
    NSMutableDictionary *_completeBlockMap;
}

/*!
 @abstract      弹出消息，带两个按钮，本别可以设置两个的回调方法
 */
+ (void)alertMessage:(NSString *)msg
         cancelTitle:(NSString *)cancelTitle
        confirmTitle:(NSString *)confirmTitle
         cancelBlock:(SNBasicBlock)cancelBlock
        confirmBlock:(SNBasicBlock)confirmBlock;

/*!
 @abstract      弹出消息，带一个按钮，一个回调方法
 */
+ (void)alertMessage:(NSString *)msg
            btnTitle:(NSString *)title
               block:(SNBasicBlock)block;

/*!
 @abstract      点击取消按钮的回调
 @discussion    如果你不想用代理的方式来进行回调，可使用该方法
 @param         block  点击取消后执行的程序块
 */
- (void)setCancelBlock:(SNBasicBlock)block;

/*!
 @abstract      点击确定按钮的回调
 @discussion    如果你不想用代理的方式来进行回调，可使用该方法
 @param         block  点击确定后执行的程序块
 */
- (void)setConfirmBlock:(SNBasicBlock)block;

/*!
 @abstract      点击按钮的回调
 @discussion    如果你不想用代理的方式来进行回调，可使用该方法
 @param         block  点击确定后执行的程序块
 @param         index  点击按钮的buttonIndex
 */
- (void)setCompleteBlock:(SNBasicBlock)block atIndex:(NSInteger)index;

@end
