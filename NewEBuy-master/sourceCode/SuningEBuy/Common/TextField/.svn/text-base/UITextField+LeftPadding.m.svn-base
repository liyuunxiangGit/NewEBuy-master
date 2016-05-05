//
//  UITextField+LeftPadding.m
//  SuningEBuy
//
//  Created by wangrui on 11/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UITextField+LeftPadding.h"


@implementation LeftPaddingField
@synthesize keyboardDoneButtonView = _keyboardDoneButtonView;
@synthesize leftPaddingDelegate = _leftPaddingDelegate;


@synthesize borderRect = _borderRect;
@synthesize textRect = _textRect;
@synthesize placeholderRect = _placeholderRect;
@synthesize editingRect = _editingRect;
@synthesize clearButtonRect = _clearButtonRect;
@synthesize leftViewRect = _leftViewRect;
@synthesize rightViewRect = _rightViewRect;



- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_keyboardDoneButtonView);
    
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        [self initData];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self initData];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self initData];
    }
    return self;
}

- (void)initData{
    self.borderRect = CGRectZero;
    self.textRect = CGRectZero;
    self.placeholderRect = CGRectZero;
    self.editingRect = CGRectZero;
    self.clearButtonRect = CGRectZero;
    self.leftViewRect = CGRectZero;
    self.rightViewRect = CGRectZero;
}

#pragma mark -  Override Rect Set Methods
#pragma mark    重载方法，设置各个控件的位置实现
- (CGRect)borderRectForBounds:(CGRect)bounds{
    
    CGRect arect = [super rightViewRectForBounds:bounds];
    
    if (CGRectEqualToRect(self.borderRect, CGRectZero)) {
        
        return  arect;
        
    }else{
        
        return CGRectInset(bounds, 5, 0);
    }
}

- (CGRect)textRectForBounds:(CGRect)bounds{
    
    CGRect arect = [super textRectForBounds:bounds];
    
    if (CGRectEqualToRect(self.textRect, CGRectZero)) {
        
        return  arect;
        
    }else{
        
        return CGRectInset(bounds, 5, 0);
    }
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    
    CGRect arect = [super placeholderRectForBounds:bounds];
    
    if (CGRectEqualToRect(self.placeholderRect, CGRectZero)) {
        
        return  arect;
        
    }else{
        
        return self.placeholderRect;
    }
}

- (CGRect)editingRectForBounds:(CGRect)bounds{
    
    CGRect arect = [super editingRectForBounds:bounds];
    
    if (CGRectEqualToRect(self.editingRect, CGRectZero)) {
        
        return  arect;
        
    }else{
        
        return self.editingRect;
    }
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds{
    
    CGRect arect = [super clearButtonRectForBounds:bounds];
    
    if (CGRectEqualToRect(self.clearButtonRect, CGRectZero)) {
        
        return  arect;
        
    }else{
        
        return self.clearButtonRect;
        
    }
    
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    
    CGRect arect = [super leftViewRectForBounds:bounds];
    
    if (CGRectEqualToRect(self.leftViewRect, CGRectZero)) {
        
        return  arect;
        
    }else{
        
        return self.leftViewRect;
    }
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds{
    
    CGRect arect = [super rightViewRectForBounds:bounds];
    
    if (CGRectEqualToRect(self.rightViewRect, CGRectZero)) {
        
        return  arect;
        
    }else{
        return self.rightViewRect;
    }
}

- (void)displayBorder:(BOOL)visible
{
    if (visible)
    {
        
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.cornerRadius = 6;
        self.layer.masksToBounds = YES;
    }
}

- (void)displayToolBar:(BOOL)visible
{
    
    if (visible)
    {
        self.inputAccessoryView = self.keyboardDoneButtonView;
    }
    
}

- (UIToolbar *)keyboardDoneButtonView
{
    if (!_keyboardDoneButtonView)
    {
        _keyboardDoneButtonView = [[UIToolbar alloc] init];
        
        _keyboardDoneButtonView.barStyle = UIBarStyleBlack;
        
        _keyboardDoneButtonView.translucent = YES;
        
        [_keyboardDoneButtonView sizeToFit];
        
        
        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:nil
                                                                                   action:nil];
        
        
        
//        UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc] initWithTitle:L(@"Cancel")
//                                                                          style:UIBarButtonItemStyleBordered
//                                                                         target:self
//                                                                         action:@selector(cancelClicked:)] 
//                                         autorelease];
        
//        cancelButton.tintColor = RGBCOLOR(33, 95, 221);
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:L(@"Ok")
                                                                        style:UIBarButtonItemStyleBordered
                                                                       target:self
                                                                       action:@selector(doneClicked:)];
        
//        doneButton.tintColor = RGBCOLOR(33, 95, 221);
        
        [_keyboardDoneButtonView setItems:[NSArray arrayWithObjects:flexItem,doneButton, nil]];
        
        
    }
    
    return _keyboardDoneButtonView;
    
}

- (void)doneClicked:(id)sender
{
    if ([self.leftPaddingDelegate respondsToSelector:@selector(doneButtonClicked:)]) 
    {
        [self.leftPaddingDelegate doneButtonClicked:sender];
    }
    
    [self resignFirstResponder];
}

- (void)cancelClicked:(id)sender
{
    if ([self.leftPaddingDelegate respondsToSelector:@selector(cancelButtonClicked:)]) 
    {
        [self.leftPaddingDelegate cancelButtonClicked:sender];
    }
    
    [self resignFirstResponder];
}

@end


