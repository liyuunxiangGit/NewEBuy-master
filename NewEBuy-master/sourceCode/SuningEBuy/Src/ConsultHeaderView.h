//
//  ConsultHeaderView.h
//  SuningEBuy
//
//  Created by sn－wahaha on 14-6-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultListDTO.h"

@interface ConsultHeaderView : UIView

@property (nonatomic, strong) UILabel *username;
@property (nonatomic,strong) UITextView *ask;
@property (nonatomic,strong) UITextView *answer;
@property (nonatomic,strong) UILabel  *datetime;
@property (nonatomic,strong) UIImageView *line;
@property (nonatomic,strong) UIImageView *linecell;
@property (nonatomic,strong) UIButton *manyi;
@property (nonatomic,strong) UIButton *unmanyi;

@property (nonatomic, weak) id  owner;

-(void)setcellinit:(ConsultListDTO *)dto;

@end
