//
//  SKQRCodeReadController.h
//  SuningEBuy
//
//  Created by  liukun on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "ZBarSDK.h"

@protocol SKQRValidateDelegate <NSObject>

@required
//验证通过
- (void)validateQRPassed;

@end

@interface SKQRCodeReadController : CommonViewController <ZBarReaderViewDelegate>
{
    ZBarReaderView  *_readerView;
}

@property (nonatomic, strong) ZBarReaderView *readerView;
@property (nonatomic,   copy) NSString *validateInfo;
@property (nonatomic, weak) id<SKQRValidateDelegate> delegate;

@end
