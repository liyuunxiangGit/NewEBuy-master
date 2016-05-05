//
//  EvalutionListCell.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-4-9.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "EvalutionListCell.h"
#import "ProductUtil.h"

@implementation EvalutionListCell


@synthesize productImg = _productImg;
@synthesize productNameLbl = _productNameLbl;
@synthesize displayBtn = _displayBtn;
@synthesize evalutionBtn = _evalutionBtn;
@synthesize merchanStructDetail = _merchanStructDetail;
@synthesize cellSeperatorView = _cellSeperatorView;


- (void)dealloc
{

    TT_RELEASE_SAFELY(_merchanStructDetail);
    TT_RELEASE_SAFELY(_evalutionBtn);
    TT_RELEASE_SAFELY(_productImg);
    TT_RELEASE_SAFELY(_productNameLbl);
    TT_RELEASE_SAFELY(_displayBtn);
    TT_RELEASE_SAFELY(_cellSeperatorView);
    
}
-(EGOImageView *)productImg
{
    if(!_productImg)
    {
        _productImg = [[EGOImageView alloc] initWithFrame:CGRectMake(15, 15, 84, 84)];
//        _productImg.layer.cornerRadius = 5;
        _productImg.delegate = self;
        _productImg.backgroundColor = [UIColor whiteColor];
        
        _productImg.layer.borderWidth = 0.3;
        _productImg.layer.borderColor = RGBCOLOR(235, 235, 235).CGColor;
        _productImg.layer.masksToBounds = YES;
        
        _productImg.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];
        
        [self.contentView addSubview:_productImg];
    }
    
    return _productImg;
}

- (NSString *)reviewFlagStr{
    if (!_reviewFlagStr) {
        _reviewFlagStr = [[NSString alloc] init];
    }
    return _reviewFlagStr;
}

-(UILabel *)productNameLbl
{
    if(!_productNameLbl)
    {
        _productNameLbl = [[UILabel alloc]init];
            
        _productNameLbl.numberOfLines = 2;
//        _productNameLbl.lineBreakMode = NSLineBreakByCharWrapping;
        _productNameLbl.backgroundColor = [UIColor clearColor];
        
        _productNameLbl.textColor = RGBCOLOR(53, 53, 53);

                
        [self.contentView addSubview:_productNameLbl];
    }
    return  _productNameLbl;
}

- (UILabel *)supplierNameLbl
{
    if (!_supplierNameLbl)
    {
        _supplierNameLbl = [[UILabel alloc] init];
        
        _supplierNameLbl.backgroundColor = [UIColor clearColor];
        
        _supplierNameLbl.numberOfLines = 2;
        
        _supplierNameLbl.textColor = RGBCOLOR(151, 151, 151);
        
        _supplierNameLbl.font = [UIFont systemFontOfSize:12];
        
        [self.contentView addSubview:_supplierNameLbl];
    }
    return _supplierNameLbl;
}

- (UILabel *)priceLbl
{
    if (!_priceLbl) {
        _priceLbl = [[UILabel alloc] init];
        
        _priceLbl.backgroundColor = [UIColor clearColor];
		_priceLbl.textColor = [UIColor colorWithRGBHex:0xFF0000];
		_priceLbl.font = [UIFont systemFontOfSize:17];
        _priceLbl.text = @"￥";
		_priceLbl.autoresizingMask = UIViewAutoresizingNone;
        _priceLbl.hidden = YES;
		[self.contentView addSubview:_priceLbl];
    }
    return _priceLbl;
}

- (EGOImageView *)priceImg
{
    if (!_priceImg) {
        _priceImg = [[EGOImageView alloc] init];
		_priceImg.backgroundColor = [UIColor clearColor];
        _priceImg.contentMode = UIViewContentModeLeft;
        _priceImg.placeholderImage = nil;
        _priceImg.refreshCached = YES;
        _priceImg.hidden = YES;
		[self.contentView addSubview:_priceImg];
    }
    return _priceImg;
}

-(UIButton *) evalutionBtn
{
    if(!_evalutionBtn)
    {
        _evalutionBtn = [[UIButton alloc]init];
        
        [_evalutionBtn setExclusiveTouch:YES];
                
        [_evalutionBtn setTitleColor:RGBCOLOR(56, 51, 39) forState:UIControlStateNormal];
        
        _evalutionBtn.backgroundColor = [UIColor clearColor];
        
//        _evalutionBtn.userInteractionEnabled = NO;
//        [_evalutionBtn setUserInteractionEnabled:YES];
        
//        UIImage *bgImage = [UIImage newImageFromResource:@"evalution_btn_click.png"];
//        
//        [_evalutionBtn setBackgroundImage:bgImage forState:UIControlStateHighlighted];
//        
//        TT_RELEASE_SAFELY(bgImage);
        
//        [_evalutionBtn setBackgroundImage:[UIImage imageNamed:@"right_item_btn.png"] forState:UIControlStateNormal];
        
        [_evalutionBtn setTitle:L(@"Evaluation") forState:UIControlStateNormal];
        [_evalutionBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        
        [self.contentView addSubview:_evalutionBtn];
    }
    
    return  _evalutionBtn;
}


-(UIButton *) displayBtn
{
    if(!_displayBtn)
    {
        _displayBtn = [[UIButton alloc]init];
        
        [_displayBtn setExclusiveTouch:YES];
                
        [_displayBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        
        _displayBtn.backgroundColor = [UIColor clearColor];
        
//        UIImage *bgImage = [UIImage newImageFromResource:@"evalution_btn_click.png"];
//        
//        [_displayBtn setBackgroundImage:bgImage forState:UIControlStateHighlighted];
//        
//        TT_RELEASE_SAFELY(bgImage);
        
        [_displayBtn setBackgroundImage:[UIImage imageNamed:@"right_item_btn.png"] forState:UIControlStateNormal];
        
        [_displayBtn setTitle:L(@"HDisplayOrder") forState:UIControlStateNormal];
        [_displayBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        
        [self.contentView addSubview:_displayBtn];
    }
    
    return  _displayBtn;
}

- (UIImageView *)seperateLineImg
{
    if (!_seperateLineImg) {
        _seperateLineImg = [[UIImageView alloc] init];
        
        _seperateLineImg.image = [UIImage imageNamed:@"line.png"];
        
        [self.contentView addSubview:_seperateLineImg];
    }
    return _seperateLineImg;
}

//- (UIImageView *)cellSeperatorView{
//    
//    if (!_cellSeperatorView) {
//        
//        _cellSeperatorView = [[UIImageView alloc] init];
//        
//        UIImage *cellSeperatorImage = [UIImage newImageFromResource:@"cellSeparatorLine.png"];
//        
//        _cellSeperatorView.image = cellSeperatorImage;
//        
//        TT_RELEASE_SAFELY(cellSeperatorImage);
//                
//        _cellSeperatorView.contentMode = UIViewContentModeScaleAspectFill;
//        
//        [self.contentView addSubview:_cellSeperatorView];
//    }
//    
//    return _cellSeperatorView;
//}

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier{
	
	if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
		
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		self.autoresizesSubviews = YES;
		
		self.contentView.backgroundColor = [UIColor clearColor];
	}
	return self;
}

-(void)setMerchanStructDetail:(EvalutionDetailDTO *)merchanStructDetail
{
    _merchanStructDetail = merchanStructDetail;
    
    self.productImg.imageURL = merchanStructDetail.productUrl;
    self.productNameLbl.text = merchanStructDetail.catentryName;
    self.reviewFlagStr = merchanStructDetail.reviewFlag;
    
    self.supplierNameLbl.text = merchanStructDetail.supplierName;
    
    NSString *cityId = [Config currentConfig].defaultCity;
    self.priceImg.imageURL = [ProductUtil priceImageUrlOfProductId:merchanStructDetail.catentryId city:cityId];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIFont *cellFont =[UIFont systemFontOfSize:14.0];
    
    self.productNameLbl.font = cellFont;
    
    //        CGSize labelHeight = [_productNameLbl.text sizeWithFont:cellFont];
    
//    CGSize mainContendSize = [self.productNameLbl.text sizeWithFont:cellFont
//                                                  constrainedToSize:CGSizeMake(200, 10000)
//                                                      lineBreakMode:NSLineBreakByCharWrapping];
//    
    
        
    self.productNameLbl.frame = CGRectMake(112, 15, 193, 40);
    self.productNameLbl.text = self.productNameLbl.text;
    
    self.supplierNameLbl.frame = CGRectMake(112, 86, 200, 15);
    self.supplierNameLbl.text = self.supplierNameLbl.text;

    self.seperateLineImg.frame = CGRectMake(0, 162.5, 320, 0.5);
    
    self.productImg.frame = CGRectMake(15, 15, 84, 84);
    
    self.priceLbl.frame = CGRectMake(112, 65, 150, 20);
    self.priceImg.frame = CGRectMake(127, 65, 150, 16);
    
    self.evalutionBtn.frame = CGRectMake(218, 113, 87, 35);
    self.displayBtn.frame = CGRectMake(115, 113, 87, 35);

//    self.cellSeperatorView.frame = CGRectMake(0, self.bounds.size.height - 1, 320, 1);

}



@end
