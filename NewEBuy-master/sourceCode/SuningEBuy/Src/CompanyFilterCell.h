//
//  CompanyFilterCell.h
//  SuningEBuy
//
//  Created by shasha on 12-5-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyDTO.h"


@interface CompanyFilterCell : UITableViewCell

@property(nonatomic,strong)CompanyDTO *item; 
@property(nonatomic,strong)EGOImageView *companyImageView;
@property(nonatomic,strong)UILabel      *companyNameLabel;
@end
