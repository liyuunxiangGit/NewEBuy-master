//
//  OrderDetailNumbersView.h
//  SuningLottery
//
//  Created by yangbo on 4/12/13.
//  Copyright (c) 2013 suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LotteryOrderDetailDto.h"
#import "BallSelectConstant.h"

//投注内容视图 显示投注的号码列表
@interface OrderDetailNumbersView : UIView

//string 所选的号码字符串    type  彩票类型
- (id)initWithNumbersString:(NSString *)ccodes multiple:(NSString *)multiple lotteryType:(LotteryType)type;

@end
