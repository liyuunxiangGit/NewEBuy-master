//
//  ReturnGoodsListCell.h
//  SuningEBuy
//
//  Created by 漫 王 on 12-9-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>





#import "ReturnGoodsListDTO.h"

@interface ReturnGoodsListCell : UITableViewCell<EGOImageViewDelegate,EGOImageViewExDelegate>
{
    UILabel            *_productName;
    
    UILabel            *_orderNum;
    
    UILabel            *_productPayTime;
      
    EGOImageViewEx     *_productImage;
    
    ReturnGoodsListDTO *_item;
}
@property (nonatomic ,strong)UILabel   *productName;

@property (nonatomic ,strong)UILabel   *orderNum;

@property (nonatomic ,strong)UILabel   *productPayTime;

@property (nonatomic ,strong)EGOImageViewEx    *productImage;
@property (nonatomic, strong)  UIImageView *lineView;// line

- (void)setItem:(ReturnGoodsListDTO *)item;
@end
