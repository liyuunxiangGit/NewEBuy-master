//
//  SNAdActiveRuleCell.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-8-19.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "SNAdActiveRuleCell.h"

#define kCotendSize         14
#define kOffsetHight        8

@implementation SNAdActiveRuleCell

@synthesize adContentLabel          = _adContentLabel;
@synthesize adTitleLabel            = _adTitleLabel;
@synthesize sepImageView            = _sepImageView;
@synthesize upAndDownImageView      = _upAndDownImageView;
@synthesize delegate                = _delegate;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_adTitleLabel);
    TT_RELEASE_SAFELY(_adContentLabel);
    TT_RELEASE_SAFELY(_sepImageView);
    TT_RELEASE_SAFELY(_upAndDownImageView);
    
}

+ (CGFloat)height:(NSString *)item
{
    CGFloat allCellHight = kOffsetHight;
	
	if (item != nil) {
        
        NSString *contendInfoS =  item;
        
        UIFont *cellFont =[UIFont systemFontOfSize:kCotendSize];
        CGSize labelHeight = [contendInfoS sizeWithFont:cellFont];

        CGSize mainContendSize = [contendInfoS heightWithFont:cellFont width:273 linebreak:UILineBreakModeCharacterWrap];
        NSInteger numberOfLines = ceil(mainContendSize.height/labelHeight.height);
        if (numberOfLines > 1) {
//            NSString *tempString = [NSString stringWithFormat:@"        %@",contendInfoS];
//            
//            mainContendSize = [tempString heightWithFont:cellFont width:273 linebreak:UILineBreakModeCharacterWrap];
            
            allCellHight = labelHeight.height*2+6+10;
            
        }else
        {
            allCellHight = labelHeight.height*2+10;
        }
                
	}
	
	return  allCellHight;
}

- (UILabel *)adTitleLabel
{
    if (!_adTitleLabel) {
        _adTitleLabel = [[UILabel alloc] init];
        
        _adTitleLabel.backgroundColor = [UIColor clearColor];
        
        _adTitleLabel.textAlignment = UITextAlignmentCenter;
        
        _adTitleLabel.textColor = RGBCOLOR(182,11,87);
        
        _adTitleLabel.font = [UIFont fontWithName:@"Verdana-BoldItalic" size:20];
        
        _adTitleLabel.numberOfLines = 0;
        
        _adTitleLabel.text = L(@"activeRule");
        
        [self.contentView addSubview:_adTitleLabel];
    }
    return _adTitleLabel;
}

- (UILabel *)adContentLabel
{
    if (!_adContentLabel) {
        _adContentLabel = [[UILabel alloc] init];
        
        _adContentLabel.backgroundColor = [UIColor clearColor];
        
        _adContentLabel.textAlignment = UITextAlignmentCenter;
        
        _adContentLabel.textColor = [UIColor darkGrayColor];
        
        _adContentLabel.font = [UIFont systemFontOfSize:14];
        
        _adContentLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        
        _adContentLabel.userInteractionEnabled = YES;
        
        [self.contentView addSubview:_adContentLabel];
    }
    return _adContentLabel;
}

- (UIImageView *)sepImageView
{
    if (!_sepImageView)
    {
        _sepImageView = [[UIImageView alloc] init];
        
        _sepImageView.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_sepImageView];
    }
    return _sepImageView;
}

- (UIImageView *)upAndDownImageView
{
    if (!_upAndDownImageView)
    {
        _upAndDownImageView = [[UIImageView alloc] init];
        
        _upAndDownImageView.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_upAndDownImageView];
    }
    return _upAndDownImageView;
}


- (void)setAdContent:(NSString *)content isUpAndDown:(BOOL)isUp
{
    self.adTitleLabel.frame = CGRectMake(0, 0, 320, 30);
    if (isUp) {
        self.adContentLabel.numberOfLines = 2;
        self.adContentLabel.frame = CGRectMake(0, 30, 320, 40);
        self.adContentLabel.text = content;
    }else{
        self.adContentLabel.numberOfLines = 0;
        self.adContentLabel.frame = CGRectMake(0, 30, 320, 50);
        self.adContentLabel.text = content;
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews
{    
    [super layoutSubviews];
}


@end
