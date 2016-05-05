//
//  EmbedReaderViewController.h
//  SuningEBuy
//
//  Created by 刘坤 on 11-12-13.
//  Copyright (c) 2011年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
#import "CommonViewController.h"
#import "InterestProductService.h"
#import "DataProductBasic.h"
#import "InnerProductDTO.h"
#import "ProductDetailService.h"

@protocol SNReaderDelegate;

@interface SNReaderViewController : CommonViewController <ZBarReaderViewDelegate,ProductDetailServiceDelegate>
{
    ZBarReaderView      *_readerView;
    
    UIToolbar           *_toolBar;
    
    id<SNReaderDelegate> __weak _snDelegate;
    /*
     date:2012-4-20
     auther:zhaofk
     reason:2.0优化：条形码少秒增加4个lable
     */
    CALayer                *_headerLabel;
    CALayer                *_footerLabel;
    CALayer                *_rightLabel;
    CALayer                *_leftLabel;
    
    BOOL                isServicePay_;
    
    CGFloat             scrollBarPosY;
}

@property (nonatomic, strong) ZBarReaderView *readerView;

@property (nonatomic, strong) UIToolbar *toolBar;

@property (nonatomic, weak) id<SNReaderDelegate> snDelegate;
/*
 date:2012-4-20
 auther:zhaofk
 reason:2.0优化：修改条形码少秒界面
 */
@property (nonatomic, strong) CALayer *headerLabel;      //视图上面的影阴
@property (nonatomic, strong) CALayer *footerLabel;      //视图下面的影阴
@property (nonatomic, strong) CALayer *rightLabel;      //视图右面的影阴
@property (nonatomic, strong) CALayer *leftLabel;      //视图左面的影阴

@property (nonatomic, assign) BOOL isServicePay;

@property (nonatomic, strong) UIImageView *scrollBar;   //滚动条

@property (nonatomic, strong) NSTimerHelper *timer;
@property (nonatomic, assign) CGRect cropRect;

- (void)startReader;
- (void)stopReader;

@end


@protocol SNReaderDelegate <NSObject>

- (void)readerView:(ZBarReaderView *)view didReadSymbols:(ZBarSymbolSet *)symbols fromImage: (UIImage *) image;

//废弃
//- (void)manualInput;
@optional
- (void)goToScanHistory;

- (void)snReaderDismissByCancel;

@end