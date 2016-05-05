//
//  NDetailFirstCell.m
//  SuningEBuy
//
//  Created by xmy on 2/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NDetailFirstCell.h"

@implementation NDetailFirstCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.alpha = 0;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIImageView*)proNameBackView
{
    if(!_proNameBackView)
    {
        _proNameBackView = [[UIImageView alloc] init];
        
        _proNameBackView.backgroundColor = [UIColor blackColor];//[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        
        _proNameBackView.alpha = 0;
        
        [_proNameBackView setImage:[UIImage imageNamed:nil]];
        
        _proNameBackView.userInteractionEnabled = YES;
        
    }
    
    return _proNameBackView;
}

- (void)setLblProtery:(UILabel*)lbl
{
    
    lbl.backgroundColor = [UIColor clearColor];
    
    lbl.font = [UIFont systemFontOfSize:12];
    
    lbl.textColor = [UIColor colorWithRGBHex:0x666666];
    
    lbl.textAlignment = UITextAlignmentLeft;
    
    lbl.numberOfLines = 2;
    
    lbl.hidden = NO;
    
}

- (UILabel*)productNameLbl
{
    if(!_productNameLbl)
    {
        _productNameLbl = [[UILabel alloc] init];
        
        [self setLblProtery:_productNameLbl];
        
        _productNameLbl.numberOfLines = 2;
        
        _productNameLbl.lineBreakMode = UILineBreakModeCharacterWrap;
        
        _productNameLbl.textColor = [UIColor whiteColor];
        
        _productNameLbl.font = [UIFont systemFontOfSize:15];
        
    }
    
    return _productNameLbl;
}

- (UIButton *)collectBtn{
    
    if (!_collectBtn) {
        
        _collectBtn = [[UIButton alloc] init];
        
        [_collectBtn addTarget:self action:@selector(addToFavorite:) forControlEvents:UIControlEventTouchUpInside];
        
        _collectBtn.hidden = YES;
        
        [_collectBtn setBackgroundImage:[UIImage imageNamed:@"star_Store.png"] forState:UIControlStateNormal];
    }
    
    return _collectBtn;
}

- (UIButton *)shareBtn
{
    if (!_shareBtn) {
        _shareBtn = [[UIButton alloc] init];
        
//        [_shareBtn addTarget:self action:@selector(gotoShare) forControlEvents:UIControlEventTouchUpInside];
        
        [_shareBtn setBackgroundImage:[UIImage imageNamed:@"productDetail_wifi_share.png"] forState:UIControlStateNormal];
        
        [_shareBtn setBackgroundImage:[UIImage imageNamed:@"productDetail_wifi_share_clicked.png"] forState:UIControlStateSelected];
    }
    return _shareBtn;
}

- (void)setNDetailFirstCell:(DataProductBasic *)dto WithCollectFlag:(NSString *)collectFlag WithType:(int)type
{    

    [self.contentView addSubview:self.proNameBackView];
    
    [self.proNameBackView addSubview:self.productNameLbl];
    
    [self.proNameBackView addSubview:self.collectBtn];
    
//    [self.proNameBackView addSubview:self.shareBtn];
    
    self.productNameLbl.text = dto.productName;
    
    self.proNameBackView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, 39.5);
    
    self.productNameLbl.frame = CGRectMake(10, 5, 260, 34);
    
    self.collectBtn.frame = CGRectMake(self.productNameLbl.right + 5, 5, 30, 30);
    
//    self.shareBtn.frame = CGRectMake(self.collectBtn.right, 5, 30, 30);
    
    if ([collectFlag isEqualToString:@"1"]) {
        [self.collectBtn setBackgroundImage:[UIImage imageNamed:@"N_CollectYellow.png"] forState:UIControlStateNormal];
    }else{
        [self.collectBtn setBackgroundImage:[UIImage imageNamed:@"N_CollectGray.png"] forState:UIControlStateNormal];
    }
    
    if(dto.isCShop == YES)
    {
        
        self.collectBtn.hidden = YES;
        self.productNameLbl.frame = CGRectMake(10, 5, 300, 34);
        
    }
    else
    {
        if(type == 1)
        {
            self.collectBtn.hidden = NO;
            self.productNameLbl.frame = CGRectMake(10, 5, 260, 34);
        }
        else
        {
            self.collectBtn.hidden = YES;
            self.productNameLbl.frame = CGRectMake(10, 5, 300, 34);
            
        }
        
    }
    

}

+ (CGFloat)NDetailFirstCelllHeight:(DataProductBasic *)dataDto WithMore:(BOOL)isMore
{
    return 40;
}


- (void)addToFavorite:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(addToFavorite)]) {
        
        [self.delegate addToFavorite];
    }
}

@end
