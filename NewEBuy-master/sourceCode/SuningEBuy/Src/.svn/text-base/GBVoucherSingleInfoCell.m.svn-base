//
//  GBVoucherSingleInfoCell.m
//  SuningEBuy
//
//  Created by xingxuewei on 13-3-1.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBVoucherSingleInfoCell.h"

#define kOffsetContentLeft(isRefund) self.isRefund?50:15

#define kOffsetContentHight         30
#define kOffsetContentLength        60

#define kOffsetHight                28
#define kOffsetLength(isRefund) self.isRefund?195:230

@implementation GBVoucherSingleInfoCell

@synthesize voucherCodeContentLbl = _voucherCodeContentLbl;
@synthesize voucherCodeLbl = _voucherCodeLbl;
@synthesize usefulLifeContentLbl = _usefulLifeContentLbl;
@synthesize usefulLifeLbl = _usefulLifeLbl;
@synthesize voucherStateContentLbl = _voucherStateContentLbl;
@synthesize voucherStateLbl = _voucherStateLbl;
@synthesize voucherPasswordContentLbl = _voucherPasswordContentLbl;
@synthesize voucherPasswordLbl = _voucherPasswordLbl;

@synthesize item = _item;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_voucherCodeContentLbl);
    TT_RELEASE_SAFELY(_voucherCodeLbl);
    TT_RELEASE_SAFELY(_usefulLifeContentLbl);
    TT_RELEASE_SAFELY(_usefulLifeLbl);
    TT_RELEASE_SAFELY(_voucherStateContentLbl);
    TT_RELEASE_SAFELY(_voucherStateLbl);
    TT_RELEASE_SAFELY(_voucherPasswordContentLbl);
    TT_RELEASE_SAFELY(_voucherPasswordLbl);
    TT_RELEASE_SAFELY(_item);
    TT_RELEASE_SAFELY(_lineView);
    
    TT_RELEASE_SAFELY(_selectBtn);
}

- (id)init
{
    self = [super init];
    if (self) {
        self.tuanGouType = -1;
        self.isRefund = NO;
    }
    return self;
}

- (void)setItem:(GBVoucherSingleInfoDTO *)item WithIsrefund:(BOOL)isRefund
{
    _item = item;
    
    self.isRefund = isRefund;
    
    [self lineView];
    if (1 == _item.voucherType
        && 0 == _item.gbType
        && [_item.spSrc isEqualToString:@"10002"]) {
        
        self.voucherCodeLbl.text = _item.spOrderId;
    }
    else{
        
        self.voucherCodeLbl.text = _item.voucherCode;
    }
    
    
    
    self.usefulLifeLbl.size = [self.usefulLifeLbl.text sizeWithFont:[UIFont systemFontOfSize:14]];
    
    self.usefulLifeLbl.text = [NSString stringWithFormat:@"%@%@%@",_item.startTime,L(@"GBTo"),_item.endTime];
    
    self.selectBtn.enabled = NO;
    
    switch (_item.gbType) {
            
        case 0:{
            
            switch (_item.status)
            {
                case 0:
                case 1:{
                    //界面上不展示
                    self.voucherStateLbl.text = L(@"GBWaitToTakeEffect");
                }
                    break;
                case 2:{
                    self.voucherStateLbl.text = L(@"GBUnused2");
                    
                    
                    if (_item.canRefund) {
                        
                        self.selectBtn.enabled = YES;
                    }
                }
                    break;
                case 3:{
                    self.voucherStateLbl.text = L(@"GBOverdue2");
                }
                    break;
                case 4:{
                    self.voucherStateLbl.text = L(@"GBUsed2");
                }
                    break;
                case 5:
                case 6:
                case 7:
                case 8:{
                    self.voucherStateLbl.text = L(@"GBNullified2");
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 1:{
            
            switch (_item.status)
            {
                case 0:{
                    //界面上不展示
                    self.voucherStateLbl.text = L(@"GBWaitToTakeEffect");
                }
                    break;
                case 1:{
                    self.voucherStateLbl.text = L(@"GBUnused2");
                }
                    break;
                case 2:{
                    self.voucherStateLbl.text = L(@"GBUsed2");
                    
                }
                    break;
                case 3:{
                    self.voucherStateLbl.text = L(@"GBOverdue2");
                }
                    break;
                case 4:
                case 5:{
                    self.voucherStateLbl.text = L(@"GBNullified2");
                }
                    break;
                case 6:
                case 7:
                case 8:
                    break;
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    
    
    if (0 == [_item.voucherPasswd length]) {
        
        self.voucherPasswordLbl.hidden = YES;
        self.voucherPasswordContentLbl.hidden = YES;
    }
    else{
        
        self.voucherPasswordLbl.hidden = NO;
        self.voucherPasswordContentLbl.hidden = NO;
    }
    
    self.voucherPasswordLbl.text = _item.voucherPasswd;
    
    self.selectBtn.selected = _item.isSelect;
    
    
    self.lineView.hidden = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //    CGFloat kOffsetContentLeft = 0;
    //
    //    if(self.isRefund == YES)
    //    {
    //        kOffsetContentLeft = 50;
    //    }
    //    else
    //    {
    //        kOffsetContentLeft = 15;
    //
    //    }
    
    
    self.voucherCodeContentLbl.frame = CGRectMake(kOffsetContentLeft(self.isRefund), 15, kOffsetContentLength, kOffsetContentHight);
    
    self.voucherCodeLbl.frame = CGRectMake(self.voucherCodeContentLbl.right, 15, kOffsetLength(self.isRefund), kOffsetHight);
    
    if (0 == [_item.voucherPasswd length]) {
        
        self.voucherStateContentLbl.frame = CGRectMake(kOffsetContentLeft(self.isRefund), self.voucherCodeContentLbl.bottom, kOffsetContentLength, kOffsetContentHight);
        self.voucherStateLbl.frame = CGRectMake(self.voucherStateContentLbl.right, self.voucherCodeContentLbl.bottom, kOffsetLength(self.isRefund), kOffsetContentHight);
    }
    else{
        
        self.voucherPasswordContentLbl.frame = CGRectMake(kOffsetContentLeft(self.isRefund), self.voucherCodeContentLbl.bottom, kOffsetContentLength, kOffsetContentHight);
        
        self.voucherPasswordLbl.frame = CGRectMake(self.voucherPasswordContentLbl.right, self.voucherCodeContentLbl.bottom, kOffsetLength(self.isRefund), kOffsetHight);
        
        self.voucherStateContentLbl.frame = CGRectMake(kOffsetContentLeft(self.isRefund), self.voucherPasswordContentLbl.bottom, kOffsetContentLength, kOffsetContentHight);
        self.voucherStateLbl.frame = CGRectMake(self.voucherStateContentLbl.right, self.voucherPasswordContentLbl.bottom, kOffsetLength(self.isRefund), kOffsetContentHight);
        
        
    }
    
    
    self.usefulLifeContentLbl.frame = CGRectMake(kOffsetContentLeft(self.isRefund), self.voucherStateContentLbl.bottom, kOffsetContentLength, kOffsetContentHight);
    
    self.usefulLifeLbl.frame = CGRectMake(self.usefulLifeContentLbl.right, self.voucherStateContentLbl.bottom, kOffsetLength(self.isRefund), kOffsetHight);
    
    self.lineView.frame = CGRectMake(0, self.usefulLifeContentLbl.bottom+9.5, 320, 0.5);
    
    if(self.isRefund == YES)
    {
        self.selectBtn.hidden = NO;
        self.selectBtn.frame = CGRectMake(20, (self.frame.size.height-10)/2, 17, 17);
        
    }
    else
    {
        self.selectBtn.hidden = YES;
    }
    
    
    //    self.voucherStateContentLbl.frame = CGRectMake(kOffsetContentLeft, self.usefulLifeLbl.bottom, kOffsetContentLength, kOffsetContentHight);
    //
    //    self.voucherStateLbl.frame = CGRectMake(self.voucherStateContentLbl.right, self.usefulLifeLbl.bottom, kOffsetLength, kOffsetHight);
    
    //    self.voucherPasswordContentLbl.frame = CGRectMake(kOffsetContentLeft, self.voucherStateContentLbl.bottom, kOffsetContentLength, kOffsetContentHight);
    //
    //    self.voucherPasswordLbl.frame = CGRectMake(self.voucherPasswordContentLbl.right, self.voucherStateContentLbl.bottom, kOffsetLength, kOffsetHight);
    
    //    self.lineView.frame = CGRectMake(10, 10, 300, self.frame.size.height-10);
}


- (UILabel *)voucherCodeContentLbl
{
    if (!_voucherCodeContentLbl)
    {
        _voucherCodeContentLbl = [[UILabel alloc] init];
        _voucherCodeContentLbl.font = [UIFont systemFontOfSize:15];
        _voucherCodeContentLbl.text = L(@"GBNumberOfCertificate2");
        _voucherCodeContentLbl.backgroundColor = [UIColor clearColor];
        _voucherCodeContentLbl.textColor = [UIColor light_Black_Color];
        
        [self.contentView addSubview:_voucherCodeContentLbl];
    }
    return _voucherCodeContentLbl;
}

- (UILabel *)voucherCodeLbl
{
    if (!_voucherCodeLbl)
    {
        _voucherCodeLbl = [[UILabel alloc] init];
        _voucherCodeLbl.font = [UIFont systemFontOfSize:15];
        _voucherCodeLbl.backgroundColor = [UIColor clearColor];
        _voucherCodeLbl.textColor = [UIColor dark_Gray_Color];
        [self.contentView addSubview:_voucherCodeLbl];
    }
    return _voucherCodeLbl;
}

- (UILabel *)usefulLifeContentLbl
{
    if (!_usefulLifeContentLbl)
    {
        _usefulLifeContentLbl = [[UILabel alloc] init];
        _usefulLifeContentLbl.font = [UIFont systemFontOfSize:15];
        _usefulLifeContentLbl.text = L(@"GBValidityPeriod2");
        _usefulLifeContentLbl.backgroundColor = [UIColor clearColor];
        _usefulLifeContentLbl.textColor = [UIColor light_Black_Color];
        
        [self.contentView addSubview:_usefulLifeContentLbl];
    }
    return _usefulLifeContentLbl;
}

- (UILabel *)usefulLifeLbl
{
    if (!_usefulLifeLbl)
    {
        _usefulLifeLbl = [[UILabel alloc] init];
        _usefulLifeLbl.font = [UIFont systemFontOfSize:15];
        _usefulLifeLbl.backgroundColor = [UIColor clearColor];
        _usefulLifeLbl.numberOfLines = 0;
        _usefulLifeLbl.textColor = [UIColor dark_Gray_Color];
        
        [self.contentView addSubview:_usefulLifeLbl];
    }
    return _usefulLifeLbl;
}

- (UILabel *)voucherStateContentLbl
{
    if (!_voucherStateContentLbl)
    {
        _voucherStateContentLbl = [[UILabel alloc] init];
        _voucherStateContentLbl.font = [UIFont systemFontOfSize:15];
        _voucherStateContentLbl.text = L(@"GBStateOfCertificate");
        _voucherStateContentLbl.textColor = [UIColor light_Black_Color];
        
        _voucherStateContentLbl.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_voucherStateContentLbl];
    }
    return _voucherStateContentLbl;
}

- (UILabel *)voucherStateLbl
{
    if (!_voucherStateLbl)
    {
        _voucherStateLbl = [[UILabel alloc] init];
        _voucherStateLbl.font = [UIFont systemFontOfSize:15];
        _voucherStateLbl.backgroundColor = [UIColor clearColor];
        _voucherStateLbl.textColor = [UIColor dark_Gray_Color];
        
        [self.contentView addSubview:_voucherStateLbl];
    }
    return _voucherStateLbl;
}

- (UILabel *)voucherPasswordContentLbl
{
    if (!_voucherPasswordContentLbl)
    {
        _voucherPasswordContentLbl = [[UILabel alloc] init];
        _voucherPasswordContentLbl.font = [UIFont systemFontOfSize:15];
        _voucherPasswordContentLbl.text = L(@"GBCodeOfCertificate2");
        _voucherPasswordContentLbl.textColor = [UIColor light_Black_Color];
        
        _voucherPasswordContentLbl.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_voucherPasswordContentLbl];
    }
    return _voucherPasswordContentLbl;
}

- (UILabel *)voucherPasswordLbl
{
    if (!_voucherPasswordLbl)
    {
        _voucherPasswordLbl = [[UILabel alloc] init];
        _voucherPasswordLbl.font = [UIFont systemFontOfSize:15];
        _voucherPasswordLbl.backgroundColor = [UIColor clearColor];
        _voucherPasswordLbl.textColor = [UIColor dark_Gray_Color];
        
        [self.contentView addSubview:_voucherPasswordLbl];
    }
    return _voucherPasswordLbl;
}

-(UIButton *)selectBtn{
    
    if (!_selectBtn) {
        
        _selectBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 65, 17, 17)];
        
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"checkbox_selected.png"] forState:UIControlStateSelected];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"checkbox_unselect.png"] forState:UIControlStateNormal];
        [_selectBtn addTarget:self action:@selector(selectBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selectBtn];
    }
    
    return _selectBtn;
}
-(UIImageView *)lineView{
    
    if (!_lineView) {
        
        _lineView = [[UIImageView alloc] init];
        
        _lineView.backgroundColor = [UIColor clearColor];
        
        _lineView.frame = CGRectMake(0, 39.5, 320, 0.5);
        
        [_lineView setImage:[UIImage streImageNamed:@"line.png"]];
        
        [self.contentView addSubview:_lineView];
        
    }
    return _lineView;
}

-(void)selectBtnAction{
    
    _item.isSelect = !_item.isSelect;
    
    self.selectBtn.selected = _item.isSelect;
    
    if ( nil != self.myDelegate && [self.myDelegate respondsToSelector:@selector(selectAction:cell:)]
        )
    {
        [self.myDelegate selectAction:_item cell:nil];
    }
}
@end
