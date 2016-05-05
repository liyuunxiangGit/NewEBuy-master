//
//  ReturnGoodsOrderInfoCell.m
//  SuningEBuy
//
//  Created by 漫 王 on 12-9-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ReturnGoodsOrderInfoCell.h"
#import "ProductUtil.h"

#define   DefaultCellHeight      20.0f
#define   DefaultFont            [UIFont boldSystemFontOfSize:15.0]
#define   DefaultColor           RGBCOLOR(46, 46, 46)



@implementation ReturnGoodsOrderInfoCell

@synthesize productName = _productName;

@synthesize serviceType  = _serviceType;

@synthesize productPayTime = _productPayTime;

@synthesize orderNum = _orderNum;

@synthesize item = _item;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_item);
    
    TT_RELEASE_SAFELY(_orderNum);
    
    TT_RELEASE_SAFELY(_productPayTime);
    
    TT_RELEASE_SAFELY(_serviceType);
    
    TT_RELEASE_SAFELY(_productName);
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
		
        self.backgroundColor = [UIColor cellBackViewColor];
        
		self.autoresizesSubviews = YES;
    }
    return self;
}

- (UILabel *)orderNum
{
    
    if (!_orderNum)
    {
        _orderNum = [[UILabel alloc] init];
        _orderNum.backgroundColor = [UIColor clearColor];
        
        _orderNum.font = [UIFont systemFontOfSize:14.0];
        
        _orderNum.textColor = RGBCOLOR(46, 46, 46);
        _orderNum.numberOfLines = 0;
        
        [self.contentView addSubview:_orderNum];
    }
    
    return _orderNum;
}


- (UILabel *)productPayTime
{
    
    if (!_productPayTime)
    {
        _productPayTime = [[UILabel alloc] initWithFrame:CGRectMake(10, 5+DefaultCellHeight, 280, DefaultCellHeight)];
        
        _productPayTime.backgroundColor = [UIColor clearColor];
        
        _productPayTime.font = DefaultFont;
        
        _productPayTime.textColor = DefaultColor;
        
        [self.contentView addSubview:_productPayTime];
    }
    
    return _productPayTime;
}


- (UILabel *)productName
{
    
    if (!_productName)
    {
        _productName = [[UILabel alloc] initWithFrame:CGRectMake(10, 5+DefaultCellHeight *2, 280, DefaultCellHeight)];
        
        _productName.backgroundColor = [UIColor clearColor];
        
        _productName.font = DefaultFont;
        
        _productName.textColor = DefaultColor;
        
        [self.contentView addSubview:_productName];
    }
    
    return _productName;
}


- (UILabel *)serviceType
{
    
    if (!_serviceType)
    {
        _serviceType = [[UILabel alloc] initWithFrame:CGRectMake(10, 5+DefaultCellHeight * 3, 280, DefaultCellHeight)];
        
        _serviceType.backgroundColor = [UIColor clearColor];
        
        _serviceType.font = DefaultFont;
        
        _serviceType.textColor = DefaultColor;
        
        [self.contentView addSubview:_serviceType];
    }
    
    return _serviceType;
}

- (UIButton *)cShopConnect
{
    
    if (!_cShopConnect)
    {
        _cShopConnect = [[UIButton alloc]init];
        _cShopConnect.frame = CGRectMake(30+20+10+10, 3, 149, 18.5);
        _cShopConnect.backgroundColor = [UIColor clearColor];
        
        [_cShopConnect setImage:[UIImage imageNamed:kOS_hewolianxi_normal_image_clicked] forState:UIControlStateNormal];
       
        [self.connectView2 addSubview:_cShopConnect];
    }
    
    return _cShopConnect;
}

- (UIButton *)shopConnect
{
    
    if (!_shopConnect)
    {
        
        _shopConnect = [[UIButton alloc]init];
        
        _shopConnect.frame = CGRectMake(0, 0+10+2, 149, 18.5);
        _shopConnect.backgroundColor = [UIColor clearColor];
        [_shopConnect setImage:[UIImage imageNamed:kOS_hewolianxi_normal_image] forState:UIControlStateNormal];
        [_shopConnect setImage:[UIImage imageNamed:kOS_hewolianxi_normal_image_clicked] forState:UIControlStateHighlighted];
        [_shopConnect setImage:[UIImage imageNamed:kOS_hewolianxi_disable_iamge] forState:UIControlStateDisabled];
        
        
        [self.connectView1 addSubview:_shopConnect];
    }
    
    return _shopConnect;
}

-(UIView *)connectView1
{
    if (!_connectView1) {
        _connectView1 = [[UIView alloc]init];
        _connectView1.backgroundColor= [UIColor clearColor];
        [self.contentView addSubview:_connectView1];
        
    }
    return _connectView1;
}

-(UIView *)connectView2
{
    if (!_connectView2) {
        _connectView2 = [[UIView alloc]init];
        _connectView2.backgroundColor= [UIColor clearColor];
        [self.contentView addSubview:_connectView2];
    }
    return _connectView2;
}

-(UIButton *)Phone
{
    if (!_Phone)
    {
        _Phone = [[UIButton alloc]init];
        
        _Phone.frame = CGRectMake(150-5, 0+10+2, 149, 18.5);
        
        _Phone.backgroundColor = [UIColor clearColor];
        [_Phone setImage:[UIImage imageNamed:@"ziyingdian-dianhua-normal.png"] forState:UIControlStateNormal];
        
        [self.connectView1 addSubview:_Phone];
        
        if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://4008365365"]])
        {
            _Phone.enabled = NO;
        }
    }
    
    return _Phone;
}

- (UIImageView*)lineView2
{
    if(!_lineView2)
    {
        _lineView2 = [[UIImageView alloc] init];
        
        _lineView2.backgroundColor = [UIColor clearColor];
        
        [_lineView2 setImage:[UIImage streImageNamed:@"line.png"] ];
        
        
        [self.connectView1 addSubview:_lineView2];
        [self.connectView1 bringSubviewToFront:_lineView2];
    }
    
    return _lineView2;
    
}

- (UIImageView*)lineView
{
    if(!_lineView)
    {
        _lineView = [[UIImageView alloc] init];
        
        _lineView.backgroundColor = [UIColor clearColor];
        
        //_lineView.contentMode = UIViewContentModeScaleAspectFill;
        
        [_lineView setImage:[UIImage streImageNamed:@"line.png"]];
        
        [self.contentView addSubview:_lineView];
    }
    
    return _lineView;
    
}

+ (CGFloat)height:(ReturnGoodsQueryDTO *)item status:(int)status
{
    NSString *orderNumLblT = [NSString stringWithFormat:@"%@: %@\n\n%@: %@\n\n%@: %@\n\n%@: %@",L(@"MyEBuy_OrderId"),item.orderId?item.orderId:@"",L(@"MyEBuy_SubmissionTime"),item.submitTime?item.submitTime:@"",L(@"MyEBuy_ProductName"),item.productName?item.productName:@"",L(@"MyEBuy_ServiceType"),item.serviceType?item.serviceType:@""];
    CGSize size = [orderNumLblT sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(280,10000.0f)lineBreakMode:UILineBreakModeWordWrap];
    
    if (item.vendorCode.trim.length == 0)
    {
        //非C店
        return 10 + size.height + 20 + 32 + 10;
    }
    else
    {
        if (status == -1)
        {
            //不展示
            return 10 + size.height + 10;
        }
        else
        {
            return 10 + size.height + 20 + 32 + 10;
        }
    }
}

- (void)setItem:(ReturnGoodsQueryDTO *)item status:(int)status
{
    
    if (item == nil) {
        
        return;
    }
    
    if (item != _item) {
        
        _item = item;
        
    }
    
    NSString *orderNumLblT = [NSString stringWithFormat:@"%@: %@\n\n%@: %@\n\n%@: %@\n\n%@: %@",L(@"MyEBuy_OrderId"),item.orderId?item.orderId:@"",L(@"MyEBuy_SubmissionTime"),item.submitTime?item.submitTime:@"",L(@"MyEBuy_ProductName"),item.productName?item.productName:@"",L(@"MyEBuy_ServiceType"),item.serviceType?item.serviceType:@""];
    CGSize size = [orderNumLblT sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(280,10000.0f)lineBreakMode:UILineBreakModeWordWrap];
    self.orderNum.frame = CGRectMake(10, 10, size.width, size.height);
    self.orderNum.text = orderNumLblT;
    self.lineView.frame = CGRectMake(10, self.orderNum.bottom+10+2, 280, 1);
    self.connectView1.frame = CGRectMake(0, self.orderNum.bottom+20-5-2, 320, 32);
    self.connectView2.frame = CGRectMake(0, self.orderNum.bottom+20, 320, 32);
    self.lineView2.frame = CGRectMake(150-10, 0, 1, 48);
    
    
    self.lineView.hidden = NO;
    if (self.item.vendorCode.trim.length == 0)
    {
        //自营
        [self Phone];
        self.connectView1.hidden = NO;
        self.connectView2.hidden = YES;
        
        if (status == 1)
        {
            self.shopConnect.enabled = YES;
        }
        else
        {
            self.shopConnect.enabled = NO;
            //不展示
//            self.connectView1.hidden = YES;
//            self.connectView2.hidden = YES;
//            self.lineView.hidden = YES;
        }
    }
    else
    {
        [self cShopConnect];
        if (status == 0)
        {
            self.connectView1.hidden = YES;
            self.connectView2.hidden = NO;
            [_cShopConnect setImage:[UIImage imageNamed:kOS_lixianliuyan_image_clicked] forState:UIControlStateNormal];
            
        }
        else if (status == 1)
        {
            self.connectView1.hidden = YES;
            self.connectView2.hidden = NO;
            [_cShopConnect setImage:[UIImage imageNamed:kOS_hewolianxi_normal_image_clicked] forState:UIControlStateNormal];
        }
        else
        {
            //不展示
            self.connectView1.hidden = YES;
            self.connectView2.hidden = YES;
            self.lineView.hidden = YES;
        }
    }
}

#pragma mark -------- 234新界面

-(EGOImageButton *)iconImageView{
    
    if (!_iconImageView) {
        _iconImageView = [[EGOImageButton alloc]init];
        _iconImageView.backgroundColor = [UIColor clearColor];
        _iconImageView.layer.borderColor = RGBCOLOR(220, 220, 220).CGColor;
        _iconImageView.layer.borderWidth = .5;
        [self.contentView addSubview:_iconImageView];
    }
    return _iconImageView;
}

- (void)setLblProtery:(UILabel*)lbl
{
    lbl.textColor = [UIColor colorWithRGBHex:0x313131];
    
    lbl.backgroundColor = [UIColor clearColor];
    
    lbl.font = [UIFont systemFontOfSize:13];
    
    lbl.textAlignment = UITextAlignmentLeft;
    
}


- (void)setContextLblProtery:(UILabel*)lbl
{
    lbl.textColor = [UIColor dark_Gray_Color];
    
    lbl.backgroundColor = [UIColor clearColor];
    
    lbl.font = [UIFont systemFontOfSize:13];
    
    lbl.textAlignment = UITextAlignmentRight;
    
    lbl.lineBreakMode = UILineBreakModeCharacterWrap;
    
    lbl.numberOfLines = 0;
    
}

-(UILabel *)productNameLbl{
    
    if (!_productNameLbl) {
        _productNameLbl = [[UILabel alloc]init];
        _productNameLbl.backgroundColor = [UIColor clearColor];
        _productNameLbl.font = [UIFont systemFontOfSize:13];
        _productNameLbl.textColor = [UIColor colorWithRGBHex:0x313131];
        _productNameLbl.numberOfLines = 2;
        _productNameLbl.lineBreakMode = UILineBreakModeTailTruncation;
        [self.contentView addSubview:_productNameLbl];
    }
    return _productNameLbl;
}

-(UILabel *)supplierLbl{
    
    if (!_supplierLbl) {
        _supplierLbl = [[UILabel alloc]init];
        _supplierLbl.backgroundColor = [UIColor clearColor];
        _supplierLbl.font = [UIFont systemFontOfSize:12];
        _supplierLbl.textColor = [UIColor dark_Gray_Color];
        [self.contentView addSubview:_supplierLbl];
    }
    return _supplierLbl;
}

- (void)setNewItem:(ReturnGoodsQueryDTO *)item status:(int)status
{
    
    
    if(IsNilOrNull(item))
    {
        return;
    }
    
    if (item != _item) {
        
        _item = item;
        
    }
    
    self.iconImageView.frame = CGRectMake(15, 12, 85, 85);
    
    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
        
        self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:item.productCode size:ProductImageSize160x160];
    }
    else{
        
        self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:item.productCode size:ProductImageSize120x120];
    }
    
  
    int nameLines = [self setProNameHeight:item.productName WithLbl:self.productNameLbl];
    
    self.productNameLbl.numberOfLines = 3;
    if(nameLines == 1)
    {
        self.productNameLbl.frame = CGRectMake(self.iconImageView.right+10, 16, 190, 15);
        
    }
    else
    {
        self.productNameLbl.frame = CGRectMake(self.iconImageView.right+10, 10, 190, 40);
        
        
    }
    
    self.productNameLbl.text = item.productName;
    
    
    self.supplierLbl.frame = CGRectMake(self.iconImageView.right+10, 75, 180, 20);
    
    if (IsStrEmpty(item.vendorCode))
    {
        self.supplierLbl.text = [NSString stringWithFormat:@"%@",L(@"MyEBuy_SuningSelf")];
    }
    else{
        self.supplierLbl.text = item.vendorName?item.vendorName:@"";
    }
    
//    self.lineView.frame = CGRectMake(10, self.orderNum.bottom+10+2, 280, 1);
//    self.connectView1.frame = CGRectMake(0, self.orderNum.bottom+20-5-2, 320, 32);
//    self.connectView2.frame = CGRectMake(0, self.orderNum.bottom+20, 320, 32);
    
    self.lineView.frame = CGRectMake(10, 109.5+10+2, 280, 0.5);
    self.connectView1.frame = CGRectMake(0, 109.5+20-5-2, 320, 32);
    self.connectView2.frame = CGRectMake(0, 109.5+20, 320, 32);

    self.lineView2.frame = CGRectMake(150-10, 0, 1, 48);
    
    
    self.lineView.hidden = NO;
    if (self.item.vendorCode.trim.length == 0)
    {
        //自营
        [self Phone];
        self.connectView1.hidden = NO;
        self.connectView2.hidden = YES;

        if (status == 1)
        {
            self.shopConnect.enabled = YES;
        }
        else if (status == 0)
        {
            self.shopConnect.enabled = NO;
//            //不展示
//            self.connectView1.hidden = YES;
//            self.connectView2.hidden = YES;
//            self.lineView.hidden = YES;
        }
        else
        {
            self.shopConnect.hidden = YES;
            self.Phone.frame = CGRectMake(30+20+10+10, 10, 149, 32);
            _lineView2.hidden = YES;
        }
    }
    else
    {
        [self cShopConnect];
        if (status == 0)
        {
            self.connectView1.hidden = YES;
            self.connectView2.hidden = NO;
            [_cShopConnect setImage:[UIImage imageNamed:kOS_lixianliuyan_image_clicked] forState:UIControlStateNormal];
            
        }
        else if (status == 1)
        {
            self.connectView1.hidden = YES;
            self.connectView2.hidden = NO;
            [_cShopConnect setImage:[UIImage imageNamed:kOS_hewolianxi_normal_image_clicked] forState:UIControlStateNormal];
        }
        else
        {
            //不展示
            self.connectView1.hidden = YES;
            self.connectView2.hidden = YES;
            self.lineView.hidden = YES;
        }
    }
}

+ (CGFloat)heightNewCell:(ReturnGoodsQueryDTO *)item status:(int)status
{
   if(IsNilOrNull(item))
   {
       return 0;
   }
    
    if (item.vendorCode.trim.length == 0)
    {
        //非C店
//        if (status == 1) {
            return  110 + 20 + 32 + 10;
//        }
//        else
//        {
//            return 110;
//        }
        
    }
    else
    {
        if (status == -1)
        {
            //不展示
            return 110;
        }
        else
        {
            return 110 + 20 + 32 + 10;
        }
    }
}


@end
