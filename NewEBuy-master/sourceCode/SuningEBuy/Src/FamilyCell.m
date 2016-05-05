//
//  FamilyCell.m
//  SuningEBuy
//
//  Created by li xiaokai on 14-2-7.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "FamilyCell.h"

@implementation FamilyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(UILabel*)cellTitle{
    
    if (!_cellTitle) {
        
        _cellTitle = [[UILabel alloc]initWithFrame:CGRectMake(80, 15, 180, 18)];
        _cellTitle.backgroundColor = [UIColor clearColor];
        _cellTitle.font = [UIFont boldSystemFontOfSize:15.0];
        _cellTitle.textColor = [UIColor light_Black_Color];
        
        [self.contentView addSubview:_cellTitle];
    }
    return _cellTitle;
}

-(UILabel *)cellDetail{
    
    if (!_cellDetail) {
        
        _cellDetail = [[UILabel alloc]initWithFrame:CGRectMake(80, 35, 180, 18)];
        _cellDetail.backgroundColor = [UIColor clearColor];
        _cellDetail.font = [UIFont boldSystemFontOfSize:13.0];
        _cellDetail.textColor = [UIColor dark_Gray_Color];
        
        [self.contentView addSubview:_cellDetail];
    }
    
    return _cellDetail;
}

-(UIImageView *)cellImg{
    
    if (!_cellImg) {
        
        _cellImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7,60, 60)];
        
        _cellImg.layer.cornerRadius = 10.0;
        _cellImg.clipsToBounds = YES;
        
        [self.contentView addSubview:_cellImg];
    }
    
    return _cellImg;
}

-(UIButton *)markButton{
    
    if (!_markButton) {
        
        _markButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
        
        _markButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_markButton addTarget:self action:@selector(markButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.accessoryView = _markButton;
    }
    
    return _markButton;
}

-(void)markButtonAction:(id)sender{
    
    if (_mydelegate && [_mydelegate respondsToSelector:@selector(downApp:)]) {
        
        [_mydelegate downApp:_familyDic];
    }
}

-(void)setUIItem:(NSDictionary *)dic{
    
    self.familyDic = dic;
    
    //set img
    self.cellImg.image = [UIImage imageNamed:[dic objectForKey:kSFIconKey]];
    self.cellImg.layer.cornerRadius = 10.0;
    //set title
    NSString *name = [dic objectForKey:kSFNameKey];
    self.cellTitle.text = [NSString stringWithFormat:@"%@", name];
    
    //setDesc
    self.cellDetail.text = [dic objectForKey:kSFDescKey];
    
    //mark 按钮
    NSURL *localUrl = [NSURL URLWithString:[dic objectForKey:kSFLocalUrlKey]];
    
    if ([[UIApplication sharedApplication] canOpenURL:localUrl]){
        
        //[[UIApplication sharedApplication] openURL:localUrl];
        
         [self.markButton setTitle:L(@"Installed") forState:UIControlStateNormal];
        [self.markButton setTitleColor:[UIColor colorWithRed:0 green:153/255.0 blue:68/255.0 alpha:1] forState:UIControlStateNormal];
         [self.markButton setImage:nil forState:UIControlStateNormal];
    }
    else{
        
         [self.markButton setTitle:@"" forState:UIControlStateNormal];
        [self.markButton setImage:[UIImage imageNamed:@"familydown.png"] forState:UIControlStateNormal];

    }
}
@end
