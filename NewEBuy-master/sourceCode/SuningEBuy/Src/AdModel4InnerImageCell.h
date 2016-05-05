//
//  AdModel4InnerImageCell.h
//  SuningEBuy
//
//  Created by wei xie on 12-8-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UITableViewCellEx.h"

@interface AdModel4InnerImageCell : UITableViewCellEx{

    EGOImageViewEx *innerAdImageView_;
    NSURL          *innerAdImageURL_;
}

@property (nonatomic,strong) EGOImageViewEx *innerAdimageView;
@property (nonatomic,strong)  NSURL         *innerAdImageURL;

@end
