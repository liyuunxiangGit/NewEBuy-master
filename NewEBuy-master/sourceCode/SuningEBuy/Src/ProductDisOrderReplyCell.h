//
//  ProductDisOrderReplyCell.h
//  SuningEBuy
//
//  Created by xy ma on 12-2-22.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "productToolClass.h"
#import "DisProductDetailsDTO.h"


@interface ProductDisOrderReplyCell : UITableViewCell{
    UILabel *_titleLbl;
    UILabel *_timeLbl;
    UILabel *_contentLbl;
    UILabel *_nameLbl;
    
    DisProductDetailsDTO *_dataSource;
}


@property (nonatomic,strong)UILabel *titleLbl;
@property (nonatomic,strong)UILabel *timeLbl;
@property (nonatomic,strong)UILabel *contentLbl;
@property (nonatomic,strong)UILabel *nameLbl;
@property (nonatomic,strong)DisProductDetailsDTO *dataSource;

-(void)setItem:(DisProductDetailsDTO *)item;

+ (CGFloat) height:(DisProductDetailsDTO *)item;

+ (CGFloat) heightforText:(NSString *)stringContent;

@end
