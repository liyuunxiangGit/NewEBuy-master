//
//  ActivityProductImageCell.h
//  SuningEBuy
//
//  Created by shasha on 12-4-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProductBasic.h"

#import "ProductCommandDelegate.h"
#import "NJPageScrollView.h"
#import "NJPageScrollViewCell.h"

@interface ActivityProductImageCell : UITableViewCell
<NJPageScrollViewDelegate, NJPageScrollViewDataSource>
{
    NSInteger currentPageNumber;
}

@property (nonatomic, weak) id <ProductCommandDelegate> delegate;
@property (nonatomic, strong) NJPageScrollView   *scrollView;
@property (nonatomic, strong) UIPageControl  *pageControl;
@property (nonatomic, strong) UIView      *backView;
@property (nonatomic, strong) DataProductBasic *item;



+ (CGFloat)height;

@end