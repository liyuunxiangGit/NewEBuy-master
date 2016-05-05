//
//  ReceiveInsendTimeCell.h
//  SuningEBuy
//
//  Created by 孔斌 on 14-11-8.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SNUITableViewCell.h"
#import "ToolBarButton.h"
#import "PayFlowService.h"
#import "InsendTimePickerView.h"
#import "InsendTimeDTO.h"

@protocol ReceiveInsendTimeCellDelegate;

@interface ReceiveInsendTimeCell : SNUITableViewCell<ToolBarButtonDelegate>

@property (nonatomic, weak)   id<ReceiveInsendTimeCellDelegate> delegate;

@property (nonatomic, strong) UILabel       *tipLbl;

@property (nonatomic, strong) UIButton      *alertBtn;

@property (nonatomic, strong) UILabel       *alertLbl;

@property (nonatomic, strong) UILabel       *timeLbl;

@property (nonatomic, strong) ToolBarButton *timeBtn;

@property (nonatomic, strong) UIImageView   *arrowImg;

@property (nonatomic, strong) InsendTimePickerView  *insendPickerView;

@property (nonatomic, strong) MergeDataOptionDTO    *mergeDto;

+ (CGFloat)height:(InsendTimeType)type isFromReceiveView:(BOOL)isFromReceive;

- (void)setBaseDto:(MergeDataOptionDTO *)dto WithType:(InsendTimeType)type WithShipMode:(ShipMode)shipMode isFromReceiveView:(BOOL)isFromReceive;

@end

@protocol ReceiveInsendTimeCellDelegate <NSObject>

- (void)selectSendTimeWith:(NSString *)orderitemsId dateStr:(NSString *)dateStr timeStr:(NSString *)timeStr;

- (void)takeSelfAlertShow;

@end
