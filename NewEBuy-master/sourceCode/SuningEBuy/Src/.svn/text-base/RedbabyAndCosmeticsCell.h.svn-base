//
//  RedbabyAndCosmeticsCell.h
//  SuningEBuy
//
//  Created by li xiaokai on 13-4-12.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "V2FristCategoryDTO.h"


#define SecondListNum  4

@protocol RedbabyAndCosmeticsCellDelegate <NSObject>

@optional
-(void)secondCategorySelect:(id)obj;

@end

@interface RedbabyAndCosmeticsCell : SNUITableViewCell{
    
    
    V2FristCategoryDTO   *_item;
    UILabel              *_titleLabel;
    EGOImageView         *_cellImage;
    UIImageView          *_groundView;
}

@property (nonatomic,strong)V2FristCategoryDTO   *item;
@property (nonatomic,strong)UILabel              *tilleLabel;
@property (nonatomic,strong)EGOImageView         *cellImage;
@property (nonatomic,strong)UIImageView          *groundView;

@property (nonatomic,weak)id<RedbabyAndCosmeticsCellDelegate> mydelegate;
-(void) setItem:(V2FristCategoryDTO *)aItem cellIndex:(NSInteger)index;
@end
