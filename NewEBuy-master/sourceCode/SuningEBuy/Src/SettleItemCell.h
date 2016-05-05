//
//  SettleItemCell.h
//  SuningEBuy
//
//  Created by wangrui on 12/10/11.
//  Copyright (c) 2011 suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolBarButton.h"
#import "SettlementConstant.h"

@interface SettleItemCell : UITableViewCell


@property (nonatomic,strong)UILabel *leftTextLbl;

@property (nonatomic,strong)UILabel *rightTextLbl;

@property (nonatomic,strong)UITextField *rightTextFld;

@property (nonatomic,strong)ToolBarButton *rightNormalBtn;

@property (nonatomic,strong)UIImageView   *lineImage;
/*
 * author:崔正来
 * date:2012-08-31
 * description: 增加选择“图片按钮”
 */
@property (nonatomic,strong)UIImageView      *rightImage;


@end

