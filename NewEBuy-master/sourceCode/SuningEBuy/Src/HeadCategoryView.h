//
//  HeadCategoryView.h
//  SuningEBuy
//
//  Created by gexiangtong on 14-2-14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@class V2FristCategoryDTO;

@interface HeadCategoryView : UIButton
{
    UILabel *_nameLabel;
    
    UIButton *_actionBtn;
}

@property (nonatomic, strong) UILabel           *nameLabel;
@property (nonatomic, strong) UIImageView       *arrowView;
@property (nonatomic, strong) UIView            *cellView;

-(void)setDate:(V2FristCategoryDTO*)dto;

@end
