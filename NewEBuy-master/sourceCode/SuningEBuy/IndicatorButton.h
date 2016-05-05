//
//  IndicatorButton.h
//  SuningEBuy
//
//  Created by shasha on 12-5-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndicatorButton : UIButton


@property(nonatomic,strong)UIImageView *indicatorIconView;
@property(nonatomic,strong)UIImage     *upIcon;
@property(nonatomic,strong)UIImage     *downIcon;

@property(nonatomic,strong)UIImage     *selectedBackgroudImage;
@property(nonatomic,strong)UIImage     *unselectedBackgroudImage;

@property(nonatomic,assign)BOOL         isSelected;
@property(nonatomic,assign)BOOL         isIndicatorUp;


@end
