//
//  ProductButtonHeaderView.m
//  SuningEBuy
//
//  Created by  on 12-9-13.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ProductButtonHeaderView.h"
#import "NSAttributedString+Attributes.h"

@implementation ProductButtonHeaderView

@synthesize addShoppingCartButton = _addShoppingCartButton;
@synthesize addFavoriteButton = _addFavoriteButton;
@synthesize easilyBuyButton = _easilyBuyButton;
@synthesize delegate = _delegate;
@synthesize seperaterView = _seperaterView;
@synthesize goToQiangguoDetail = _goToQiangguoDetail;
@synthesize priceLabel = _priceLabel;

- (void)dealloc {

    TT_RELEASE_SAFELY(_priceLabel);
    TT_RELEASE_SAFELY(_addFavoriteButton);
    TT_RELEASE_SAFELY(_seperaterView);
    TT_RELEASE_SAFELY(_addShoppingCartButton);
    TT_RELEASE_SAFELY(_goToQiangguoDetail);
    TT_RELEASE_SAFELY(_easilyBuyButton);
}

- (id)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
//        self.frame = CGRectMake(0, 0, 320, 65 + 44);
    }
    return self;
}

+ (CGFloat)height
{
    return 65;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (UIImageView *)seperaterView
{
    if (!_seperaterView)
    {
        _seperaterView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 2, 320, 2)];
        _seperaterView.image = [UIImage imageNamed:@"cellSeparatorLine.png"];
        [self addSubview:_seperaterView];
    }
    return _seperaterView;
}

- (UIButton *)addShoppingCartButton
{
    if (!_addShoppingCartButton)
    {
        _addShoppingCartButton = [[UIButton alloc] initWithFrame:CGRectMake(58, 9, 94, 44)];

        [_addShoppingCartButton addTarget:self action:@selector(addToShoppingCart:) forControlEvents:UIControlEventTouchUpInside];
                
        [_addShoppingCartButton setTitle:L(@"Add shopCart") forState:UIControlStateNormal]; 
        
        UIImage *image = [UIImage streImageNamed:@"blueButton.png"];
        [_addShoppingCartButton setBackgroundImage:image forState:UIControlStateNormal];
        
        UIImage *disAbledImage = [UIImage streImageNamed:@"grayButton.png"];        
        [_addShoppingCartButton setBackgroundImage:disAbledImage forState:UIControlStateDisabled];
        
        _addShoppingCartButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        
        [_addShoppingCartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
//        [_addShoppingCartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        
        [self addSubview:_addShoppingCartButton];
    }
    return _addShoppingCartButton;    
}


- (UIButton *)addFavoriteButton
{
    if (!_addFavoriteButton)
    {
        _addFavoriteButton = [[UIButton alloc] initWithFrame:CGRectMake(8, 9, 44, 44)];
        [_addFavoriteButton addTarget:self action:@selector(addToFavorite:) forControlEvents:UIControlEventTouchUpInside];     
        
        UIImageView *starView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star_Store.png"]];
        
        starView.frame = CGRectMake(7, 6, 30, 30);
        
        [_addFavoriteButton setBackgroundImage:[UIImage imageNamed:@"blueButton.png"] 
                                      forState:UIControlStateNormal];
        
        [_addFavoriteButton addSubview:starView];
        
        TT_RELEASE_SAFELY(starView);
        
        [self addSubview:_addFavoriteButton];
    }
    return _addFavoriteButton;
}

- (UIButton *)easilyBuyButton
{
    if (!_easilyBuyButton)
    {
        _easilyBuyButton = [[UIButton alloc]initWithFrame:CGRectMake(158, 9, 154, 44)];

        [_easilyBuyButton addTarget:self action:@selector(easilyBuy:) 
                   forControlEvents:UIControlEventTouchUpInside];
        UIImage *image = [UIImage streImageNamed:@"yellowButton.png"];
        [_easilyBuyButton setBackgroundImage:image forState:UIControlStateNormal];
        UIImage *disAbledImage = [UIImage streImageNamed:@"grayButton.png"];
        [_easilyBuyButton setBackgroundImage:disAbledImage forState:UIControlStateDisabled];
        
        [_easilyBuyButton setTitle:L(@"Product_BuyNow") forState:UIControlStateNormal];
        [_easilyBuyButton setTitleColor:RGBCOLOR(76, 55, 6) forState:UIControlStateNormal];
        
        [_easilyBuyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];

        _easilyBuyButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        
        [self addSubview:_easilyBuyButton];
    }
    return _easilyBuyButton;
}

- (UIButton *)goToQiangguoDetail
{
    if (!_goToQiangguoDetail) {
        _goToQiangguoDetail = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 300, 48)];

//        _goToQiangguoDetail.layer.cornerRadius = 5.0;
//        _goToQiangguoDetail.layer.borderColor = RGBCOLOR(179, 179, 179).CGColor;
//        _goToQiangguoDetail.layer.borderWidth = 1.0;
//        _goToQiangguoDetail.backgroundColor = RGBCOLOR(245, 245, 245);

//        [_goToQiangguoDetail setTitle:@"正在抢购" forState:UIControlStateNormal];
        
        _goToQiangguoDetail.backgroundColor = [UIColor clearColor];//RGBCOLOR(225, 223, 100);
    
        [_goToQiangguoDetail setBackgroundImage:[UIImage imageNamed:@"product_qianggou@2x.png"] forState:UIControlStateNormal];
        
        [_goToQiangguoDetail addTarget:self action:@selector(goToQiangguo:)
                   forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_goToQiangguoDetail];
    }
    return _goToQiangguoDetail;
}

- (OHAttributedLabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[OHAttributedLabel alloc] init];
        _priceLabel.textColor = [UIColor redColor];
        _priceLabel.textAlignment = NSTextAlignmentRight;
        [_priceLabel setFont:[UIFont boldSystemFontOfSize:20.0]];
        _priceLabel.backgroundColor = [UIColor clearColor];
        [self.goToQiangguoDetail addSubview:_priceLabel];
    }
    return _priceLabel;
}

- (void)setEnable:(BOOL)isEnable
{
    //设置加入购物车按钮是否可点
    self.addFavoriteButton.tag = 111;
    self.addShoppingCartButton.enabled = isEnable;
    self.easilyBuyButton.enabled = isEnable;
    
}

- (void)setEasilyEnable:(BOOL)ee addShopCartEnable:(BOOL)ae withRushPrice:(NSNumber *)price
{    
    self.addFavoriteButton.tag = 111;
    self.addShoppingCartButton.enabled = ae;
    self.easilyBuyButton.enabled = ee;
    if ([price floatValue] > 0) {
        self.addFavoriteButton.frame = CGRectMake(8, 9 + 50, 44, 44);
        self.addShoppingCartButton.frame = CGRectMake(58, 9 + 50, 94, 44);
        self.easilyBuyButton.frame = CGRectMake(158, 9 + 50, 154, 44);
        self.goToQiangguoDetail.hidden = NO;
        self.priceLabel.hidden = NO;
        self.goToQiangguoDetail.frame = CGRectMake(10, 5, 300, 50);
        self.priceLabel.frame = CGRectMake(100, 17, 180, 40);
        
        NSString * discountPrice = [NSString stringWithFormat:@"%@:￥%0.02f",L(@"discount"),[price floatValue]];
        NSMutableAttributedString *discountPriceAttStr =[[NSMutableAttributedString alloc] initWithString:discountPrice];
        [discountPriceAttStr setFont:[UIFont boldSystemFontOfSize:18.0]];
        [discountPriceAttStr setTextColor:[UIColor redColor]];
        [discountPriceAttStr setTextAlignment:kCTTextAlignmentRight lineBreakMode:kCTLineBreakByTruncatingHead];
        [discountPriceAttStr setTextColor:[UIColor blackColor] range:NSMakeRange(0, 4)];
        self.priceLabel.attributedText = discountPriceAttStr;
        TT_RELEASE_SAFELY(discountPriceAttStr);

        
//        self.priceLabel.text = [NSString stringWithFormat:@"抢购价:￥:%0.02f",[price floatValue]];
    }else{
        
        self.addFavoriteButton.frame = CGRectMake(8, 9, 44, 44);
        self.addShoppingCartButton.frame = CGRectMake(58, 9, 94, 44);
        self.easilyBuyButton.frame = CGRectMake(158, 9, 154, 44);
        self.goToQiangguoDetail.hidden = YES;
        self.priceLabel.hidden = YES;
    }

    self.seperaterView.frame = CGRectMake(0, self.bounds.size.height - 2, 320, 2);
}

- (void)addToShoppingCart:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(addToShoppingCart)]) {
        [_delegate addToShoppingCart];
    }
}

- (void)addToFavorite:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(addToFavorite)]) {
        [_delegate addToFavorite];
    }
}

//立即购  add by zj
- (void)easilyBuy:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(beginEasilyBuy)]) {
        [_delegate beginEasilyBuy];
    }
}

//去抢购详情
- (void)goToQiangguo:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(goToQiangGou)]) {
        [_delegate goToQiangGou];
    }   
}

@end
