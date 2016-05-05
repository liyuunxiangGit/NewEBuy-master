//
//  SegementItem.m
//  SuningEBuy
//
//  Created by david on 14-2-10.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SegementItem.h"

@interface SegementItem()

@property(nonatomic,strong) UIImageView *rightImage;
@property(nonatomic,assign) ItemArrowType   arrowType;

@end


@implementation SegementItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {

        [self setTitleColor:[UIColor orange_Red_Color] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor orange_Red_Color] forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        self.titleLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return self;
}


-(void)setSelected:(BOOL)selected arrowType:(ItemArrowType)type{

    [self setSelected:selected];
    
    self.arrowType = type;
    
    switch (type) {
            
        case ItemArrowNone:{
            
            break;
        }
            
        case ItemArrowUp:{
            
            if (selected) {
                self.rightImage.image = [UIImage newImageFromResource:self.upSelectedName];
            }else{
                self.rightImage.image = [UIImage newImageFromResource:self.upIconName];
            }
            break;
        }
            
        case ItemArrowDown:{
            if (selected) {
                self.rightImage.image = [UIImage newImageFromResource:self.downSelectedName];
            }else{
                self.rightImage.image = [UIImage newImageFromResource:self.downIconName];
            }
            break;
        }
        default:
            break;
    }
    
}

-(void)setSelected:(BOOL)selected{
    
    [super setSelected:selected];
    
    switch (self.arrowType) {
            
        case ItemArrowNone:{
            
            break;
        }
            
        case ItemArrowUp:{
            
            if (selected) {
                self.rightImage.image = [UIImage newImageFromResource:self.upSelectedName];
            }else{
                self.rightImage.image = [UIImage newImageFromResource:self.upIconName];
            }
            break;
        }
            
        case ItemArrowDown:{
            if (selected) {
                self.rightImage.image = [UIImage newImageFromResource:self.downSelectedName];
            }else{
                self.rightImage.image = [UIImage newImageFromResource:self.downIconName];
            }
            break;
        }
        default:
            break;
    }
    
}


#pragma mark -
#pragma mark 右边的按钮
-(UIImageView *)rightImage{
    
    if (!_rightImage) {
        _rightImage = [[UIImageView alloc]init];
        _rightImage.frame = CGRectMake(79, 14, 9, 7);
        [self addSubview:_rightImage];
    }
    return _rightImage;
}
@end
