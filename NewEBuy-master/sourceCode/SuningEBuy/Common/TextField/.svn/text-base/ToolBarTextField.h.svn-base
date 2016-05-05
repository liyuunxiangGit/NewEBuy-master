//
//  ToolBarTextField.h
//  SuningEBuy
//
//  Created by 刘坤 on 11-11-2.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ToolBarTextFieldDelegate <UITextFieldDelegate>

- (void)doneButtonClicked:(id)sender;

- (void)cancelButtonClicked:(id)sender;



@end

@interface ToolBarTextField : UITextField
{
    UIToolbar  *_keyboardDoneButtonBar;
    
    id <ToolBarTextFieldDelegate> __weak toolBarDelegate_;
}

@property (nonatomic, strong) UIToolbar *keyboardDoneButtonBar;

@property (nonatomic, weak) id <ToolBarTextFieldDelegate> toolBarDelegate;

@end
