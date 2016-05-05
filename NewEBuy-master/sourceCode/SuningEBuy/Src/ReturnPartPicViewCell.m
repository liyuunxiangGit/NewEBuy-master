//
//  ReturnPartPicViewCell.m
//  SuningEBuy
//
//  Created by zl on 14-11-7.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ReturnPartPicViewCell.h"
@interface ReturnPartPicViewCell()

@property(nonatomic,strong)UILabel* upPicLab;
@property(nonatomic,strong)UILabel* upTipLab;
@end
@implementation ReturnPartPicViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _upPicLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 80, 30)];
        _upPicLab.backgroundColor = [UIColor clearColor];
        _upPicLab.text = @"上传图片:";
        _upPicLab.font = [UIFont systemFontOfSize:16];
        _upPicLab.textColor = [UIColor blackColor];
        _upPicLab.textAlignment = UITextAlignmentLeft;
        
        [self.contentView addSubview:_upPicLab];
        
        _upTipLab = [[UILabel alloc] initWithFrame:CGRectMake(90, 5, 120, 30)];
        _upTipLab.backgroundColor = [UIColor clearColor];
        _upTipLab.text = @"最多三张图片";
        _upTipLab.font = [UIFont systemFontOfSize:13];
        _upTipLab.textColor = [UIColor light_Gray_Color];
        _upTipLab.textAlignment = UITextAlignmentLeft;
        [self.contentView addSubview:_upTipLab];
        
        _addImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-50, 5, 30, 30)];//
        _addImageView.image = [UIImage imageNamed:@"add@2x.png"];
        _addImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_addImageView];
        
                //_picArray = [NSMutableArray new];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)addImage
{
    _upTipLab.hidden = YES;
}
-(void)deleteImage
{
    _upTipLab.hidden = NO;
}
@end
