//
//  CatasFilterTableViewCell.m
//  SuningEBuy
//
//  Created by chupeng on 14-8-22.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CatasFilterTableViewCell.h"

@implementation CatasFilterTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:self.cataViewCtrl.view];
        self.cataViewCtrl.view.frame = self.bounds;
        self.cataViewCtrl.view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
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

- (void)refreshWithCataList:(NSArray *)catalist
{
    self.categoryList = catalist;
    self.cataViewCtrl.categoryList = catalist;
    
    [self.cataViewCtrl.tableView reloadData];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:REFRESH_FILTERVIEWCTRL object:nil];
}

- (NewCatePickViewController *)cataViewCtrl
{
    if (!_cataViewCtrl)
    {
        _cataViewCtrl = [[NewCatePickViewController alloc] init];
    }
    
    return _cataViewCtrl;
}


@end
