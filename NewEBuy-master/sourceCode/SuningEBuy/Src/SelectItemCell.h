//
//  SelectItemCell.h
//  SuningEBuy
//
//  Created by li xiaokai on 13-7-16.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSBtnService.h"
#import "DataProductBasic.h"
typedef enum {
    ColorCell  =  0,      
    SizeCell,           
    ServiceCell
}CellType;

@protocol SelectItemDelegate <NSObject>

@optional

-(void)selected:(NSString *)value cell:(NSInteger)type;

@end

@interface SelectItemCell : UITableViewCell


@property(nonatomic,strong)NSArray *dataSourse;

@property(nonatomic,strong)SSBtnService *singleBtnService;

@property(nonatomic,strong)DataProductBasic *productDto;

@property(nonatomic,strong)UILabel *selectTypeTitle;

@property(nonatomic) CellType  cellType;

@property(nonatomic,strong)UIImageView *separatorLine;

@property(nonatomic,weak)id<SelectItemDelegate> myDelegate;

-(void)initViewWithSourse:(DataProductBasic *)dto type:(NSInteger)type;

+(float)cellHeight:(NSArray *)array;

+(float)cellHeight:(DataProductBasic *)dto type:(NSInteger)type;
@end
