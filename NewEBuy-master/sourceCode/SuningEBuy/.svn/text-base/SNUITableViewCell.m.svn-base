//
//  CommonCell.m
//  SNFramework
//
//  Created by  liukun on 13-11-6.
//  Copyright (c) 2013年 liukun. All rights reserved.
//

#import "SNUITableViewCell.h"


@implementation SNUITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        if (IOS7_OR_LATER) {
            self.backgroundColor = [UIColor whiteColor];
        }else{
            UIView *bgView = [UIView new];
            bgView.backgroundColor = [UIColor whiteColor];
            self.backgroundView = bgView;
        }
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end
