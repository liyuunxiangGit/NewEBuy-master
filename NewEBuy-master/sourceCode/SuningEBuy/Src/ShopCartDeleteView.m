//
//  ShopCartDeleteView.m
//  SuningEBuy
//
//  Created by 孔斌 on 14-8-20.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ShopCartDeleteView.h"
#import "UITableViewCell+BgView.h"

@implementation ShopCartDeleteView


+ (instancetype)view
{
    ShopCartDeleteView *view = [ShopCartDeleteView new];
    view.backgroundColor = RGBACOLOR(255, 255, 255, 0.9);
    view.frame = CGRectMake(0, 0, 320, 60);
    
    UIImageView *line = [[UIImageView alloc] init];
    line.frame = CGRectMake(0, 0, 320, 0.5);
    line.image = [UIImage streImageNamed:@"line.png"];
    [view addSubview:line];
    
    return view;
}

#pragma mark ----------------------------- set logic

- (void)setLogic:(ShopCartLogic *)logic
{
    if (_logic != logic)
    {
        _logic = logic;
        
    }
    
    self.checkButton.selected = self.logic.isEditAllSelect;
    
    self.checkLabel.text = L(@"SCSelectAll");
    
    int count = self.logic.checkedEditCartItemCount;
    if (count > 0)
    {
        self.deleteButton.enabled = YES;
    }
    else
    {
        self.deleteButton.enabled = NO;
    }
}

- (UIButton *)checkButton
{
    if (!_checkButton) {
        _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _checkButton.frame = CGRectMake(0, 10, 50, 40);
        _checkButton.backgroundColor = [UIColor clearColor];
        [_checkButton setImage:[UIImage streImageNamed:@"checkbox_unselect.png"]
                      forState:UIControlStateNormal];
        [_checkButton setImage:[UIImage streImageNamed:@"checkbox_selected.png"]
                      forState:UIControlStateSelected];
        [self addSubview:_checkButton];
    }
    return _checkButton;
}

- (UILabel *)checkLabel
{
    if (!_checkLabel) {
        _checkLabel = [[UILabel alloc] init];
        _checkLabel.frame = CGRectMake(50, 15, 100, 30);
        _checkLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_checkLabel];
    }
    return _checkLabel;
}

- (UIButton *)deleteButton
{
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.frame = CGRectMake(220, 10, 100, 40);
        _deleteButton.backgroundColor = [UIColor clearColor];
//        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setImage:[UIImage streImageNamed:@"shopcart_delete_normal.png"]
                       forState:UIControlStateNormal];
        [_deleteButton setImage:[UIImage imageNamed:@"shopcart_delete_highlight.png"]
                       forState:UIControlStateHighlighted];
        [_deleteButton setImage:[UIImage streImageNamed:@"shopcart_delete_disabled.png"]
                       forState:UIControlStateDisabled];
//        [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:_deleteButton];
    }
    return _deleteButton;
}

@end
