//
//  StoreServiceScrollView.h
//  SuningEBuy
//
//  Created by xingxianping on 14-2-13.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreDetailInfoDTO.h"
#import "StoreServiceDTO.h"

@protocol serviceButtonClickedDelegate <NSObject>

- (void)serviceButtonClickedDelegate:(int )tag;

@end

@interface StoreServiceScrollView : UIScrollView

@property (nonatomic, unsafe_unretained) id <serviceButtonClickedDelegate> buttonDelegate;

@property (nonatomic, strong) NSMutableArray *buttonArr;
@property (nonatomic, strong) NSMutableArray *dataArr;

- (void)creatServiceButtons:(int )num;

- (void)updateBtnWithArr:(NSMutableArray *)arr andIndex:(int)tag;


@end
