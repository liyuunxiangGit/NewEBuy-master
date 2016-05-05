//
//  keyboardNumberPadReturnTextField.h
//  SuningEBuy
//
//  Created by 刘坤 on 11-11-2.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KeyboardDoneTappedDelegate <NSObject>

@optional
- (void)doneTapped:(id)sender;

@end

@interface keyboardNumberPadReturnTextField : SNUITextField
{
    UIButton *_doneButton;
    
    id <KeyboardDoneTappedDelegate> __weak _doneButtonDelegate;
}

@property (nonatomic, strong) UIButton *doneButton;

@property (nonatomic, weak) id <KeyboardDoneTappedDelegate> doneButtonDelegate;

@end

