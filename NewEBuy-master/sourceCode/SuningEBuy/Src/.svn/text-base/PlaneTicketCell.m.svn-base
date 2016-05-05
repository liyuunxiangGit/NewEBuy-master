//
//  PlaneTicketCell.m
//  SuningEBuy
//
//  Created by david on 14-2-17.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "PlaneTicketCell.h"
#import "InsuranceDTO.h"

#define UILABLE_FONT    [UIFont systemFontOfSize:15]
#define leftPadding     15
#define topPadding      20

@interface PlaneTicketCell()

@property(nonatomic,strong)UIView       *whiteBackView;

@property(nonatomic,strong)UILabel      *dengJiRenLbl;
@property(nonatomic,strong)UILabel      *dengJiRenValLbl;

@property(nonatomic,strong)UILabel      *dianZiKeDanLbl;
@property(nonatomic,strong)UILabel      *dianZiKeDanValLbl;

@property(nonatomic,strong)UILabel      *baoXianDanHaoLbl;
@property(nonatomic,strong)UILabel      *baoXianDanHaoValLbl;

@property(nonatomic,strong)UILabel      *jiPiaoJiaGeLbl;
@property(nonatomic,strong)UILabel      *jiPiaoJiaGeValLbl;

@property(nonatomic,strong)UILabel      *jiJianFeiLbl;
@property(nonatomic,strong)UILabel      *jiJianFeiValLbl;

@property(nonatomic,strong)UILabel      *ranYouFeiLbl;
@property(nonatomic,strong)UILabel      *ranYouFeiValLbl;

@property(nonatomic,strong)UILabel      *baoXianLbl;
@property(nonatomic,strong)UILabel      *baoXianValLbl;

@property(nonatomic,strong)UILabel      *xiaoJiLbl;
@property(nonatomic,strong)UILabel      *xiaoJiValLbl;

@property(nonatomic,strong)UIImageView  *lineImage;

@end


@implementation PlaneTicketCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = nil;
    }
    return self;
}

+(CGFloat)height:(TicketDetailDTO *)dto{
    
    if (IsNilOrNull(dto.insuranceArr)) {
        return 280;
    }else{
        return 310;
    }
}


-(void)refreshCell:(TicketDetailDTO *)dto{
    
    if (dto == nil) return;
    
    self.whiteBackView.frame = CGRectMake(0, topPadding, 320, 290);
    //登机人
    self.dengJiRenLbl.frame = CGRectMake(leftPadding, topPadding+5, 80, 30);
    self.dengJiRenValLbl.frame = CGRectMake(_dengJiRenLbl.right, _dengJiRenLbl.top, (320-leftPadding-_dengJiRenLbl.right), 30);
    
    //电子客单号
    self.dianZiKeDanLbl.frame = CGRectMake(leftPadding, _dengJiRenLbl.bottom, 80, 30);
    self.dianZiKeDanValLbl.frame = CGRectMake(_dianZiKeDanLbl.right, _dianZiKeDanLbl.top, (320-leftPadding-_dianZiKeDanLbl.right), 30);
    
    //保险单号
    self.baoXianDanHaoLbl.frame = CGRectMake(leftPadding, _dianZiKeDanLbl.bottom, 80, 30);
    self.baoXianDanHaoValLbl.frame = CGRectMake(_baoXianDanHaoLbl.right, _baoXianDanHaoLbl.top, (320-leftPadding-_baoXianDanHaoLbl.right), 30);

    //机票价格
    self.jiPiaoJiaGeLbl.frame = CGRectMake(leftPadding, _baoXianDanHaoLbl.bottom, 80, 30);
    self.jiPiaoJiaGeValLbl.frame = CGRectMake(_jiPiaoJiaGeLbl.right, _jiPiaoJiaGeLbl.top, (320-leftPadding-_jiPiaoJiaGeLbl.right), 30);

    //机建费
    self.jiJianFeiLbl.frame = CGRectMake(leftPadding, _jiPiaoJiaGeLbl.bottom, 80, 30);
    self.jiJianFeiValLbl.frame = CGRectMake(_jiJianFeiLbl.right, _jiJianFeiLbl.top, (320-leftPadding-_jiJianFeiLbl.right), 30);
    
    //燃油费
    self.ranYouFeiLbl.frame = CGRectMake(leftPadding, _jiJianFeiLbl.bottom, 80, 30);
    self.ranYouFeiValLbl.frame = CGRectMake(_ranYouFeiLbl.right, _ranYouFeiLbl.top, (320-leftPadding-_ranYouFeiLbl.right), 30);
    
    //保险
    if (IsArrEmpty(dto.insuranceArr)) {
        self.baoXianLbl.frame = CGRectMake(leftPadding, _ranYouFeiLbl.bottom, 200, 30);
        self.whiteBackView.frame = CGRectMake(0, topPadding, 320, 260);
    }else{
        self.baoXianLbl.frame = CGRectMake(leftPadding, _ranYouFeiLbl.bottom, 200, 60);
    }
    self.baoXianValLbl.frame = CGRectMake(_baoXianLbl.right, _baoXianLbl.top, (320-leftPadding-_baoXianLbl.right), 30);
    
    //分割线
    self.lineImage.frame = CGRectMake(0, _baoXianLbl.bottom+5, 320, 1);
    
    //小计
    self.xiaoJiLbl.frame = CGRectMake(leftPadding, _lineImage.bottom+5, 80, 30);
    self.xiaoJiValLbl.frame = CGRectMake(_xiaoJiLbl.right, _xiaoJiLbl.top, (320-leftPadding-_xiaoJiLbl.right), 30);

    //设置展示内容
    self.dengJiRenValLbl.text = dto.travellerName;
    self.dianZiKeDanValLbl.text = dto.itinerary?dto.itinerary:@"--";
    if (IsArrEmpty(dto.insuranceArr)) {
        self.baoXianDanHaoValLbl.text = dto.insuranceNo?dto.insuranceNo:@"--";
        self.baoXianValLbl.text = @"--";
    }else{
        NSString *tmpStr = nil;
        for (InsuranceDTO *tmpInsurance in dto.insuranceArr) {
            if (NotNilAndNull(tmpInsurance.supOrderId)) {
                tmpStr = [NSString stringWithFormat:@"%@/%@",tmpStr,tmpInsurance.supOrderId];
            }
            self.baoXianLbl.text = [NSString stringWithFormat:@"%@（%@）",L(@"BTInsurance1"),tmpInsurance.insuranceName];
            self.baoXianValLbl.text = [NSString stringWithFormat:@"%@%@*%d",tmpInsurance.salePrice,L(@"BTYuanPerPortion"),[dto.insuranceArr count]];
        }
        self.baoXianDanHaoValLbl.text = tmpStr?tmpStr:@"--";
    }
    
    
    

    if ([dto.travellerType eq:L(@"Adult")]) {
        self.jiPiaoJiaGeValLbl.text = [NSString stringWithFormat:@"￥%.2f",[dto.adultPrice doubleValue]];
        self.jiJianFeiValLbl.text = [NSString stringWithFormat:@"￥%.2f",[dto.adultFee doubleValue]];
        self.ranYouFeiValLbl.text = [NSString stringWithFormat:@"￥%.2f",[dto.adultTax doubleValue]];

    }else{
        self.jiPiaoJiaGeValLbl.text = [NSString stringWithFormat:@"￥%.2f",[dto.childPrice doubleValue]];
        self.jiJianFeiValLbl.text = [NSString stringWithFormat:@"￥%.2f",[dto.childFee doubleValue]];
        self.ranYouFeiValLbl.text = [NSString stringWithFormat:@"￥%.2f",[dto.childTax doubleValue]];

    }
    
    self.xiaoJiValLbl.text = [NSString stringWithFormat:@"￥%.2f",[dto.totalAmount doubleValue]];
}


#pragma mark -
#pragma mark UIView
-(UIView *)whiteBackView{
    if (!_whiteBackView) {
        _whiteBackView = [[UIView alloc]init];
        _whiteBackView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_whiteBackView];
    }
    return _whiteBackView;
}


-(UILabel *)dengJiRenLbl{
    if (!_dengJiRenLbl) {
        _dengJiRenLbl = [[UILabel alloc]init];
        _dengJiRenLbl.backgroundColor = [UIColor clearColor];
        _dengJiRenLbl.font = UILABLE_FONT;
        _dengJiRenLbl.text = L(@"BTBorderManager");
        [self.contentView addSubview:_dengJiRenLbl];
    }
    return _dengJiRenLbl;
}

-(UILabel *)dengJiRenValLbl{
    if (!_dengJiRenValLbl) {
        _dengJiRenValLbl = [[UILabel alloc]init];
        _dengJiRenValLbl.backgroundColor = [UIColor clearColor];
        _dengJiRenValLbl.font = UILABLE_FONT;
        _dengJiRenValLbl.textAlignment = UITextAlignmentRight;
        [self.contentView addSubview:_dengJiRenValLbl];
    }
    return _dengJiRenValLbl;
}


-(UILabel *)dianZiKeDanLbl{
    if (!_dianZiKeDanLbl) {
        _dianZiKeDanLbl = [[UILabel alloc]init];
        _dianZiKeDanLbl.backgroundColor = [UIColor clearColor];
        _dianZiKeDanLbl.font = UILABLE_FONT;
        _dianZiKeDanLbl.text = L(@"BTElectronOrderId");
        [self.contentView addSubview:_dianZiKeDanLbl];
    }
    return _dianZiKeDanLbl;
}

-(UILabel *)dianZiKeDanValLbl{
    if (!_dianZiKeDanValLbl) {
        _dianZiKeDanValLbl = [[UILabel alloc]init];
        _dianZiKeDanValLbl.backgroundColor = [UIColor clearColor];
        _dianZiKeDanValLbl.font = UILABLE_FONT;
        _dianZiKeDanValLbl.textAlignment = UITextAlignmentRight;
        [self.contentView addSubview:_dianZiKeDanValLbl];
    }
    return _dianZiKeDanValLbl;
}

-(UILabel *)baoXianDanHaoLbl{
    if (!_baoXianDanHaoLbl) {
        _baoXianDanHaoLbl = [[UILabel alloc]init];
        _baoXianDanHaoLbl.backgroundColor = [UIColor clearColor];
        _baoXianDanHaoLbl.font = UILABLE_FONT;
        _baoXianDanHaoLbl.text = L(@"BTInsuranceId");
        [self.contentView addSubview:_baoXianDanHaoLbl];
    }
    return _baoXianDanHaoLbl;
}


-(UILabel *)baoXianDanHaoValLbl{
    if (!_baoXianDanHaoValLbl) {
        _baoXianDanHaoValLbl = [[UILabel alloc]init];
        _baoXianDanHaoValLbl.backgroundColor = [UIColor clearColor];
        _baoXianDanHaoValLbl.font = UILABLE_FONT;
        _baoXianDanHaoValLbl.textAlignment = UITextAlignmentRight;
        [self.contentView addSubview:_baoXianDanHaoValLbl];
    }
    return _baoXianDanHaoValLbl;
}


-(UILabel *)jiPiaoJiaGeLbl{
    if (!_jiPiaoJiaGeLbl) {
        _jiPiaoJiaGeLbl = [[UILabel alloc]init];
        _jiPiaoJiaGeLbl.backgroundColor = [UIColor clearColor];
        _jiPiaoJiaGeLbl.font = UILABLE_FONT;
        _jiPiaoJiaGeLbl.text = L(@"BTAirTicketPrice");
        [self.contentView addSubview:_jiPiaoJiaGeLbl];
    }
    return _jiPiaoJiaGeLbl;
}


-(UILabel *)jiPiaoJiaGeValLbl{
    if (!_jiPiaoJiaGeValLbl) {
        _jiPiaoJiaGeValLbl = [[UILabel alloc]init];
        _jiPiaoJiaGeValLbl.backgroundColor = [UIColor clearColor];
        _jiPiaoJiaGeValLbl.font = UILABLE_FONT;
        _jiPiaoJiaGeValLbl.textAlignment = UITextAlignmentRight;
        _jiPiaoJiaGeValLbl.textColor = [UIColor orange_Red_Color];
        [self.contentView addSubview:_jiPiaoJiaGeValLbl];
    }
    return _jiPiaoJiaGeValLbl;
}


-(UILabel *)jiJianFeiLbl{
    if (!_jiJianFeiLbl) {
        _jiJianFeiLbl = [[UILabel alloc]init];
        _jiJianFeiLbl.backgroundColor = [UIColor clearColor];
        _jiJianFeiLbl.font = UILABLE_FONT;
        _jiJianFeiLbl.text = L(@"BTBunker");
        [self.contentView addSubview:_jiJianFeiLbl];
    }
    return _jiJianFeiLbl;
}


-(UILabel *)jiJianFeiValLbl{
    if (!_jiJianFeiValLbl) {
        _jiJianFeiValLbl = [[UILabel alloc]init];
        _jiJianFeiValLbl.backgroundColor = [UIColor clearColor];
        _jiJianFeiValLbl.font = UILABLE_FONT;
        _jiJianFeiValLbl.textAlignment = UITextAlignmentRight;
        _jiJianFeiValLbl.textColor = [UIColor orange_Red_Color];
        [self.contentView addSubview:_jiJianFeiValLbl];
    }
    return _jiJianFeiValLbl;
}

-(UILabel *)ranYouFeiLbl{
    if (!_ranYouFeiLbl) {
        _ranYouFeiLbl = [[UILabel alloc]init];
        _ranYouFeiLbl.backgroundColor = [UIColor clearColor];
        _ranYouFeiLbl.font = UILABLE_FONT;
        _ranYouFeiLbl.text = L(@"BTFuelCost");
        [self.contentView addSubview:_ranYouFeiLbl];
    }
    return _ranYouFeiLbl;
}

-(UILabel *)ranYouFeiValLbl{
    if (!_ranYouFeiValLbl) {
        _ranYouFeiValLbl = [[UILabel alloc]init];
        _ranYouFeiValLbl.backgroundColor = [UIColor clearColor];
        _ranYouFeiValLbl.font = UILABLE_FONT;
        _ranYouFeiValLbl.textAlignment = UITextAlignmentRight;
        _ranYouFeiValLbl.textColor = [UIColor orange_Red_Color];
        [self.contentView addSubview:_ranYouFeiValLbl];
    }
    return _ranYouFeiValLbl;
}


-(UILabel *)baoXianLbl{
    if (!_baoXianLbl) {
        _baoXianLbl = [[UILabel alloc]init];
        _baoXianLbl.backgroundColor = [UIColor clearColor];
        _baoXianLbl.font = UILABLE_FONT;
        _baoXianLbl.text = L(@"BTInsurance1");
        _baoXianLbl.numberOfLines = 0;
        [self.contentView addSubview:_baoXianLbl];
    }
    return _baoXianLbl;
}

-(UILabel *)baoXianValLbl{
    if (!_baoXianValLbl) {
        _baoXianValLbl = [[UILabel alloc]init];
        _baoXianValLbl.backgroundColor = [UIColor clearColor];
        _baoXianValLbl.font = UILABLE_FONT;
        _baoXianValLbl.textAlignment = UITextAlignmentRight;
        _baoXianValLbl.textColor = [UIColor orange_Red_Color];
        [self.contentView addSubview:_baoXianValLbl];
    }
    return _baoXianValLbl;
}

-(UIImageView *)lineImage{
    
    if (!_lineImage) {
        _lineImage = [[UIImageView alloc]init];
        UIImage *image = [UIImage newImageFromResource:@"line.png"];
        _lineImage.image = image;
        [self.contentView addSubview:_lineImage];
    }
    return _lineImage;
}

-(UILabel *)xiaoJiLbl{
    if (!_xiaoJiLbl) {
        _xiaoJiLbl = [[UILabel alloc]init];
        _xiaoJiLbl.backgroundColor = [UIColor clearColor];
        _xiaoJiLbl.font = UILABLE_FONT;
        _xiaoJiLbl.text = L(@"BTCost");
        [self.contentView addSubview:_xiaoJiLbl];
    }
    return _xiaoJiLbl;
}

-(UILabel *)xiaoJiValLbl{
    if (!_xiaoJiValLbl) {
        _xiaoJiValLbl = [[UILabel alloc]init];
        _xiaoJiValLbl.backgroundColor = [UIColor clearColor];
        _xiaoJiValLbl.font = UILABLE_FONT;
        _xiaoJiValLbl.textAlignment = UITextAlignmentRight;
        _xiaoJiValLbl.textColor = [UIColor orange_Red_Color];
        [self.contentView addSubview:_xiaoJiValLbl];
    }
    return _xiaoJiValLbl;
}

@end
