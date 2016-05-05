//
//  OSMessageLabel.h
//  CoreTextDemo
//
//  Created by liukun on 14-8-22.
//  Copyright (c) 2014年 bluebox. All rights reserved.
//

#import <UIKit/UIKit.h>

SN_EXTERN NSArray *getEmoticonList(void);

@class OSMessageLabel;
@protocol OSMessageLabelDelegate <NSObject>

@optional
- (void)messageLabel:(OSMessageLabel *)label didSelectLinkWithUrl:(NSURL *)url;

@end

@interface OSMessageLabel : UILabel

@property (readwrite, nonatomic, copy) NSAttributedString *attributedText;
@property (nonatomic, weak) id<OSMessageLabelDelegate> delegate;

+ (NSAttributedString *)generateAttributedString:(NSString *)message;
+ (CGSize)sizeWithAttributedString:(NSAttributedString *)attributedString maxWidth:(CGFloat)width;

@end
