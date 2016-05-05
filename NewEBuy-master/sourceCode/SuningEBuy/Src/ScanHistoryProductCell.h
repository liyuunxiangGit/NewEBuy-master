//
//  ScanHistoryProductCell.h
//  SuningEBuy
//
//  Created by 王家兴 on 13-5-22.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DataProductBasic.h"
#import "EvaluationView.h"

@interface ScanHistoryProductCell : UITableViewCell <EGOImageViewDelegate>
{
@private
    EGOImageView    *productImageView_;
    
    UILabel         *productNameLabel_;
        
    UILabel         *priceLabel_;
    
    //star View
    EvaluationView  *evaluationView_;
    
    //dataSource
    DataProductBasic    *dataSource_;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)setItem:(DataProductBasic *)item;

@end