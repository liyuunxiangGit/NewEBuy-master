//
//  RightSideToolView.h
//  SuningEBuy
//
//  Created by liukun on 14-2-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SNUIView.h"

@interface RightSideToolView : SNUIView
{
}
@property (nonatomic, strong) UIImageView *screenshotImageView;
@property (nonatomic, strong) UIButton *badgeValueBtn;

+ (instancetype)sharedInstance;
+ (void)show;
+ (void)hideWithCompletion:(void(^)(void))block;
-(void)showBadgeValue:(NSString*)number;
@end
