//
//  ToolBarButton.h
//  SuningEBuy
//
//  Created by wangrui on 11/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ToolBarButtonDelegate;

@interface ToolBarButton : UIButton
{
    
    UIView                      *_inputView;
    
    UIView                      *_inputAccessoryView;
    
    UIToolbar                   *_aboveViewToolBar;
    
    id<ToolBarButtonDelegate>   __weak _delegate;
    
}

@property (nonatomic,strong) UIView                     *inputView;
@property (nonatomic,strong) UIView                     *inputAccessoryView;
@property (nonatomic,strong) UIToolbar                  *aboveViewToolBar;
@property (nonatomic,weak) id<ToolBarButtonDelegate>  delegate;

@property (nonatomic,strong) UIColor *nomalBgColor;     //正常的背景颜色
@property (nonatomic,strong) UIColor *activeBgColor;    //弹出键盘的时候的颜色

@end

@protocol ToolBarButtonDelegate <NSObject>

@optional
- (void)cancelButtonClicked:(id)sender;
- (void)doneButtonClicked:(id)sender;
- (void)singleClickButton:(id)sender;

@end
