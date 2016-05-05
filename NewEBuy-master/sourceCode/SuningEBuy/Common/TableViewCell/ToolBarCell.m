//
//  ToolBarCell.m
//  SuningEBuy
//
//  Created by 刘坤 on 11-11-3.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ToolBarCell.h"
#import "SNGraphics.h"

@implementation ToolBarCell

@synthesize toolBarDelegate = _toolBarDelegate;

@synthesize inputView = _inputView;

@synthesize inputAccessoryView = _inputAccessoryView;

@synthesize keyboardDoneButtonBar = _keyboardDoneButtonBar;

@synthesize canBecomeFirstRes = canBecomeFirstRes_;

@synthesize customLabel = _customLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier inputView:(UIView *)aInputView
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.inputView = aInputView;
        
        self.inputAccessoryView = self.keyboardDoneButtonBar;
        
        self.canBecomeFirstRes = YES;
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.inputAccessoryView = self.keyboardDoneButtonBar;
        
        self.canBecomeFirstRes = YES;
    }
    return self;
}

- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_inputView);
    
    TT_RELEASE_SAFELY(_inputAccessoryView);
    
    TT_RELEASE_SAFELY(_keyboardDoneButtonBar);
    
    TT_RELEASE_SAFELY(_customLabel);
    
}

- (UIToolbar*)keyboardDoneButtonBar{
    
    if(!_keyboardDoneButtonBar){
        
        _keyboardDoneButtonBar= [[UIToolbar alloc] init];
        
        if (IOS7_OR_LATER) {
            _keyboardDoneButtonBar.barStyle = UIBarStyleDefault;
        }else{
            _keyboardDoneButtonBar.barStyle = UIBarStyleBlackTranslucent;
        }
        _keyboardDoneButtonBar.tintColor = nil;
        
        [_keyboardDoneButtonBar sizeToFit];
        
        
        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] 
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
                                      target:nil
                                      action:nil];
        
        
        
        UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc] 
                                          initWithTitle:L(@"Cancel")
                                          style:UIBarButtonItemStyleBordered 
                                          target:self
                                          action:@selector(cancelButtonClicked:)];
        
        UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] 
                                        initWithTitle:L(@"Ok")
                                        style:UIBarButtonItemStyleBordered 
                                        target:self
                                        action:@selector(doneButtonClicked:)];
        
        [_keyboardDoneButtonBar setItems:[NSArray arrayWithObjects:cancelButton,flexItem,doneButton, nil]];
        
    }
    
    return _keyboardDoneButtonBar;
}

- (UILabel *)customLabel
{
    if (!_customLabel) {
        _customLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 4, 100, 36)];
        _customLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        _customLabel.textColor = [UIColor dark_Gray_Color];
        _customLabel.backgroundColor = [UIColor clearColor];
    }
    return _customLabel;
}

- (BOOL)canBecomeFirstResponder
{
    return self.canBecomeFirstRes;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"1010101"], nil]];
    if (canBecomeFirstRes_)
    {
        [self becomeFirstResponder];
    }
    else
    {
        if ([_toolBarDelegate conformsToProtocol:@protocol(ToolBarCellDelegate)])
        {
            if ([_toolBarDelegate respondsToSelector:@selector(singleSelectCell:)])
            {
                [_toolBarDelegate singleSelectCell:self];
            }
        }
    }
    
}


#pragma mark -
#pragma mark Tool Bar Button Delegate Methods

- (void)doneButtonClicked:(id)sender
{
    if ([_toolBarDelegate conformsToProtocol:@protocol(ToolBarCellDelegate)])
    {
        if ([_toolBarDelegate respondsToSelector:@selector(doneClicked:)])
        {
            [_toolBarDelegate doneClicked:self];
        }
    }else{
        [self resignFirstResponder];
    }
}

- (void)cancelButtonClicked:(id)sender
{
    if ([_toolBarDelegate conformsToProtocol:@protocol(ToolBarCellDelegate)])
    {
        if ([_toolBarDelegate respondsToSelector:@selector(cancelClicked:)])
        {
            [_toolBarDelegate cancelClicked:(id)sender];
        }
    }
    [self resignFirstResponder];
}

@end
