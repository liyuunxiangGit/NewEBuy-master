//
//  ConsultTableViewCell.h
//  SuningEBuy
//
//  Created by sn－wahaha on 14-6-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultListDTO.h"
#import "ConsultationService.h"

@interface ConsultTableViewCell : UITableViewCell<ConsultationDelegate>

@property (nonatomic, strong) UILabel *username;
@property (nonatomic,strong) UILabel *ask;
@property (nonatomic,strong) UILabel *answer;
@property (nonatomic,strong) UILabel  *datetime;
@property (nonatomic,strong) UIImageView *line;
@property (nonatomic,strong) UIImageView *linecell;
@property (nonatomic,strong) UIButton *manyi;
@property (nonatomic,strong) UIButton *unmanyi;
@property (nonatomic,strong) UIImageView *questiong;
@property (nonatomic,strong) UIImageView *answerimg;
@property (nonatomic,strong)    ConsultationService *httpsend;
@property (nonatomic,strong) UIImageView  *unuserview;
@property (nonatomic,strong) UIImageView  *userview;
@property (nonatomic,strong) NSString*   isbook;
@property (nonatomic,strong) UIButton  *productname;
@property (nonatomic, weak) id  owner;

+ (CGFloat)height:(ConsultListDTO *)consultdto;
+ (CGFloat)MyConsultheight:(MyConsultDTO *)consultdto;
-(void)setcellinit:(ConsultListDTO *)dto;
//我的资讯历史
-(void)setmyconsultcellinit:(MyConsultDTO *)dto;

@end
