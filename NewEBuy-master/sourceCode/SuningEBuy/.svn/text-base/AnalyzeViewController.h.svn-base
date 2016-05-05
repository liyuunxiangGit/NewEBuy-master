//
//  AnalyzeViewController.h
//  SuningEBuy
//
//  Created by chupeng on 14-11-13.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpMsgCtrl.h"
@interface AnalyzeViewController : UIViewController<HttpMsgCtrlDelegate>
+ (AnalyzeViewController *)sharedAnalyzeViewController;

- (void)showAnalyzeView;
- (IBAction)hide:(id)sender;
- (IBAction)clearAllLog:(id)sender;
- (IBAction)copyToPasteBoard:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *logTextView;
@end
