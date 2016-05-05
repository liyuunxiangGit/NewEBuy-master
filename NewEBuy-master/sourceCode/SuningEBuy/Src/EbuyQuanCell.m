//
//  EbuyQuanCell.m
//  SuningEBuy
//
//  Created by li xiaokai on 14-2-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "EbuyQuanCell.h"

@implementation EbuyQuanCell

-(UIImageView *)backImg{
    
    if (!_backImg) {
        
        _backImg =[[UIImageView alloc] initWithFrame:CGRectMake(14, 5, 292, 110)];
        
        _backImg.image = [[UIImage imageNamed:@"quanback.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(30, 50, 30, 50)];
        
       // _backImg.backgroundColor = [UIColor clearColor];
        
//        [self.contentView addSubview:_backImg];
        
        //292 110
    }
    
    return _backImg;
}

- (UIImageView *)cellBackViewImage {
    if (!_cellBackViewImage) {
        _cellBackViewImage =[[UIImageView alloc] initWithFrame:CGRectMake(14, 5, 292, 110)];
        _cellBackViewImage.image = [[UIImage imageNamed:@"quanback.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(30, 50, 30, 50)];
    }
    return _cellBackViewImage;
}

-(UILabel *)quanNOLab{
    
    if (!_quanNOLab) {
        
        _quanNOLab = [[UILabel alloc] initWithFrame:CGRectMake(50, 22, 110, 12)];
        
        _quanNOLab.textColor = [UIColor dark_Gray_Color];
        _quanNOLab.backgroundColor = [UIColor clearColor];
        
        _quanNOLab.font = [UIFont systemFontOfSize:9];
    }
    
    return _quanNOLab;
}

-(UILabel *)backQuanNOLab{
    
    if (!_backQuanNOLab) {
        
        _backQuanNOLab = [[UILabel alloc] initWithFrame:CGRectMake(50, 22, 110, 12)];
        
        _backQuanNOLab.textColor = [UIColor dark_Gray_Color];
        
        _backQuanNOLab.font = [UIFont systemFontOfSize:9];
    }
    
    return _backQuanNOLab;
}

-(UILabel *)dateLab{
    
    if (!_dateLab) {
        
        _dateLab = [[UILabel alloc] initWithFrame:CGRectMake(160, 22, 110, 12)];
        
        _dateLab.textColor = [UIColor dark_Gray_Color];
        
        _dateLab.font = [UIFont systemFontOfSize:9];
        
        _dateLab.textAlignment = UITextAlignmentRight;
        
//        [self.contentView addSubview:_dateLab];

    }
    
    return _dateLab;
}

- (UILabel *)backDateLab {
    if (!_backDateLab) {
        _backDateLab = [[UILabel alloc] initWithFrame:CGRectMake(160, 22, 110, 12)];
        _backDateLab.textColor = [UIColor dark_Gray_Color];
        _backDateLab.font = [UIFont systemFontOfSize:9];
        _backDateLab.textAlignment = UITextAlignmentRight;
        _backDateLab.backgroundColor = [UIColor clearColor];
    }
    return _backDateLab;
}

-(UILabel *)lineView{
    
    if (!_lineView) {
        
        _lineView = [[UILabel alloc] initWithFrame:CGRectMake(50, 39, 220, 1)];
        
        _lineView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.2];
        
//        [self.contentView addSubview:_lineView];
    }
    
    return _lineView;
}
-(UILabel *)priceLab{
    
    if (!_priceLab) {
        
        _priceLab = [[UILabel alloc] initWithFrame:CGRectMake(50, 48, 150, 40)];

        _priceLab.textColor = [UIColor redColor];
        
        _priceLab.font = [UIFont fontWithName:@"DIN Condensed" size:35];
        
//        [self.contentView addSubview:_priceLab];

    }
    
    return _priceLab;
}
-(UILabel *)quanName{
    
    if (!_quanName) {
        
        _quanName = [[UILabel alloc] initWithFrame:CGRectMake(50, 85, 210, 15)];
        
        _quanName.textColor = [UIColor light_Black_Color];
        
        _quanName.font = [UIFont boldSystemFontOfSize:10];
        
//        [self.contentView addSubview:_quanName];

    }
    
    return _quanName;
}

- (UIImageView *)frontIndicatorImageView {
    if (!_frontIndicatorImageView) {
        _frontIndicatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(260, 60, 5, 10)];
        _frontIndicatorImageView.image = [UIImage imageNamed:@"youhuiquan_indicator.png"];
    }
    return _frontIndicatorImageView;
}

-(UILabel *)memoLab{
    
    if (!_memoLab) {
        
        _memoLab = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 210, 15)];

        _memoLab.textColor = [UIColor dark_Gray_Color];
        
        _memoLab.numberOfLines = 0;
        
        _memoLab.font = [UIFont boldSystemFontOfSize:10];
        
//        [self.contentView addSubview:_memoLab];

    }
    
    return _memoLab;
}


- (UITextView *)backQuanDescrption {
    if (!_backQuanDescrption) {
        _backQuanDescrption = [[UITextView alloc] initWithFrame:CGRectMake(50, 40, 205, 60)];
        _backQuanDescrption.textColor = [UIColor dark_Gray_Color];
        _backQuanDescrption.font = [UIFont boldSystemFontOfSize:10];
        _backQuanDescrption.backgroundColor = [UIColor clearColor];
        _backQuanDescrption.editable = NO;
    }
    return _backQuanDescrption;
}

-(UIButton *)markBtn{
    
    if (!_markBtn) {
        
        _markBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _markBtn.frame = CGRectMake(250, 70, 45, 45);
        
        [_markBtn addTarget:self action:@selector(markBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_markBtn setImage:[UIImage imageNamed:@"arrow_bottom_gray.png"] forState:UIControlStateNormal];
        
        [_markBtn setImage:[UIImage imageNamed:@"arrow_top_gray.png"] forState:UIControlStateSelected];
        
        //[self.contentView addSubview:_markBtn];
    }
    
    return _markBtn;
}



-(void)markBtnAction{
    
    self.markBtn.selected = !self.markBtn.selected;
    
    self.dto.bExpend = !self.dto.bExpend;
    
    if (_myDelegate && [_myDelegate respondsToSelector:@selector(expendCell)]) {
        
        [_myDelegate expendCell];
    }
}

-(NSString *)timeString:(id)dto{
    
    if ([dto isKindOfClass:[MYEbuyCoumonDTO class]]) {
        
        MYEbuyCoumonDTO *detail = (MYEbuyCoumonDTO *)dto;
        
        return [NSString stringWithFormat:@"%@-%@",[self changeType:detail.startTime],[self changeType:detail.endTime]];
    }
    
    else if ([dto isKindOfClass:[ExCouponDto class]]) {
        
        ExCouponDto *detail = (ExCouponDto *)dto;
        
        return [NSString stringWithFormat:@"%@-%@",[self changeType:detail.beginDate],[self changeType:detail.endDate]];
    }
    
    return @"///-///";
}

-(NSString *)changeType:(NSString *)time{
    //yyyy-MM-dd  ->  yyyy/MM/dd
    
    if (!IsStrEmpty(time) && [time length]>=10) {
        
        NSString *timeStr = [time substringWithRange:NSMakeRange(0, 10)];
        
        return [timeStr stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    }
    
    return @"///";
}


-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        //需要判断是否是<br/> 或者 <br />标签
        if ([text rangeOfString:@"br" options:NSCaseInsensitiveSearch].location != NSNotFound) {
            html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@"\n"];
        }
        else {
            html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
        }
    }
    
    html = [html stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@"\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [html length])];
    html = [html stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@"\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [html length])];
    return html;
}

-(void)setUIItem:(id)dto {
    //此处需要判断cell是在否是在正面，若不是，则需要手动把cell翻转
    int index = [[self.contentView subviews] indexOfObject:self.cellFrontView];
    if (index != 1) {
        [self changeView];
    }
    
    self.markBtn.hidden = YES;

    if ([dto isKindOfClass:[MYEbuyCoumonDTO class]]) {
        
        self.isYouHuiQuan = YES;
        self.frontIndicatorImageView.hidden = NO;
        
        self.dto = (MYEbuyCoumonDTO *)dto;
        
        self.quanNOLab.text = self.dto.serialNumber;
        self.backQuanNOLab.text = self.dto.serialNumber;
        
        self.priceLab.text = self.dto.strparValue;
        
        self.dateLab.text = [self timeString:dto];
        self.backDateLab.text = [self timeString:dto];
        
        self.quanName.text = self.dto.name;
        self.backQuanDescrption.text = self.dto.couponTemplateDesc == nil ? @"" : [self filterHTML:self.dto.couponTemplateDesc];
        
        if (self.dto.bExpend) {
            
            self.memoLab.hidden = NO;
            
            self.memoLab.text = self.dto.ticketCategory;
            
            CGRect frame = self.memoLab.frame;
            
            frame.size.height = [EbuyQuanCell detailHeight:self.dto];
            
            self.memoLab.frame = frame;
            
        }
        else{
            
            self.memoLab.hidden = YES;
        }
        
        self.markBtn.selected = self.dto.bExpend;
        
        if (IsStrEmpty(self.dto.ticketCategory)) {
            
            self.markBtn.hidden = YES;
        }
        else{
            
            self.markBtn.hidden = NO;
        }
    }
    else if([dto isKindOfClass:[ExCouponDto class]]){
        self.isYouHuiQuan = NO;
        self.frontIndicatorImageView.hidden = YES;
        
        ExCouponDto *detail = (ExCouponDto *)dto;
        
        self.quanNOLab.text = detail.billNo;
        
        self.priceLab.text = detail.batchMoney;
        
        self.dateLab.text = [self timeString:detail];
        
        self.quanName.text = detail.billType;
        
        //add by zhangbeibei 20140725:当券类型是电子礼金券的时候，电子礼金券没有ticketCategory字段，所以memoLab需要隐藏
        self.memoLab.hidden = YES;
    }
    


    self.backImg.frame = CGRectMake(14, 5, 292, [EbuyQuanCell heightOfCell:dto]-10);
    self.cellBackViewImage.frame = CGRectMake(14, 5, 292, [EbuyQuanCell heightOfCell:dto]-10);
}

+(float)detailHeight:(id)dto{
    
    if (![dto isKindOfClass:[MYEbuyCoumonDTO class]]) {
        
        return 0;
    }
    
    MYEbuyCoumonDTO *detail = (MYEbuyCoumonDTO *)dto;
    
    if (detail.bExpend && !IsStrEmpty(detail.ticketCategory)) {
        
        CGSize size = [detail.ticketCategory sizeWithFont:[UIFont boldSystemFontOfSize:10.0] constrainedToSize:CGSizeMake(220, 10000)];
        
       return size.height;
    }
    
    return 0;
}

+(float)heightOfCell:(id)dto{
    
    
    float height = 120;
    
        
    height = height + [EbuyQuanCell detailHeight:dto];

    
    return height;
    
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.isCellBackViewHidden = YES;
        self.isYouHuiQuan = NO;
        [self.cellFrontView addSubview:self.backImg];
        [self.cellFrontView addSubview:self.lineView];
        [self.cellFrontView addSubview:self.quanNOLab];
        [self.cellFrontView addSubview:self.dateLab];
        [self.cellFrontView addSubview:self.priceLab];
        [self.cellFrontView addSubview:self.quanName];
        [self.cellFrontView addSubview:self.memoLab];
        [self.cellFrontView addSubview:self.frontIndicatorImageView];
        
        //配置背面UI
        [self.cellBackView addSubview:self.cellBackViewImage];
        
        UILabel *backViewLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 39, 220, 1)];
        backViewLineLabel.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.2];
        [self.cellBackView addSubview:backViewLineLabel];
        TT_RELEASE_SAFELY(backViewLineLabel);
        
        [self.cellBackView addSubview:self.backQuanNOLab];
        [self.cellBackView addSubview:self.backDateLab];
        [self.cellBackView addSubview:self.backQuanDescrption];
        
        UIImageView *backIndicator = [[UIImageView alloc] initWithFrame:CGRectMake(260, 60, 5, 10)];
        backIndicator.image = [UIImage imageNamed:@"youhuiquan_indicator.png"];
        [self.cellBackView addSubview:backIndicator];
        TT_RELEASE_SAFELY(backIndicator);
        
        self.cellBackView.hidden = YES;
        
        [self.contentView addSubview:self.cellBackView];
        [self.contentView addSubview:self.cellFrontView];
        
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped)];
        tapGesture.cancelsTouchesInView = NO;
        tapGesture.delegate = self;
        [self.contentView addGestureRecognizer:tapGesture];

        self.backgroundColor = [UIColor clearColor];
    
    }
    return self;
}

- (void)cellTapped {
    if (self.isYouHuiQuan) {
        [self changeView];
    }
}


- (UIView *)cellFrontView {
    if (_cellFrontView == nil) {
        _cellFrontView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)];
        _cellFrontView.backgroundColor = [UIColor clearColor];
    }
    return _cellFrontView;
}

- (UIView *)cellBackView {
    if (_cellBackView == nil) {
        _cellBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)];
        _cellBackView.backgroundColor = [UIColor clearColor];
    }
    return _cellBackView;
}

- (void)changeView {
    [UIView beginAnimations:@"animationID" context:nil];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.contentView cache:NO];
    
    [self.contentView exchangeSubviewAtIndex:[[self.contentView subviews] indexOfObject:self.cellFrontView] withSubviewAtIndex:[[self.contentView subviews] indexOfObject:self.cellBackView]];
    if (self.isCellBackViewHidden) {
        self.cellBackView.hidden = NO;
        self.cellFrontView.hidden = YES;
    }
    else {
        self.cellBackView.hidden = YES;
        self.cellFrontView.hidden = NO;
    }
    self.isCellBackViewHidden = !self.isCellBackViewHidden;
    [UIView commitAnimations];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [self.contentView removeGestureRecognizer:tapGesture];
}

@end
