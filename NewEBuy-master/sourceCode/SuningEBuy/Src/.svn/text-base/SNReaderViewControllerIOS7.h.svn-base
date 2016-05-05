//
//  SNReaderViewControllerIOS7.h
//  SuningEBuy
//
//  Created by liukun on 14-8-25.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonViewController.h"

@protocol SNReaderDelegateIOS7;
/**
 *  IOS7之后AVFoundation支持二维码和条码扫描，基于性能等考虑，ios7使用AVFoundation
 */
@interface SNReaderViewControllerIOS7 : CommonViewController

@property (nonatomic, weak) id<SNReaderDelegateIOS7> delegate;

- (void)startReader;
- (void)stopReader;

@end


@protocol SNReaderDelegateIOS7 <NSObject>

- (void)readerController:(SNReaderViewControllerIOS7 *)readerController
           didScanResult:(NSString *)result isTwoDCode:(BOOL)isTwoDCode;
- (void)readerControllerScanHistoryButtonTapped:(SNReaderViewControllerIOS7 *)readerController;
- (void)readerControllerCancelButtonTapped:(SNReaderViewControllerIOS7 *)readerController;

@end