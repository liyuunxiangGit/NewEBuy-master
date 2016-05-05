//
//  keyboardNumberPadReturnTextField.m
//  SuningEBuy
//
//  Created by 刘坤 on 11-11-2.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "keyboardNumberPadReturnTextField.h"

@implementation keyboardNumberPadReturnTextField

@synthesize doneButton = _doneButton;

@synthesize doneButtonDelegate = _doneButtonDelegate;


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(keyboardDidShow:) object:nil];
    
    TTVIEW_RELEASE_SAFELY(_doneButton);
        
}

- (UIButton *)doneButton
{
    if (_doneButton == nil)
    {
        _doneButton = [[UIButton alloc] init];
        
        
        
        _doneButton.adjustsImageWhenHighlighted = NO;
        
        _doneButton.hidden = NO;
        
        if (IOS7_OR_LATER)
        {
            _doneButton.frame = CGRectMake(0, 162.5, 105, 53);
            
            [_doneButton setTitle:L(@"Done") forState:UIControlStateNormal];
            [_doneButton setBackgroundImage:[UIImage imageWithColor:RGBCOLOR(181, 185, 189) size:_doneButton.size]
                                   forState:UIControlStateNormal];
            [_doneButton setBackgroundImage:[UIImage imageWithColor:RGBCOLOR(247, 247, 247) size:_doneButton.size]
                                   forState:UIControlStateHighlighted];
            [_doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            _doneButton.titleLabel.font = [UIFont systemFontOfSize:20];
        }
        else
        {
            _doneButton.frame = CGRectMake(0, 163, 106, 53);
            
            [_doneButton setImage:[UIImage imageNamed:@"DoneUp3.png"] forState:UIControlStateNormal];
            
            [_doneButton setImage:[UIImage imageNamed:@"DoneDown3.png"] forState:UIControlStateHighlighted];
        }
        
        [_doneButton addTarget:self action:@selector(doneButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneButton;
}

- (void)setup 
{
    self.keyboardType = UIKeyboardTypeNumberPad;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType
{
    [super setKeyboardType:UIKeyboardTypeNumberPad];
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self setup];
    }
    return self;
}

- (void)addDoneButtonToKeyboard
{
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    UIView* keyboard;
    CGRect appRect=[[UIScreen mainScreen] applicationFrame];
    for(int i=0; i<[tempWindow.subviews count]; i++) {
        keyboard = [tempWindow.subviews objectAtIndex:i];
        // keyboard view found; add the custom button to it
        if(([[keyboard description] hasPrefix:@"<UIPeripheralHostView"] == YES)||
           [[keyboard description] hasPrefix:@"<UIKeyboard"] == YES||
           [[keyboard description] hasPrefix:@"<UIInputSetContainerView"]==YES){//this line is for ios8
            CGRect frame = CGRectMake(0.0f, 162.0f, 106.0f, 53.0f);
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
                frame = CGRectMake(0, appRect.size.height-33, 106.0f, 53.0f);
            }
            [self.doneButton setFrame:frame];
            [keyboard addSubview:self.doneButton];
            
        }
    }
//    UIWindow *tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
//
//    for (UIView *keyboard in tempWindow.subviews)
//    {
//        if ([[keyboard description] hasPrefix:@"<UIPeripheral"])
//        {
//            for (UIView *keyView in [keyboard subviews])
//            {
//                if ([[keyView description] hasPrefix:@"<UIKeyboard"])
//                {
//                    [keyView addSubview:self.doneButton];
//                    
//                    return;
//                }
//            }
//        }
//        
//        if (IOS8_OR_LATER) {
//            if ([[keyboard description] hasPrefix:@"<UIInput"])
//            {
//                for (UIView *keyView in [keyboard subviews])
//                {
//                    if ([[keyView description] hasPrefix:@"<UIInputSetHostView"])
//                    {
//                        [keyView addSubview:self.doneButton];
//                        
//                        return;
//                    }
//                }
//            }
//
//        }
//
//     }
}

- (void)keyboardDidShow:(NSNotification *)note
{
    //create custom button
    if ([self isFirstResponder])
    {
        [self addDoneButtonToKeyboard];
    }
}

- (void)keyboardWillShow:(NSNotification *)note
{
    if (![self isFirstResponder] && self.doneButton.superview != nil)
    {
        [self.doneButton removeFromSuperview];
    }
}

- (void)doneButtonPressed:(id)sender
{
    if ([_doneButtonDelegate conformsToProtocol:@protocol(KeyboardDoneTappedDelegate)])
    {
        if ([_doneButtonDelegate respondsToSelector:@selector(doneTapped:)])
        {
            [_doneButtonDelegate doneTapped:(id)sender];
        }
        else
        {
            [self resignFirstResponder];
        }
    }
    else
    {
        [self resignFirstResponder];
    }
    
}

- (BOOL)canBecomeFirstResponder
{
    NSArray *windows = [[UIApplication sharedApplication] windows];
    
    if ([windows count] < 2) {
        
        if ([self.delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
            return [self.delegate textFieldShouldBeginEditing:self];
        }
        return YES;
    }
    
    [self performSelector:@selector(keyboardDidShow:) withObject:nil afterDelay:0.02];
//    
//    if (self.doneButton.superview == nil) {
//        [self addDoneButtonToKeyboard];
//    }
    
    if ([self.delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [self.delegate textFieldShouldBeginEditing:self];
    }
    return YES;
}

- (BOOL)canResignFirstResponder
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(keyboardDidShow:) object:nil];
    [self.doneButton removeFromSuperview];
    
    return YES;
}





@end
