//
//  ReturnGoodsQueryCell.h
//  SuningEBuy
//
//  Created by 漫 王 on 12-9-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>



#import "ReturnGoodsQueryDTO.h"

@interface ReturnGoodsQueryCell : UITableViewCell<EGOImageViewDelegate,EGOImageViewExDelegate>{
    
    UILabel             *_productName;
    
    EGOImageViewEx      *_productImage;
    
    UILabel             *_orderNum;
    
    UILabel             *_productPayTime;
    
    UILabel             *_productStatus;
    
    ReturnGoodsQueryDTO *_returnGoodsQueryDto;
}

@property (nonatomic ,strong)UILabel  *productName;

@property (nonatomic ,strong)EGOImageViewEx      *productImage;

@property (nonatomic, strong)UILabel             *orderNum;

@property (nonatomic ,strong)UILabel             *productPayTime;

@property (nonatomic ,strong)UILabel             *productStatus;

@property (nonatomic ,strong) ReturnGoodsQueryDTO *returnGoodsQueryDto;
@property (nonatomic, strong)  UIImageView *lineView;// line

- (void) setReturnGoodsQueryDto:(ReturnGoodsQueryDTO *)returnGoodsQueryDto;

@end
