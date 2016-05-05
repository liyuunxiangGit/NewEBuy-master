/**
 * Copyright 2009 Jeff Verkoeyen
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol ZXingOverlayViewDelegate;

@interface OverlayView : UIView {
	NSMutableArray *_points;
	UIButton *cancelButton;
  UILabel *instructionsLabel;
	id<ZXingOverlayViewDelegate> delegate;
	BOOL oneDMode;
  BOOL cancelEnabled;
  CGRect cropRect;
  NSString *displayedMessage;
  NSString *cancelButtonTitle;
    BOOL isScrolling;
}

@property (nonatomic, retain) NSMutableArray*  points;
@property (nonatomic, assign) id<ZXingOverlayViewDelegate> delegate;
@property (nonatomic, assign) BOOL oneDMode;
@property (nonatomic, assign) CGRect cropRect;
@property (nonatomic, copy) NSString *displayedMessage;
@property (nonatomic, retain) NSString *cancelButtonTitle;
@property (nonatomic, assign) BOOL cancelEnabled;

@property (nonatomic, retain) UIToolbar *toolBar;
@property (nonatomic, retain) CALayer *headerLabel;      //视图上面的影阴
@property (nonatomic, retain) CALayer *footerLabel;      //视图下面的影阴
@property (nonatomic, retain) CALayer *rightLabel;      //视图右面的影阴
@property (nonatomic, retain) CALayer *leftLabel;      //视图左面的影阴
@property (nonatomic, retain) UIImageView *scrollBar;   //滚动条


- (id)initWithFrame:(CGRect)theFrame cancelEnabled:(BOOL)isCancelEnabled oneDMode:(BOOL)isOneDModeEnabled showLicense:(BOOL)shouldShowLicense;
- (id)initWithFrame:(CGRect)theFrame cancelEnabled:(BOOL)isCancelEnabled oneDMode:(BOOL)isOneDModeEnabled;

- (void)setPoint:(CGPoint)point;

@end

@protocol ZXingOverlayViewDelegate
- (void)cancelled;
- (void)goToScanHistory;

@end
