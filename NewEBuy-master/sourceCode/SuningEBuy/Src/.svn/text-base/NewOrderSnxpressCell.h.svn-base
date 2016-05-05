//
//  NewOrderSnxpressCell.h
//  SuningEBuy
//
//  Created by xmy on 2/11/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CalculateLblHeightCell.h"
#import "ServiceDetailInfoDTO.h"
#import "AppConstant.h"

@interface NewOrderSnxpressCell : CalculateLblHeightCell<UIWebViewDelegate,UIActionSheetDelegate>{
    
    CGFloat  height;
}

@property (nonatomic, strong) UIImageView          *upLineImg;
@property (nonatomic, strong) UIImageView          *iconImg;
@property (nonatomic, strong) UIImageView          *downLineImg;
@property (nonatomic, strong) UIImageView          *backImg;
//@property (nonatomic, strong) UILabel              *contentLbl;
@property (nonatomic, strong) UILabel              *operatorLbl;
@property (nonatomic, strong) UILabel              *timeLbl;
@property (nonatomic, strong) UIWebView           *contentLbl;
@property (nonatomic, strong) NSString             *telephoneNmber;
-(void)refreshCell:(NSDictionary *)dic celType:(CellViewType)cellType WithMorePack:(BOOL)isMorePackage;

+ (CGFloat)expressHeight:(NSDictionary *)dic;


@end
