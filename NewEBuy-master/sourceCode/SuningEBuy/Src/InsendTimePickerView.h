//
//  InsendTimePickerView.h
//  SuningEBuy
//
//  Created by 孔斌 on 14-11-6.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InsendTimeDTO.h"

@interface InsendTimePickerView : UIPickerView<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong)   NSString            *selectDateStr;

@property (nonatomic, strong)   NSString            *dateStr;

@property (nonatomic, strong)   NSString            *timeStr;

@property (nonatomic, strong)   MergeDataOptionDTO  *dateOptionDto;

- (id)initWithBaseDto:(MergeDataOptionDTO *)dateDto;

@end
