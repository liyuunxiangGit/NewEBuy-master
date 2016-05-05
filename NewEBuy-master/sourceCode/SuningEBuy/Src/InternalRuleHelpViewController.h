//
//  InternalRuleViewController.h
//  SuningEBuy
//
//  Created by 王 漫 on 13-2-19.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"

@interface InternalRuleHelpViewController : CommonViewController<UITextViewDelegate>
{
    UITextView  *_internalRuleTextView;
}

@property (nonatomic, strong) UITextView *internalRuleTextView;

@end
