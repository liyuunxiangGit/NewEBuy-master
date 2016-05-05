//
//  CategoryCell.m
//  SuningEBuy
//
//  Created by gexiangtong on 14-2-12.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell

@synthesize colorLabel = _colorLabel;

-(UILabel *)colorLabel
{
    if (nil == _colorLabel)
    {
        _colorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 3, 50)];
        _colorLabel.backgroundColor = [UIColor clearColor];
        _colorLabel.font = [UIFont systemFontOfSize:18];
        
//        [self.contentView addSubview:_colorLabel];

    }
    
    return _colorLabel;
}

-(void)dealloc
{
    TTVIEW_RELEASE_SAFELY(_colorLabel);
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = RGBCOLOR(242, 242, 242);
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
    self.bgView.frame = CGRectMake(0, 0, 135, 40);
    self.cellSeparatorLine.frame = CGRectMake(0, 39.5, 135, 0.5);
    self.cellSeparatorLine.backgroundColor = RGBCOLOR(202, 202, 202);

    
    
    if (isSelected) {
        self.bgView.image = [UIImage imageNamed:@"NextCata_Selected.png"];
        self.nameLabel.textColor = RGBCOLOR(248, 111, 2);
    }else{
        self.bgView.image = nil;
        self.nameLabel.textColor = RGBCOLOR(112, 112, 112);
    }
    
    self.nameLabel.frame = CGRectMake(15, 5, 104, 30);
    self.nameLabel.textColor = RGBCOLOR(31, 31, 31);
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    self.nameLabel.text = name;
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//}
//
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(touchCategory:Type:)])
//    {
//        [self.delegate touchCategory:self.tag Type:CateFrist];
//    }
//}

@end
