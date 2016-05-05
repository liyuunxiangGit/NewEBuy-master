//
//  NewProductAppraisalCell.h
//  SuningEBuy
//
//  Created by 孔斌 on 13-8-27.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DLStarRatingControl.h"
#import "NewProductAppraisalDTO.h"
#import "productToolClass.h"
#import "EvaluationView.h"
#import "SNGraphics.h"

@interface NewProductAppraisalCell : UITableViewCell

@property (nonatomic, strong) UILabel   *nickNameLabel;

@property (nonatomic, strong) UILabel   *reviewTimeLabel;

@property (nonatomic ,strong) UILabel   *contentLabel;

@property (nonatomic, strong) EvaluationView *starView;
@property (nonatomic, strong) UILabel        *starDesc;

@property (nonatomic, strong) UIImageView    *bestTagView;
@property (nonatomic, strong) UILabel        *suplContent;

@property (nonatomic, strong) UILabel       *suplName;

@property (nonatomic, strong) UIImageView    *cellSeperatorView;

@property (nonatomic, strong) NewProductAppraisalDTO   *Dto;


- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier;

-(void)setItem:(NewProductAppraisalDTO*)item;

+(CGFloat)height:(NewProductAppraisalDTO *)item;
@end
