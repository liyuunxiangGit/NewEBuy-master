//
//  ReturnGoodsDetailViewController.h
//  SuningEBuy
//
//  Created by 漫 王 on 12-9-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ReturnGoodsQueryDTO.h"
#import "UITableViewCell+BgView.h"
#import "CShopChooseExpressListViewController.h"
#import "AllOrderDetailCommonViewController.h"

@interface ReturnGoodsDetailViewController : AllOrderDetailCommonViewController
{
    ReturnGoodsQueryDTO   *_returnGoodsDto;
    
    BOOL        _isGetOnlineStatusOk;
    int         _onlineStatus;
    
    UIWebView       *_callWebView;
}

@property (nonatomic, strong)ReturnGoodsQueryDTO   *returnGoodsDto;

@property (nonatomic, strong) NSArray *expressList; //物流列表

@end
