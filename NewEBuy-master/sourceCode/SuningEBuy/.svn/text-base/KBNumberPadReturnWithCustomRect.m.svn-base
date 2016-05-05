//
//  KBNumberPadReturnWithCustomRect.m
//  SuningEBuy
//
//  Created by shasha on 12-10-9.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "KBNumberPadReturnWithCustomRect.h"

@interface KBNumberPadReturnWithCustomRect()

- (void)initData;

@end

@implementation KBNumberPadReturnWithCustomRect
@synthesize borderRect = _borderRect;
@synthesize textRect = _textRect;
@synthesize placeholderRect = _placeholderRect;
@synthesize editingRect = _editingRect;
@synthesize clearButtonRect = _clearButtonRect;
@synthesize leftViewRect = _leftViewRect;
@synthesize rightViewRect = _rightViewRect;


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
        
        return self.borderRect;
    }
}

- (CGRect)textRectForBounds:(CGRect)bounds{
    
    CGRect arect = [super textRectForBounds:bounds];
    
    if (CGRectEqualToRect(self.textRect, CGRectZero)) {
        
        return  arect;
        
    }else{
        
        return self.textRect;
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
@end
