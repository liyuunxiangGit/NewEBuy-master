//
//  ProductImageCell.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-2-10.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProductBasic.h"

#import "MyPageControl.h"
#import "ProductCommandDelegate.h"
#import "NJPageScrollView.h"
#import "NJPageScrollViewCell.h"
#import "SNTouchView.h"
#import "ProductUtil.h"


@interface ProductDetailImageViewCell : NJPageScrollViewCell
{
    SNBasicBlock touchedBlock;
}

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) EGOImageView *imageView;
@property (nonatomic, strong) UIImageView *powerFlagImageView;
@property (nonatomic, strong) UILabel *powerFlagLabel;




- (void)setTouchedBlock:(SNBasicBlock)block;

- (void)setImageUrl:(NSURL *)imageUrl powerFlag:(NSString *)powerFlgOrAmt atIndex:(NSInteger)index;

@end

@interface ProductImageCell : UITableViewCell <NJPageScrollViewDataSource,NJPageScrollViewDelegate>
{
    NSInteger currentPageNumber;
}

@property (nonatomic, weak) id <ProductCommandDelegate> delegate;

@property (nonatomic, strong) DataProductBasic *item;

@property (nonatomic, strong) DataProductBasic *productDTO;
@property (nonatomic, strong) NJPageScrollView *scrollView;

@property (nonatomic, strong) MyPageControl  *pageControl;

@property (nonatomic, strong) NSArray *smallImageUrls;

@property (nonatomic, strong) SNTouchView *scrollTouch;


+ (CGFloat)height;
- (void)imageTouched;
@end
