//
//  SolrProductCell.h
//  SuningEBuy
//
//  Created by wei xie on 12-8-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DataProductBasic.h"
#import "EvaluationView.h"
#import "InnerProductDTO.h"


@interface SolrProductCell : SNUITableViewCell <EGOImageViewDelegate, EGOImageViewExDelegate>
{
    @private
    EGOImageViewEx    *productImageView_;
    
    UILabel         *productNameLabel_;
    
    UILabel         *productDescriptionLabel_;
    
    UILabel         *priceLabel_;
    
    //star View   
    EvaluationView  *evaluationView_;
    
    //dataSource
    DataProductBasic    *dataSource_;
}

@property (nonatomic, assign) BOOL                isShowEvaluation;

@property (nonatomic,strong) UIImageView          *salesSmallImage;

@property (nonatomic,strong) UILabel              *bigbangNameLabel;

@property (nonatomic,strong) InnerProductDTO *innerDto;

@property (nonatomic,strong) EGOImageViewEx *priceImageView;

@property (nonatomic,strong) UILabel *priceHintLabel;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)setItem:(DataProductBasic *)item withDto:(InnerProductDTO *)dto;
//- (void)setItem:(DataProductBasic *)item WithIcon:(NSString*)icon;


@end
