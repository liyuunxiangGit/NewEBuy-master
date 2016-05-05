//
//  CategoryBaseCell.m
//  SuningEBuy
//
//  Created by gexiangtong on 14-2-12.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CategoryBaseCell.h"

@implementation CategoryBaseCell

@synthesize nameLabel = _nameLabel;
@synthesize cellSeparatorLine = _cellSeparatorLine;
@synthesize delegate = _delegate;


-(void)dealloc
{
    TTVIEW_RELEASE_SAFELY(_nameLabel);
    TTVIEW_RELEASE_SAFELY(_bgView);
    TTVIEW_RELEASE_SAFELY(_cellSeparatorLine);
}

-(UIImageView *)bgView
{
    if (nil == _bgView)
    {
        _bgView = [[UIImageView alloc] init];
        _bgView.frame = CGRectMake(0, 0, self.width, self.height);
        _bgView.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_bgView];
    }
    
    return _bgView;
}

-(UILabel *)nameLabel
{
    if (nil == _nameLabel)
    {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_nameLabel];
    }
    
    return _nameLabel;
}

-(UIImageView *)cellSeparatorLine
{
    if (nil == _cellSeparatorLine)
    {
        _cellSeparatorLine = [[UIImageView alloc] init];
        _cellSeparatorLine.backgroundColor = RGBCOLOR(202, 202, 202);
        
        [self.contentView addSubview:_cellSeparatorLine];
    }
    
    return _cellSeparatorLine;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
//        _bgView.backgroundColor = [UIColor colorWithHexString:@"0xFFFFFF"];
//        self.backgroundColor = [UIColor colorWithHexString:@"0xF2F2F2"];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setData:(NSString *)name IsSelect:(BOOL)isSelected
{
    self.cellSeparatorLine.frame = CGRectMake(15, 29.5, 94, 0.5);
//    [self.cellSeparatorLine setImage:[UIImage imageNamed:@"category_cellSeparatorLine.png"]];
    
    if (isSelected) {
//        self.bgView.image = [UIImage imageNamed:@"NextCata_Selected.png"];
        self.nameLabel.textColor = RGBCOLOR(248, 111, 2);
    }else{
//        self.bgView.image = nil;
        self.nameLabel.textColor = RGBCOLOR(112, 112, 112);
    }
    
    self.nameLabel.frame = CGRectMake(15, 2.5, 94, 25);
    self.nameLabel.font = [UIFont systemFontOfSize:13];
    self.nameLabel.text = name;
}


#pragma --
#pragma UIView Touch

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    self.bgView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
//    self.bgView.backgroundColor = RGBCOLOR(244, 88, 8);
//    
//    self.nameLabel.textColor = [UIColor colorWithHexString:@"0xFFFFFF"];
//    
//    [UIView animateWithDuration:0.1 animations:^{
//        
//        self.bgView.backgroundColor = [UIColor clearColor];
//        self.nameLabel.textColor = [UIColor colorWithHexString:@"0x707070"];
//        
//        [self performSelector:@selector(touchCategory:) withObject:nil afterDelay:0.1];
//        
//    }];
//
//}

-(void)touchCategory:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(touchCategory:Type:)])
    {
        [self.delegate touchCategory:self.tag Type:cateSecond];
    }

}

@end
