//
//  NBStickGroupView.m
//  SuningEBuy
//
//  Created by suning on 14-9-28.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NBStickGroupView.h"

@interface NBStickGroupView ()
@property (nonatomic,strong) IBOutlet UILabel    *titleLabel;
@property (nonatomic,strong) IBOutlet UIButton   *coverButton;
@end


@implementation NBStickGroupView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (NBStickGroupView *)stickGroupView {
    return ([[NSBundle mainBundle] loadNibNamed:@"NBStickGroupView"
                                         owner:nil options:nil][0]);
}

- (void)setSection:(NSUInteger)section {
    _section = section;
    
    _coverButton.tag = _section;
}

- (IBAction)on_coverButton_clicked:(UIButton *)sender {
    
    if (nil != _clickedSection) {
        _clickedSection(@(sender.tag));
    }
}

- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}

@end
