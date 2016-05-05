//
//  DVCircle.h
//  SuningEBuy
//
//  Created by leo on 14-4-9.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonView.h"

@interface DVCircle : CommonView
{
    CAShapeLayer *arcLayer;
//    BOOL isClick;//是否点击监听按钮

}
-(void)drawLineAnimation;
-(void)resetarclayer;
@end
