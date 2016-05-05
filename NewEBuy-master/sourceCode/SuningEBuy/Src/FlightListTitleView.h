//
//  FlightListTitleView.h
//  SuningEBuy
//
//  Created by shasha on 12-5-22.
//  Copyright (c) 2012年 warmshare_shasha@sina.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlightListTitleView : UIView

@property(nonatomic,strong)UILabel  *timeLabel;
@property(nonatomic,strong)UILabel  *cityLabel;
@property(nonatomic,strong)NSString *timeStr;
@property(nonatomic,strong)NSString *cityStr;
@property(nonatomic,strong)UIImageView  *lineImage;


@end
