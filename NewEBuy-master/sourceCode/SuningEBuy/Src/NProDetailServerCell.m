//
//  NProDetailServerCell.m
//  SuningEBuy
//
//  Created by 孔斌 on 14-6-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NProDetailServerCell.h"
#import "SNSwitch.h"

#define DefaltServerTextColor [UIColor blackColor]

@implementation NProDetailServerCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.topLineImgView.frame = CGRectMake(0, 0, 320, 0.5);
}

- (UIImageView *)topLineImgView
{
    if (!_topLineImgView) {
        _topLineImgView = [[UIImageView alloc] init];
        _topLineImgView.image = [UIImage imageNamed:@"line.png"];
        [self.contentView addSubview:_topLineImgView];
    }
    return _topLineImgView;
}

- (void)setPropertiewLbl:(UILabel *)lbl
{
    lbl.backgroundColor = [UIColor clearColor];
    lbl.font = [UIFont systemFontOfSize:14];
    lbl.textColor = DefaltServerTextColor;
    [self.contentView addSubview:lbl];
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        [self setPropertiewLbl:_titleLbl];
        _titleLbl.text = L(@"Product_Service");
    }
    return _titleLbl;
}

- (OHAttributedLabel *)detailLbl
{
    if (!_detailLbl) {
        _detailLbl = [[OHAttributedLabel alloc] init];
        _detailLbl.backgroundColor = [UIColor clearColor];
        _detailLbl.font = [UIFont systemFontOfSize:14];
        _detailLbl.size = CGSizeMake(265, 40);
        _detailLbl.shadowColor = [UIColor clearColor];
        _detailLbl.textAlignment = UITextAlignmentLeft;
        _detailLbl.numberOfLines = 0;
        _detailLbl.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:_detailLbl];
    }
    return _detailLbl;
}

- (UILabel *)tuihuoLbl
{
    if (!_tuihuoLbl) {
        _tuihuoLbl = [[UILabel alloc] init];
        [self setPropertiewLbl:_tuihuoLbl];
    }
    return _tuihuoLbl;
}

- (UILabel *)zitiLbl
{
    if (!_zitiLbl) {
        _zitiLbl = [[UILabel alloc] init];
        [self setPropertiewLbl:_zitiLbl];
    }
    return _zitiLbl;
}

- (UIImageView *)tuihuoImgView
{
    if (!_tuihuoImgView) {
        _tuihuoImgView = [[UIImageView alloc] init];
        _tuihuoImgView.image = [UIImage imageNamed:@"productDetail_tuihuo.png"];
        [self.contentView addSubview:_tuihuoImgView];
    }
    return _tuihuoImgView;
}

- (UIImageView *)zitiImgView
{
    if (!_zitiImgView) {
        _zitiImgView = [[UIImageView alloc] init];
        _zitiImgView.image = [UIImage imageNamed:@"productDetail_ziti.png"];
        [self.contentView addSubview:_zitiImgView];
    }
    return _zitiImgView;
}

- (void)setServiceDto:(DataProductBasic *)dto coloStr:(NSString *)colorStr
{
    self.backgroundColor = [UIColor clearColor];
    
    NSMutableAttributedString *timeContentAtt = nil;
    
    NSString *detailStr = nil;
    NSString *shopNameStr = nil;

    if (!dto.isCShop) {
        shopNameStr = @"苏宁";
        if (dto.factorySendFlag) {
            detailStr = [NSString stringWithFormat:@"%@“%@”%@",L(@"Product_You"),shopNameStr,L(@"Product_Message1")];
            
        }else
        {
            detailStr = [NSString stringWithFormat:@"%@“%@”%@",L(@"Product_You"),shopNameStr,L(@"Product_Message2")];
        }
    }
    else
    {
        shopNameStr = dto.shopName;
        detailStr = [NSString stringWithFormat:@"%@“%@”%@",L(@"Product_You"),shopNameStr,L(@"Product_Message2")];
    }
    UIFont *strFont =[UIFont systemFontOfSize:14];
    timeContentAtt = [[NSMutableAttributedString alloc] initWithString:detailStr];
    [timeContentAtt setTextColor:DefaltServerTextColor];
    [timeContentAtt setTextColor:DefaltServerTextColor range:[detailStr rangeOfString:shopNameStr]];
    [timeContentAtt setFont:strFont];
    self.detailLbl.attributedText = timeContentAtt;
    
    CGSize mainContendSize = [detailStr heightWithFont:strFont width:265 linebreak:NSLineBreakByWordWrapping];
    
    self.titleLbl.frame = CGRectMake(15, 7, 38, 20);
    self.detailLbl.frame = CGRectMake(self.titleLbl.right, 10, 265, mainContendSize.height );
    self.tuihuoImgView.frame = CGRectMake(self.titleLbl.right, self.detailLbl.bottom + 7, 15, 15);
    self.tuihuoLbl.frame = CGRectMake(self.tuihuoImgView.right + 3, self.detailLbl.bottom + 3, 247, 20);
    if (!IsStrEmpty(dto.returnCate)) {
        self.zitiImgView.frame = CGRectMake(self.titleLbl.right, self.tuihuoLbl.bottom + 7, 15, 15);
        self.zitiLbl.frame = CGRectMake(self.zitiImgView.right + 3, self.tuihuoLbl.bottom + 3, 247, 20);
    }else
    {
        self.zitiImgView.frame = CGRectMake(self.titleLbl.right, self.detailLbl.bottom + 7, 15, 15);
        self.zitiLbl.frame = CGRectMake(self.zitiImgView.right + 3, self.detailLbl.bottom + 3, 247, 20);
    }
    
    
    //自营上架商品根据canTake判断是否展示门店自提信息,下架商品整个服务都不展示
    //C店商品无上下架概念,直接不展示门店自提信息
    if ((dto.isPublished && !dto.isCShop) || dto.isCShop) {
        self.titleLbl.hidden = NO;
        self.detailLbl.hidden = NO;
        self.tuihuoImgView.hidden = NO;
        self.tuihuoLbl.hidden = NO;
        self.zitiImgView.hidden = NO;
        self.zitiLbl.hidden = NO;
        
        //展示门店自提信息
        //自营且后台开关开了且接口返回canTake为Y则展示
        if (!dto.isCShop) {
            if ([SNSwitch isShowServerZiti]) {
                if ([dto.canTake isEqualToString:@"Y"]) {
                    NSString *serverCuxiaoDescStr = [SNSwitch serverCuxiaoDesc];
                    
                    self.zitiLbl.text = [NSString stringWithFormat:@"%@ %@",L(@"Product_SupportStorePick"),serverCuxiaoDescStr];
                    self.zitiLbl.hidden = NO;
                    self.zitiImgView.hidden = NO;
                }else
                {
                    self.zitiLbl.hidden = YES;
                    self.zitiImgView.hidden = YES;
                    self.zitiLbl.text = @"";
                }
            }
            else
            {
                self.zitiLbl.hidden = YES;
                self.zitiImgView.hidden = YES;
                self.zitiLbl.text = @"";
            }
        }
        else
        {
            self.zitiLbl.hidden = YES;
            self.zitiImgView.hidden = YES;
            self.zitiLbl.text = @"";
        }
        
        
        //小套餐不展示无理由退货
        if (!IsStrEmpty(dto.returnCate)) {
            self.tuihuoLbl.hidden = NO;
            self.tuihuoImgView.hidden = NO;
            self.tuihuoLbl.text = dto.returnCate;
            if (dto.isRtnNoReason) {
                self.tuihuoLbl.textColor = DefaltServerTextColor;
                self.tuihuoImgView.image = [UIImage imageNamed:@"productDetail_tuihuo.png"];
            }else
            {
                self.tuihuoLbl.textColor = [UIColor colorWithRGBHex:0x707070];
                self.tuihuoImgView.image = [UIImage imageNamed:@"productDetail_un_tuihuo.png"];
            }
        }else
        {
            self.tuihuoImgView.hidden = YES;
            self.tuihuoLbl.hidden = YES;
        }
    }
    else
    {
        self.titleLbl.hidden = YES;
        self.detailLbl.hidden = YES;
        self.tuihuoImgView.hidden = YES;
        self.tuihuoLbl.hidden = YES;
        self.zitiImgView.hidden = YES;
        self.zitiLbl.hidden = YES;
    }
}

+ (CGFloat)NProDetailFourCellHeight:(DataProductBasic*)dto
{
    NSString *detailStr = nil;
    NSString *shopNameStr = nil;
    if (!dto.isCShop) {
        shopNameStr = @"苏宁";
        if (dto.factorySendFlag) {
            detailStr = [NSString stringWithFormat:@"%@“%@”%@",L(@"Product_You"),shopNameStr,L(@"Product_Message1")];
        }else
        {
            detailStr = [NSString stringWithFormat:@"%@“%@”%@",L(@"Product_You"),shopNameStr,L(@"Product_Message2")];
        }
    }
    else
    {
        shopNameStr = dto.shopName;
        detailStr = [NSString stringWithFormat:@"%@“%@”%@",L(@"Product_You"),shopNameStr,L(@"Product_Message2")];
    }
    CGSize mainContendSize = [detailStr heightWithFont:[UIFont systemFontOfSize:14] width:265 linebreak:NSLineBreakByWordWrapping];

    if (dto.isCShop) {
        if (!IsStrEmpty(dto.returnCate)) {
            return 45 + mainContendSize.height;
        }
        return 20 + mainContendSize.height;
    }
    else
    {
        if (!IsStrEmpty(dto.returnCate)) {
            if ([SNSwitch isShowServerZiti]) {
                if ([dto.canTake isEqualToString:@"Y"]) {
                    return 65 + mainContendSize.height;
                }
                return 45 + mainContendSize.height;
            }
            return 45 + mainContendSize.height;
        }
        else
        {
            if ([SNSwitch isShowServerZiti]) {
                if ([dto.canTake isEqualToString:@"Y"]) {
                    return 40 + mainContendSize.height;
                }
                return 20 + mainContendSize.height;
            }
            return 20 + mainContendSize.height;
        }
    }
}

@end
