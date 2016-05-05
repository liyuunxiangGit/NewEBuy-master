//
//  MyEbuyCenterButtonsView.m
//  SuningEBuy
//
//  Created by shasha on 12-8-30.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "MyEbuyCenterButtonsView.h"

@implementation MyEbuyCenterButtonsView
@synthesize delegate = _delegate;

- (id)init {
    self = [super init];
    if (self) {
        
        [self initBtnAndLblList:0];
        
        self.isPressed = NO;
        
        
    }
    return self;
}

- (void)dealloc {
    _delegate = nil;
    
}

-(void)initBtnAndLblList{
    /*   NSArray *tempArray = [[NSArray alloc]initWithObjects:
     @"orderCenter_new.png",@"订单中心",
     @"myCollection_new.png",@"我的收藏",
     @"addressInfo_new.png",@"地址管理",
     @"cancelOrder_new.png",@"退货",
     @"my_evalution.png",@"评价晒单",
     @"myEbuy_travelCenter.png",@"我的商旅",
     @"myEgq_new.png",@"我的易购券",
     @"my_lottery.png",@"我的彩票",nil];
     
     int index = 0;
     @autoreleasepool {
     
     for (int j = 0; j<4; j++) {
     for (int i=0; i< 2; i++) {
     UIButton *tempBtn = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
     [tempBtn setFrame:CGRectMake(17+j*75, 17+i*83, 58, 58)];
     NSString *imageName = [tempArray objectAtIndex:index*2];
     NSString *textStr = [tempArray objectAtIndex:(index*2+1)];
     
     index++;
     [tempBtn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
     if (i == 0 && j == 0) {
     tempBtn.tag = 100 +  eGoToOrderCenter;
     [tempBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
     
     }else if(i == 0 && j == 1){
     tempBtn.tag = 100 + eGoToAddressInfo;
     [tempBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
     
     }else if(i == 0 && j == 2){
     tempBtn.tag = 100 + eGoToEvaluation;
     [tempBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
     
     }else if(i == 0 && j == 3){
     tempBtn.tag = 100 + eGoToCoupon;
     [tempBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
     
     }else if(i == 1 && j == 0){
     tempBtn.tag = 100 +  eGoToFavorite;
     [tempBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
     
     }else if(i == 1 && j == 1){
     tempBtn.tag = 100 + eGotoReturnGoods;
     [tempBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
     
     }else if(i == 1 && j == 2){
     tempBtn.tag = 100 + eGoToTicketList;
     [tempBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
     
     }else{
     tempBtn.tag = 100 + eGoToLotteryTicket;
     
     [tempBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
     
     }
     [self addSubview:tempBtn];
     TT_RELEASE_SAFELY(tempBtn);
     UILabel *tempLbl = [[UILabel alloc]initWithFrame:CGRectMake(17+j*75, 83+i*83, 60, 12)];
     tempLbl.backgroundColor = [UIColor clearColor];
     tempLbl.text = textStr;
     tempLbl.textAlignment = UITextAlignmentCenter;
     tempLbl.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
     tempLbl.font = [UIFont systemFontOfSize:12.0];
     [self addSubview:tempLbl];
     TT_RELEASE_SAFELY(tempLbl);
     }
     }
     
     }
     
     TT_RELEASE_SAFELY(tempArray);   */
    
}

-(UILabel *)quanLab{
    
    if (!_quanLab) {
        
        _quanLab = [[UILabel alloc]initWithFrame:CGRectMake(156, 25, 82, 15)];
        _quanLab.backgroundColor = [UIColor clearColor];
        _quanLab.textAlignment = UITextAlignmentCenter;
        _quanLab.textColor = [UIColor colorWithRGBHex:0xFC7C26];
        _quanLab.font = [UIFont boldSystemFontOfSize:13.0];
        [self addSubview:_quanLab];
    }
    
    return _quanLab;
}
-(UILabel *)jifengLab{
    
    if (!_jifengLab) {
        
        _jifengLab = [[UILabel alloc]initWithFrame:CGRectMake(82, 25, 74, 15)];
        _jifengLab.backgroundColor = [UIColor clearColor];
        _jifengLab.textAlignment = UITextAlignmentCenter;
        _jifengLab.textColor = [UIColor colorWithRGBHex:0xFC7C26];
        _jifengLab.font = [UIFont boldSystemFontOfSize:13.0];
        [self addSubview:_jifengLab];
    }
    
    return _jifengLab;
}
-(UILabel *)YuELab{
    
    if (!_YuELab) {
        
        _YuELab = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, 82, 15)];
        _YuELab.backgroundColor = [UIColor clearColor];
        _YuELab.textAlignment = UITextAlignmentCenter;
        _YuELab.textColor = [UIColor colorWithRGBHex:0xFC7C26];
        _YuELab.font = [UIFont boldSystemFontOfSize:13.0];
        [self addSubview:_YuELab];
    }
    
    return _YuELab;
}

-(void)initBtnAndLblList:(int)number{
    
    NSArray *tempArray = [[NSArray alloc]initWithObjects:
                          @"New_DaiZF_Up",L(@"efubao"),
                          @"New_MyYFB_Up",L(@"MyIntegral"),
                          @"New_MyEgq_Up",L(@"MyEBuy_MyCoupon"),
                          @"New_MyCard_UP",L(@"Electronic membership card"),
                          nil];
    
    int index = 0;
    @autoreleasepool {
        
        for (int j = 0; j<4; j++) {
            

            UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            
           // [tempBtn setFrame:CGRectMake(j*80, -15, 80, 60)];
            
            tempBtn.backgroundColor = [UIColor clearColor];
            tempBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
            [tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            NSString *textStr = [tempArray objectAtIndex:(index*2+1)];

            [tempBtn setTitle:textStr forState:UIControlStateNormal];

            
            index++;

            
            if (j == 0) {
                tempBtn.tag = 100 +  eGoToEfubao;
                [tempBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
                
                [tempBtn setFrame:CGRectMake(0, -15, 82, 60)];
                
                UIView *v = [[UIView alloc] initWithFrame:CGRectMake(82, 12, 0.5, 18)];
                v.backgroundColor = [UIColor whiteColor];
                
                [self addSubview:v];
            }else if(j == 1){
                tempBtn.tag = 100 + eGoToIntegral;
                [tempBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
                [tempBtn setFrame:CGRectMake(82, -15, 74, 60)];
                
                UIView *v = [[UIView alloc] initWithFrame:CGRectMake(155, 12, 0.5, 18)];
                v.backgroundColor = [UIColor whiteColor];
                
                [self addSubview:v];
                
            }else if(j == 2){
                tempBtn.tag = 100 + eGoToCoupon;
                [tempBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
                [tempBtn setFrame:CGRectMake(156, -15, 82, 60)];
                
                UIView *v = [[UIView alloc] initWithFrame:CGRectMake(238, 12, 0.5, 18)];
                v.backgroundColor = [UIColor whiteColor];
                
                [self addSubview:v];
                
            }else if(j == 3){
                
                tempBtn.tag = 100 +  eGoToMyCard;
                [tempBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
                [tempBtn setFrame:CGRectMake(238, -15, 82, 60)];
            }
            [self addSubview:tempBtn];
            TT_RELEASE_SAFELY(tempBtn);
//            UILabel *tempLbl = [[UILabel alloc]initWithFrame:CGRectMake(20+j*75, 70, 60, 12)];
//            tempLbl.backgroundColor = [UIColor clearColor];
//            //tempLbl.text = textStr;
//            tempLbl.textAlignment = UITextAlignmentCenter;
//            tempLbl.textColor = [UIColor colorWithRGBHex:0xFC7C26];//[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
//            tempLbl.font = [UIFont systemFontOfSize:11.0];
//            [self addSubview:tempLbl];
//            TT_RELEASE_SAFELY(tempLbl);
            
        }
        
    }
    
    TT_RELEASE_SAFELY(tempArray);
}

#pragma mark - action

-(void)action:(id)sender{
    
    UIButton *tappedButton = sender;
    
    if ([self.delegate respondsToSelector:@selector(buttonTappedWithActionType:)]) {
        
        //        self.isPressed = YES;
        
        [ self.delegate buttonTappedWithActionType:tappedButton.tag-100 ];
        
        //        [self removeAllSubviews];
        
        //        [self initBtnAndLblList:tappedButton.tag - 100];
    }
    
}

@end
