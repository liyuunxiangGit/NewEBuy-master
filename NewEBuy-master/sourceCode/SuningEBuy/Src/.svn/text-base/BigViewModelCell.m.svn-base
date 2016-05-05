//
//  BigViewModelCell.m
//  SuningEBuy
//
//  Created by chupeng on 14-8-21.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "BigViewModelCell.h"

@implementation BigViewModelCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
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
}

- (void)setLeftItem:(DataProductBasic *)item
{
    if (!item)
    {
        self.leftView.hidden = YES;
    }
    else
    {
        self.leftView.hidden = NO;
        [self.leftView setItem:item];
    }
}

- (void)setRightItem:(DataProductBasic *)item
{
    if (!item)
    {
        self.rightView.hidden = YES;
    }
    else
    {
        self.rightView.hidden = NO;
        [self.rightView setItem:item];
    }
}

- (BigViewModelCellSubView *)leftView
{
    if (!_leftView)
    {
        _leftView = [[BigViewModelCellSubView alloc] initWithFrame:CGRectMake(10, 0, 145, 230)];
        _leftView.hidden = YES;
        [self.contentView addSubview:_leftView];
        
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
        [_leftView addGestureRecognizer:ges];
    }
    
    return _leftView;
}


- (BigViewModelCellSubView *)rightView
{
    if (!_rightView)
    {
        _rightView = [[BigViewModelCellSubView alloc] initWithFrame:CGRectMake(165, 0, 145, 230)];
        _rightView.hidden = YES;
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
        [_rightView addGestureRecognizer:ges];
        [self.contentView addSubview:_rightView];
    }
    
    return _rightView;
}

- (void)viewTapped:(UITapGestureRecognizer *)ges
{
    BigViewModelCellSubView *view = (BigViewModelCellSubView *)ges.view;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTappedBigModelView:)])
    {
        if (view.dto)
        {
            [self.delegate didTappedBigModelView:view.dto];
        }
    }
   
}

@end
