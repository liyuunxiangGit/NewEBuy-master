//
//  AllOrderListPageFreshViewController.m
//  SuningEBuy
//
//  Created by xmy on 13/2/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "AllOrderListPageFreshViewController.h"

@interface AllOrderListPageFreshViewController ()

@end

@implementation AllOrderListPageFreshViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UILabel*)alertPageFreshLbl
{
    if(!_alertPageFreshLbl)
    {
        _alertPageFreshLbl = [[UILabel alloc] init];
        _alertPageFreshLbl.font = [UIFont systemFontOfSize:17];
        _alertPageFreshLbl.backgroundColor = [UIColor clearColor];
        _alertPageFreshLbl.frame = CGRectMake(0, self.alertPageFreshImageV.bottom+15, self.view.frame.size.width, 30);
        _alertPageFreshLbl.textAlignment = UITextAlignmentCenter;
        _alertPageFreshLbl.textColor = [UIColor colorWithRGBHex:0x313131];
        _alertPageFreshLbl.hidden = YES;
        [self.view addSubview:_alertPageFreshLbl];
    }
    return _alertPageFreshLbl;
}

- (UIImageView*)alertPageFreshImageV
{
    if(!_alertPageFreshImageV)
    {
        _alertPageFreshImageV = [[UIImageView alloc] init];
        
        _alertPageFreshImageV.image = [UIImage imageNamed:@"order_NoOrder.png"];
        
        _alertPageFreshImageV.frame = CGRectMake(116.5, self.view.frame.size.height/2-76-46, 77, 76);
        
        _alertPageFreshImageV.hidden = YES;
        
        [self.view addSubview:_alertPageFreshImageV];
        
    }
    
    return _alertPageFreshImageV;
}

- (void)updateView
{
    
}


#pragma mark -- 订单中心列表界面高度设置
- (CGRect)setViewFrame:(BOOL)hasNav
{
    CGRect newframe = self.view.frame;
    
    if(hasNav == NO)
    {
        //        origin=(x=0, y=0) size=(width=320, height=548)
        newframe = CGRectMake(newframe.origin.x, newframe.origin.y, newframe.size.width, newframe.size.height-48);
    }
    else
    {
        //        origin=(x=0, y=0) size=(width=320, height=504)
        CGRect  frame = CGRectMake(newframe.origin.x, newframe.origin.y, newframe.size.width, newframe.size.height-48);
        
        return frame;
    }
    
    
    return newframe;
}

//tab，有bottomview但不展示hastab为Yes no则展示
- (CGRect)setViewFrame:(BOOL)hasNav WithTab:(BOOL)hastab
{
    CGRect newframe = self.view.frame;

    if(hastab == YES)
    {
        return newframe;

    }
    else
    {
        if(hasNav == NO)
        {
            //        origin=(x=0, y=0) size=(width=320, height=548)
            newframe = CGRectMake(newframe.origin.x, newframe.origin.y, newframe.size.width, newframe.size.height-48);
        }
        else
        {
            //        origin=(x=0, y=0) size=(width=320, height=504)
            CGRect  frame = CGRectMake(newframe.origin.x, newframe.origin.y, newframe.size.width, newframe.size.height-48);
            
            return frame;
        }
    }
    
    
    return newframe;
}


@end
