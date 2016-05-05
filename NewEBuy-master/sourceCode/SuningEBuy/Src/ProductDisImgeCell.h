//
//  ProductDisImgeCell.h
//  SuningEBuy
//
//  Created by xy ma on 12-2-27.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ProductDisImgeDTO.h"

@interface ProductDisImgeCell : UITableViewCell<EGOImageViewDelegate>{
    
@private EGOImageView    *productDisImageView_;
    
        NSString         *productDisImageURL_;
    
    ProductDisImgeDTO    *dataSource_;
}

@property (nonatomic, strong)EGOImageView *productDisImageView;

@property (nonatomic, copy)NSString *productDisImageURL;

@property (nonatomic, strong)ProductDisImgeDTO *dataSource;

- (void)setItem:(ProductDisImgeDTO *)item;
- (void)setItemByImage:(UIImage *)image;

@end
