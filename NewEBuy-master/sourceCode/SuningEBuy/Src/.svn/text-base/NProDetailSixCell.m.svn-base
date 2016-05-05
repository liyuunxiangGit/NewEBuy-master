//
//  NProDetailSixCell.m
//  SuningEBuy
//
//  Created by xmy on 19/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NProDetailSixCell.h"

@implementation NProDetailSixCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    
    }
    return self;
}

- (UIImageView *)btnClickedImg
{
    if (!_btnClickedImg) {
        _btnClickedImg = [[UIImageView alloc] init];
        _btnClickedImg.image = [UIImage streImageNamed:@"segment_line_Horizontal_orange.png"];
        _btnClickedImg.frame = CGRectMake(0, 33, 80, 2);
    }
    return _btnClickedImg;
}

- (UIImageView *)seperateLineOne
{
    if (!_seperateLineOne) {
        _seperateLineOne = [[UIImageView alloc] init];
        
        _seperateLineOne.image = [UIImage streImageNamed:@"line.png"];
    }
    return _seperateLineOne;
}

- (UIImageView *)seperateLineTwo
{
    if (!_seperateLineTwo) {
        _seperateLineTwo = [[UIImageView alloc] init];
        
        _seperateLineTwo.image = [UIImage streImageNamed:@"line.png"];
    }
    return _seperateLineTwo;
}

- (UIImageView *)seperateLineThree
{
    if (!_seperateLineThree) {
        _seperateLineThree = [[UIImageView alloc] init];
        
        _seperateLineThree.image = [UIImage streImageNamed:@"line.png"];
    }
    return _seperateLineThree;
}

- (void)setBtnsPropetry:(UIButton*)btn
{
    [btn addTarget:self action:@selector(btnChangeTabAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    [btn setBackgroundImage:nil forState:UIControlStateNormal];
    
    [btn setTitleColor:RGBCOLOR(247, 111, 44) forState:UIControlStateSelected];
    
    [btn setTitleColor:RGBCOLOR(93, 93, 93) forState:UIControlStateNormal];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
}

-(UIButton *)baseInfoBtn{
    
    if (!_baseInfoBtn) {
        
        _baseInfoBtn = [[UIButton alloc] initWithFrame:CGRectMake(80, 4, 80, 32)];
        
        [self setBtnsPropetry:_baseInfoBtn];

        [_baseInfoBtn setTitle:L(@"DJ_Good_BaseInfo") forState:UIControlStateNormal];
        
        self.selectType = SelectMidBtnCell;
        
    }
    return _baseInfoBtn;
}

-(UIButton *)introduceBtn{
    
    if (!_introduceBtn) {
        
        _introduceBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 4, 80, 32)];
        
        [self setBtnsPropetry:_introduceBtn];

        [_introduceBtn setTitle:L(@"Product_TextImageDetail") forState:UIControlStateNormal];
        
        self.selectType = SelectLeftBtnCell;
        
    }
    return _introduceBtn;
}

-(UIButton *)appraiseBtn{
    
    if (!_appraiseBtn) {
        
        _appraiseBtn = [[UIButton alloc] initWithFrame:CGRectMake(160, 4, 80, 32)];
        
        [self setBtnsPropetry:_appraiseBtn];
        
        _appraiseBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        
        [_appraiseBtn setTitle:L(@"Product_Comment") forState:UIControlStateNormal];
        
        self.selectType = SelectRightBtnCell;
    }
    return _appraiseBtn;
}

-(UIButton *)consultationBtn{
    
    if (!_consultationBtn) {
        
        _consultationBtn = [[UIButton alloc] initWithFrame:CGRectMake(240, 0, 80, 32)];
        
        [self setBtnsPropetry:_consultationBtn];
        
        _consultationBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        
        [_consultationBtn setTitle:L(@"Product_Consult") forState:UIControlStateNormal];
        
        self.selectType = SelectRightBtnCell;
    }
    return _consultationBtn;
}

- (UIImageView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"segment_line_vertical_gray.png"]];
        _lineView.backgroundColor = [UIColor clearColor];
    }
    return _lineView;
}

- (UIImageView *)lineView1
{
    if (!_lineView1) {
        _lineView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"segment_line_vertical_gray.png"]];
        _lineView1.backgroundColor = [UIColor clearColor];
    }
    return _lineView1;
}

- (UIImageView *)lineView2
{
    if (!_lineView2) {
        _lineView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"segment_line_vertical_gray.png"]];
        _lineView2.backgroundColor = [UIColor clearColor];
    }
    return _lineView2;
}

- (void)setNProDetailSixCellInfo:(DataProductBasic*)dto WithAppraiseNum:(NSString*)numStr
{
    [self addSubview:self.baseInfoBtn];
    
    [self addSubview:self.introduceBtn];
    
    [self addSubview:self.appraiseBtn];
    
    [self addSubview:self.consultationBtn];

    [self addSubview:self.lineView];
    
    [self addSubview:self.lineView1];
    
    [self addSubview:self.lineView2];
    
    [self addSubview:self.btnClickedImg];
    
    [self addSubview:self.seperateLineOne];
    
    [self addSubview:self.seperateLineTwo];

    self.baseInfoBtn.frame = CGRectMake(80, 0, 80, 32);
    self.introduceBtn.frame = CGRectMake(0, 0, 80, 32);
    self.appraiseBtn.frame = CGRectMake(160, 0, 80, 32);
    self.lineView.frame = CGRectMake(self.introduceBtn.right, 7, 1, 15);
    self.lineView1.frame = CGRectMake(self.baseInfoBtn.right, 7, 1, 15);
    self.lineView2.frame = CGRectMake(self.appraiseBtn.right, 7, 1, 15);

    self.seperateLineOne.frame = CGRectMake(0, 0, 320, 0.5);
    self.seperateLineTwo.frame = CGRectMake(0, 34.5, 320, 0.5);
//    self.seperateLineThree.frame = CGRectMake(0, 34.5, 320, 0.5);

    [self.appraiseBtn setTitle:[NSString stringWithFormat:@"%@(%@)",L(@"Evaluate"),numStr?numStr:@"0"] forState:UIControlStateNormal];

    self.consultationBtn.enabled = YES;
    [self.consultationBtn setTitle:[NSString stringWithFormat:@"%@(%@)",L(@"UserFeedBack_Consult"),dto.zixunCount?dto.zixunCount:@"0"] forState:UIControlStateNormal];
     [self.consultationBtn setTitle:[NSString stringWithFormat:@"%@(%@)",L(@"UserFeedBack_Consult"),dto.zixunCount?dto.zixunCount:@"0"] forState:UIControlStateSelected];
}

-(NSArray *)btnArray{
    
    if (!_btnArray) {
        
        _btnArray = [[NSArray alloc] initWithObjects:self.introduceBtn,self.baseInfoBtn,self.appraiseBtn,self.consultationBtn, nil];
    }
    return _btnArray;
}


#pragma mark -
#pragma mark 自定义方法


-(void)btnChangeTabAction:(UIButton *)btn{
    
    //当改按钮没有选中时 点击该按钮响应一下操作
    if (!btn.isSelected) {
        
        //该按钮设为选中
        //其他按钮改为 非选中
        for (int i=0;i<[self.btnArray count];i++) {
            
            UIButton *obj = (UIButton *)[self.btnArray objectAtIndex:i];
            if (btn != obj) {
                
                obj.selected = NO;
            }
            else{
                
                obj.selected = YES;
                self.selectType = i;
            }
        }
        
        [self viewChangeWithType:self.selectType];
    }
}

//基本信息／商品介绍／评价  切换
-(void)viewChangeWithType:(BtnSelectTypeCell)type{
    
    [UIView animateWithDuration:0.4 animations:^{
        self.btnClickedImg.frame = CGRectMake(type*80, 33, 80, 2);
    }];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(viewChangeWithType:)])
    {
        [self.delegate viewChangeWithType:type];

    }

}



@end
