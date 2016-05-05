//
//  ReceiveInsendTimeCell.m
//  SuningEBuy
//
//  Created by 孔斌 on 14-11-8.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ReceiveInsendTimeCell.h"

@implementation ReceiveInsendTimeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (UILabel *)tipLbl
{
    if (!_tipLbl) {
        _tipLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 12, 85, 20)];
        _tipLbl.backgroundColor = [UIColor clearColor];
        _tipLbl.font = [UIFont systemFontOfSize:13];
        _tipLbl.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_tipLbl];
    }
    return _tipLbl;
}

- (UIButton *)alertBtn
{
    if (!_alertBtn) {
        _alertBtn = [[UIButton alloc] initWithFrame:CGRectMake(280, 7, 30, 30)];
        _alertBtn.backgroundColor = [UIColor clearColor];
        [_alertBtn setImage:[UIImage imageNamed:@"ShopCart_tixing.png"] forState:UIControlStateNormal];
        [_alertBtn addTarget:self action:@selector(alertButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _alertBtn.hidden = YES;
        [self.contentView addSubview:_alertBtn];
    }
    return _alertBtn;
}

- (UILabel *)alertLbl
{
    if (!_alertLbl) {
        _alertLbl = [[UILabel alloc] initWithFrame:CGRectMake(125, 12, 175, 20)];
        _alertLbl.backgroundColor = [UIColor clearColor];
        _alertLbl.font = [UIFont systemFontOfSize:13];
        _alertLbl.textAlignment = NSTextAlignmentRight;
        _alertLbl.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_alertLbl];
    }
    return _alertLbl;
}

- (UILabel *)timeLbl
{
    if (!_timeLbl) {
        _timeLbl = [[UILabel alloc] initWithFrame:CGRectMake(105, 30, 190, 20)];
        _timeLbl.backgroundColor = [UIColor clearColor];
        _timeLbl.font = [UIFont systemFontOfSize:13];
        _timeLbl.textAlignment = NSTextAlignmentRight;
        _timeLbl.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_timeLbl];
    }
    return _timeLbl;
}

- (ToolBarButton *)timeBtn
{
    if (!_timeBtn) {
        _timeBtn = [[ToolBarButton alloc] initWithFrame:CGRectMake(280, 7, 30, 30)];
        _timeBtn.delegate = self;
        _timeBtn.backgroundColor = [UIColor clearColor];
        [_timeBtn setImage:[UIImage imageNamed:@"ShopCart_rili.png"] forState:UIControlStateNormal];
        _timeBtn.inputView = self.insendPickerView;
        _timeBtn.hidden = YES;
        [self.contentView addSubview:_timeBtn];
    }
    return _timeBtn;
}

- (UIImageView *)arrowImg
{
    if (!_arrowImg) {
        _arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(298, 17, 6, 11)];
        _arrowImg.backgroundColor = [UIColor clearColor];
        _arrowImg.image = [UIImage imageNamed:@"arrow_right_gray.png"];
        _arrowImg.hidden = YES;
        [self.contentView addSubview:_arrowImg];
    }
    return _arrowImg;
}

- (InsendTimePickerView *)insendPickerView
{
    if (!_insendPickerView) {
        _insendPickerView = [[InsendTimePickerView alloc] initWithBaseDto:nil];
    }
    return _insendPickerView;
}

- (void)setBaseDto:(MergeDataOptionDTO *)dto WithType:(InsendTimeType)type WithShipMode:(ShipMode)shipMode isFromReceiveView:(BOOL)isFromReceive
{
    if (self.mergeDto != dto) {
        self.mergeDto = dto;
    }
    self.insendPickerView.dateOptionDto = dto;
    if (shipMode == ShipModeSuningSend) {
        self.tipLbl.text = @"预计送达时间";
    }
    else
    {
        self.tipLbl.text = @"预计到货时间";
    }
    
    if (isFromReceive == YES) {
        if (type == InsendTimeDefault) {
            self.arrowImg.hidden    = YES;
            
            self.timeLbl.hidden     = YES;
            if (shipMode == ShipModeSelfTake) {
                self.alertLbl.text = IsStrEmpty(dto.delDateText) ? dto.defDelDateStr : dto.delDateText;
                self.alertBtn.hidden    = NO;
                self.timeBtn.hidden     = YES;
            }
            else
            {
                self.alertLbl.text      = dto.defDelDateStr;
                self.timeBtn.hidden     = NO;
                self.alertBtn.hidden    = YES;
            }
            
            self.alertLbl.frame = CGRectMake(105, 12, 170, 20);
        }
        else if (type == InsendTimeSplit)
        {
            self.arrowImg.hidden    = NO;
            self.timeBtn.hidden     = YES;
            self.timeLbl.hidden     = YES;
            self.alertLbl.text      = @"最快时间分开送达";
            self.alertLbl.frame = CGRectMake(105, 12, 190, 20);
        }
        else if (type == InsendTimeTogether)
        {
            self.arrowImg.hidden    = NO;
            self.timeBtn.hidden     = YES;
            self.timeLbl.hidden     = NO;
            if (shipMode == ShipModeSelfTake) {
                self.alertLbl.text  = @"所有商品一起送达至门店";
            }else
            {
                self.alertLbl.text  = @"所有商品一起送达";
            }
            self.timeLbl.text       = dto.defDelDateStr;
            self.alertLbl.frame = CGRectMake(105, 12, 190, 20);
        }
    }
    else
    {
        self.arrowImg.hidden    = YES;
        
        self.timeLbl.hidden     = YES;
        if (shipMode == ShipModeSelfTake) {
            self.alertLbl.text = IsStrEmpty(dto.delDateText) ? dto.defDelDateStr : dto.delDateText;
            self.alertBtn.hidden    = YES;
            self.timeBtn.hidden     = YES;
            self.alertLbl.frame = CGRectMake(105, 12, 200, 20);
        }
        else
        {
            self.alertLbl.text      = dto.defDelDateStr;
            self.timeBtn.hidden     = NO;
            self.alertBtn.hidden    = YES;
            self.alertLbl.frame = CGRectMake(105, 12, 170, 20);
        }
    }
}

+ (CGFloat)height:(InsendTimeType)type isFromReceiveView:(BOOL)isFromReceive
{
    if (NO == isFromReceive) {
        return 44;
    }
    if (type == InsendTimeTogether) {
        return 62;
    }
    return 44;
}

- (void)doneButtonClicked:(id)sender
{
    self.alertLbl.text = self.insendPickerView.selectDateStr;
    self.mergeDto.defDelDateStr = self.insendPickerView.selectDateStr;
    
    NSString *orderitemsId      = nil;
    for (ItemsVoDTO *item in self.mergeDto.itemsVoList) {
        //判断默认安装时间是否为空
        if (!IsStrEmpty(item.defInstallDate)) {
            if (IsStrEmpty(orderitemsId)) {
                orderitemsId = item.orderitemsId;
            }
            else
            {
                orderitemsId = [NSString stringWithFormat:@"%@,%@",orderitemsId,item.orderitemsId];
            }
        }
    }
    
    if (!IsStrEmpty(orderitemsId)) {
        if (_delegate && [_delegate respondsToSelector:@selector(selectSendTimeWith:dateStr:timeStr:)]) {
            [_delegate selectSendTimeWith:orderitemsId dateStr:self.insendPickerView.dateStr timeStr:self.insendPickerView.timeStr];
        }
    }
    
}

- (void)alertButtonAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(takeSelfAlertShow)]) {
        [_delegate takeSelfAlertShow];
    }
}

@end
