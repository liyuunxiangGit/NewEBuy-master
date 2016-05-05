//
//  NOrderContactCell.m
//  SuningEBuy
//
//  Created by  liukun on 13-12-24.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NOrderContactCell.h"

@implementation NOrderContactCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        CGSize sz = self.contentView.frame.size;
        self.lineView = [[UIImageView alloc] initWithFrame:CGRectMake(.0f,39.0f,sz.width,1.0f)];
        [_lineView setImage:[UIImage streImageNamed:@"line.png"]];
        [self.contentView addSubview:_lineView];
        
        self.lineView2.frame = CGRectMake(150-10, 5, 1, 30);
        if(IOS7_OR_LATER)
        {
            
        }
        else
        {
            self.backgroundColor = [UIColor whiteColor];
            self.contentView.backgroundColor = [UIColor whiteColor];
        }
        
    }
    return self;
}

//- (void)drawRect:(CGRect)rect {
//    [super drawRect:rect];
//    
//    [self bringSubviewToFront:_lineView];
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (UIImageView*)lineView1
{
    if(!_lineView1)
    {
        _lineView1 = [[UIImageView alloc] init];
        
        _lineView1.backgroundColor = [UIColor clearColor];
        
        _lineView1.frame = CGRectMake(0, 39.5, 320, 0.5);
        
        [_lineView1 setImage:[UIImage streImageNamed:@"line.png"]];
        
        [self.contentView addSubview:_lineView1];
    }
    
    return _lineView1;
    
}
- (UIButton *)cShopConnect
{
    
    if (!_cShopConnect)
    {
        _cShopConnect = [[UIButton alloc]init];
        _cShopConnect.frame = CGRectMake((300-150)/2, 10, 150, 32);
        _cShopConnect.backgroundColor = [UIColor clearColor];
        [_cShopConnect setImage:[UIImage imageNamed:@"Cdian-hewolianxi-normal.png"] forState:UIControlStateNormal];
        //[_cShopConnect setBackgroundImage:[UIImage imageNamed:@"Cdian-hewolianxi-Press.png"] forState:UIControlStateHighlighted];
        [self.contentView addSubview:_cShopConnect];
    }
    
    return _cShopConnect;
}

- (UIButton *)shopConnect
{
    
    if (!_shopConnect)
    {
        
        _shopConnect = [[UIButton alloc]init];
        
        _shopConnect.frame = CGRectMake(10-2, 10, 130, 32);
        _shopConnect.backgroundColor = [UIColor clearColor];
        [_shopConnect setImage:[UIImage imageNamed:kOS_hewolianxi_normal_image] forState:UIControlStateNormal];
        [_shopConnect setImage:[UIImage imageNamed:kOS_hewolianxi_normal_image_clicked] forState:UIControlStateHighlighted];
        [_shopConnect setImage:[UIImage imageNamed:kOS_hewolianxi_disable_iamge] forState:UIControlStateDisabled];
        _shopConnect.hidden = YES;
        
        [self.contentView addSubview:_shopConnect];
    }
    
    return _shopConnect;
}

-(UIButton *)Phone
{
    if (!_Phone)
    {
        
        _Phone = [[UIButton alloc]init];
        
        _Phone.frame = CGRectMake(150-2-2, 10+7-1, 149, 18.5);
        
        _Phone.backgroundColor = [UIColor clearColor];
        [_Phone setImage:[UIImage imageNamed:@"ziyingdian-dianhua-normal.png"] forState:UIControlStateNormal];
        if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://4008365365"]])
        {
            _Phone.enabled = NO;
        }
        
        _Phone.hidden = YES;
        
        [self.contentView addSubview:_Phone];
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
        
        
        [self.contentView addSubview:_lineView2];
    }
    
    return _lineView2;
    
}

- (void)setPhone:(BOOL)isCShop status:(int)status
{
    self.Phone.frame = CGRectMake((300-150)/2, 0, 150, 40);
    self.Phone.hidden = NO;
    self.lineView2.hidden = YES;
    if (_isLineView1)
    {
        self.lineView1.frame = CGRectMake(0, 0, self.frame.size.width, 0.5);
        self.shopConnect.hidden = YES;
        _lineView2.hidden = YES;
    }
    
//    self.Phone.enabled = YES;
}


- (void)setState:(BOOL)isCShop status:(int)status
{
    if (isCShop)
    {
        _shopConnect.hidden = YES;
        _Phone.hidden = YES;
        self.cShopConnect.hidden = NO;
        _lineView2.hidden = YES;
        _lineView.hidden =NO;
        
        if (status == 1)
        {
            [_cShopConnect setImage:[UIImage imageNamed:kOS_hewolianxi_normal_image] forState:UIControlStateNormal];
            [_cShopConnect setImage:[UIImage imageNamed:kOS_hewolianxi_normal_image_clicked] forState:UIControlStateHighlighted];
        }
        else if (status == 0)
        {
            [_cShopConnect setImage:[UIImage imageNamed:kOS_lixianliuyan_image] forState:UIControlStateNormal];
            [_cShopConnect setImage:[UIImage imageNamed:kOS_lixianliuyan_image_clicked] forState:UIControlStateHighlighted];
        }
        else
        {
            self.cShopConnect.hidden = YES;
        }
    }
    else
    {
        self.shopConnect.hidden = NO;
        self.Phone.hidden = NO;
        _cShopConnect.hidden = YES;
        _lineView2.hidden = NO;
        _lineView.hidden =NO;
        
        if (status == 1)
        {
            self.shopConnect.enabled = YES;
        }
        else if (status == 0)
        {
            self.shopConnect.enabled = NO;
        }
        else
        {
            self.Phone.frame = CGRectMake((300-150)/2, 10, 150, 32);
            self.shopConnect.hidden = YES;
            _lineView2.hidden = YES;
        }
    }
    if (_isLineView1)
    {
        self.lineView1.frame = CGRectMake(0, 0, self.frame.size.width, 0.5);
    }
}

+ (CGFloat)height
{
    return 40;
}

@end
