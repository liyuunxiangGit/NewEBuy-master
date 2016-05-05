//
//  SearchListCell.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-30.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EvaluationView.h"
#import "DataProductBasic.h"
#import "SNSwitch.h"
@interface SearchListCell : UITableViewCell<EGOImageViewDelegate>
{
@private
    EGOImageView    *productImageView_;
    
    UILabel         *productNameLabel_;
    
    UILabel         *productDescriptionLabel_;
    
    UILabel         *priceLabel_;
    
    //star View   
    EvaluationView  *evaluationView_;
    
    //dataSource
    DataProductBasic    *dataSource_;
    

    UILabel         *supplierNum_;  //在线商家数目
    
    UILabel         *minPriceLabel_;
    
    UILabel         *minPrice_;     //起售价格
}
@property (nonatomic, strong) EGOImageView *priceImageView;
@property (nonatomic, strong) UILabel *labelCommentCount;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)setItem:(DataProductBasic *)item;

@end
