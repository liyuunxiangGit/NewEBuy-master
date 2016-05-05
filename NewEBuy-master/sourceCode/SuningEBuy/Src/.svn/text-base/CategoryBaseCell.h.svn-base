//
//  CategoryBaseCell.h
//  SuningEBuy
//
//  Created by gexiangtong on 14-2-12.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    CateFrist,
    cateSecond,
    
}CateType;

@protocol CategoryBaseCellDelegate <NSObject>

-(void)touchCategory:(int)tag Type:(CateType)type;

@end

@interface CategoryBaseCell : UITableViewCell
{
    
    UILabel *_nameLabel;
    
    UIImageView *_cellSeparatorLine;
    
}

@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *cellSeparatorLine;


@property (nonatomic, assign) id<CategoryBaseCellDelegate> delegate;


-(void)setData:(NSString*)name IsSelect:(BOOL)isSelected;

-(void)touchCategory:(id)sender;

@end
