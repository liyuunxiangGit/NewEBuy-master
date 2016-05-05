//
//  UITextField+LeftPadding.h
//  SuningEBuy
//
//  Created by wangrui on 11/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeftPaddingTextFieldDelegate;

@interface LeftPaddingField : UITextField

@property (nonatomic, strong)  UIToolbar        *keyboardDoneButtonView;

@property (nonatomic, weak)  id<LeftPaddingTextFieldDelegate> leftPaddingDelegate;

//- (CGRect)textRectForBounds:(CGRect)bounds;
//
//- (CGRect)editingRectForBounds:(CGRect)bounds;

- (void)displayBorder:(BOOL)visible;

- (void)displayToolBar:(BOOL)visible;

- (void)initData;

/*!
 @abstract    设置textfield的边框的rect
 @discussion  如果设置则显示系统默认的位置，重写了- (CGRect)borderRectForBounds:(CGRect)bounds方法。
 */
@property (nonatomic, assign) CGRect  borderRect;

/*!
 @abstract    设置textfield的text的rect
 @discussion  如果设置则显示系统默认的位置，重写了- (CGRect)textRectForBounds:(CGRect)bounds方法。
 */
@property (nonatomic, assign) CGRect  textRect;

/*!
 @abstract    设置textfield的placeholder的rect
 @discussion  如果设置则显示系统默认的位置，重写了- (CGRect)placeholderRectForBounds:(CGRect)bounds方法。
 */
@property (nonatomic, assign) CGRect  placeholderRect;

/*!
 @abstract    设置textfield的editing的rect
 @discussion  如果设置则显示系统默认的位置，重写了- (CGRect)editingRectForBounds:(CGRect)bounds方法。
 */
@property (nonatomic, assign) CGRect  editingRect;

/*!
 @abstract    设置textfield的clearButton的rect
 @discussion  如果设置则显示系统默认的位置，重写了- (CGRect)editingRectForBounds:(CGRect)bounds方法。
 */
@property (nonatomic, assign) CGRect  clearButtonRect;

/*!
 @abstract    设置textfield的leftView的rect
 @discussion  如果设置则显示系统默认的位置，重写了- (CGRect)leftViewRectForBounds:(CGRect)bounds方法。
 */
@property (nonatomic, assign) CGRect  leftViewRect;

/*!
 @abstract    设置textfield的rightView的rect
 @discussion  如果设置则显示系统默认的位置，重写了- (CGRect)rightViewRectForBounds:(CGRect)bounds方法。
 */
@property (nonatomic, assign) CGRect  rightViewRect;


@end

@protocol LeftPaddingTextFieldDelegate <NSObject>

- (void)doneButtonClicked:(id)sender;

- (void)cancelButtonClicked:(id)sender;

@end
