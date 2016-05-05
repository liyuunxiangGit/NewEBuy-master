//
//  ProductDIsProductCell.h
//  SuningEBuy
//
//  Created by xy ma on 12-2-28.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DataProductBasic.h"
#import "EvaluationView.h"

@interface ProductDIsProductCell : UITableViewCell <EGOImageViewDelegate>
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
}

@property (nonatomic, assign) BOOL isShowEvaluation;

@property (nonatomic, strong) EGOImageView *productImageView;

@property (nonatomic, strong) UILabel *productNameLabel;

@property (nonatomic, strong) UILabel *productDescriptionLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) EvaluationView *evaluationView;

@property (nonatomic, strong) DataProductBasic *dataSource;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)setItem:(DataProductBasic *)item;



@end
