//
//  PayServiceHelpViewController.h
//  SuningEBuy
//
//  Created by 谢伟 on 12-9-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonViewController.h"

@interface PayServiceHelpViewController : CommonViewController <UITextViewDelegate>
{
    UITextView    *_payHelpInfoTextView;
}

@property (nonatomic, strong) UITextView   *payHelpInfoTextView;

@end
