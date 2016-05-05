//
//  ProductConsultantCell.m
//  SuningEBuy
//
//  Created by 漫 王 on 12-9-24.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ProductConsultantCell.h"

@implementation ProductConsultantCell

@synthesize nameLabel = _nameLabel;

@synthesize timeLabel = _timeLabel;

@synthesize contentLabel = _contentLabel;

@synthesize answerLabel = _answerLabel;

@synthesize answerContentLabel = _answerContentLabel;

- (void)dealloc{
    
    TT_RELEASE_SAFELY(_nameLabel);
    
    TT_RELEASE_SAFELY(_timeLabel);
    
    TT_RELEASE_SAFELY(_contentLabel);
    
    TT_RELEASE_SAFELY(_answerLabel);
    
    TT_RELEASE_SAFELY(_answerContentLabel);
    
}


- (UILabel *)nameLabel{
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc]init];
        
        _nameLabel.textAlignment = UITextAlignmentLeft;
        
        _nameLabel.numberOfLines = 0;
        
        _nameLabel.textColor = RGBCOLOR(40, 91, 161);
        
        _nameLabel.backgroundColor = [UIColor clearColor];
        
        _nameLabel.font = kProductAskCELL_label_name_font;
        
        [self.contentView addSubview:_nameLabel];
    }
    
    return _nameLabel;
}


- (UILabel *)timeLabel{
    
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc]init];
        
        _timeLabel.adjustsFontSizeToFitWidth = YES;
        
        _timeLabel.textAlignment = UITextAlignmentLeft;
        
        _timeLabel.numberOfLines = 1;
        
        _timeLabel.backgroundColor = [UIColor clearColor];
        
        _timeLabel.textColor = [UIColor lightGrayColor];
        
        _timeLabel.font = kProductAskCELL_label_time_font;
        
        [self.contentView addSubview:_timeLabel];
    }
    
    return _timeLabel;
}

- (UILabel *)contentLabel{
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc]init];
        
        _contentLabel.textAlignment =UITextAlignmentLeft;
        
        _contentLabel.numberOfLines = 0;
        
        _contentLabel.backgroundColor = [UIColor clearColor];
        
        _contentLabel.font = kProductAskCELL_label_content_font;
        
        _contentLabel.textColor = [UIColor darkGrayColor];
        
        [self.contentView addSubview:_contentLabel];
    }
    
    return _contentLabel;
}


- (UILabel *)answerLabel{
    if (!_answerLabel) {
        
        _answerLabel = [[UILabel alloc]init];
        
        _answerLabel.textAlignment = UITextAlignmentLeft;
        
        _answerLabel.numberOfLines = 0;
        
        _answerLabel.backgroundColor = [UIColor clearColor];
        
        _answerLabel.font = kProductAskCELL_label_answername_font;
        
        _answerLabel.textColor = RGBCOLOR(254, 104, 0);
        
        [self.contentView addSubview:_answerLabel];
    }
    
    return _answerLabel;
}

- (UILabel *)answerContentLabel{
    if (!_answerContentLabel) {
        
        _answerContentLabel = [[UILabel alloc]init];
        
        _answerContentLabel.textAlignment = UITextAlignmentLeft;
        
        _answerContentLabel.numberOfLines = 0;
        
        _answerContentLabel.backgroundColor = [UIColor clearColor];
        
        _answerContentLabel.font = kProductAskCELL_label_content_font;
        
       // _answerContentLabel.textColor = RGBCOLOR(254, 104, 0);
        
        [self.contentView addSubview:_answerContentLabel];
    }
    
    return _answerContentLabel;
}

- (void)setItem:(ProductConsultantDTO *)item{
    if (_item != item) {
        
        
        _item = item;
        
        NSString *str_name = ((_item.consultant==nil || [_item.consultant isEqualToString:@""])?L(@"Some One"):_item.consultant);
    
        NSString *str_time = (_item.consultantTime == nil ?L(@"Unknown"):_item.consultantTime);
        
        NSString *str_content = (_item.consultantContent == nil? @"":_item.consultantContent);
        
        NSString *str_answer = (_item.consultantReply == nil?@"":_item.consultantReply);
        
        self.nameLabel.text = returnRightString(str_name);
        
        self.timeLabel.text = returnRightString(str_time);
        
        self.contentLabel.text = returnRightString(str_content);
        
        self.answerLabel.text = [NSString stringWithFormat:@"%@:",L(@"SuningReply")];
        
        self.answerContentLabel.text = returnRightString(str_answer);
        
        [super setNeedsLayout];
    }
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGSize size_name = returnTextFrame(self.nameLabel.text, kProductAskCELL_label_name_font, kProductAskCELL_label_name_width, UILineBreakModeCharacterWrap);
    
    CGSize size_content = returnTextFrame(self.contentLabel.text, kProductAskCELL_label_content_font, kProductAskCELL_label_content_width, UILineBreakModeCharacterWrap);
    
    CGSize size_answerName = returnTextFrame(self.answerLabel.text, kProductAskCELL_label_answername_font, kProductAskCELL_label_answername_width, UILineBreakModeCharacterWrap);
    
    CGSize size_answerContent =returnTextFrame(self.answerContentLabel.text, kProductAskCELL_label_answercontent_font, kProductAskCELL_label_answercontent_width, UILineBreakModeCharacterWrap);
    
    self.nameLabel.frame = CGRectMake(10, 5, kProductAskCELL_label_name_width, size_name.height);
    
    self.timeLabel.frame = CGRectMake(180, 5, kProductAskCELL_label_time_width, 16);
    
    self.contentLabel.frame = CGRectMake(10, size_name.height+10, kProductAskCELL_label_content_width, size_content.height);
    
    self.answerLabel.frame = CGRectMake(10, 20+size_name.height+size_content.height, kProductAskCELL_label_answername_width, size_answerName.height);
    
    self.answerContentLabel.frame = CGRectMake(10, 25+size_name.height+size_content.height+size_answerName.height,kProductAskCELL_label_answercontent_width, size_answerContent.height);
    
    UIImageView *separatorLine =(UIImageView *)[self.contentView viewWithTag:9876];
    
    if (separatorLine == nil) {
        
        UIImageView *separatorLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.contentView.bottom-1, 320, 2)];
        
        separatorLine.tag = 9876;
        
        separatorLine.image = [UIImage imageNamed:@"cellSeparatorLine.png"];

        [self.contentView addSubview:separatorLine];
        
        TT_RELEASE_SAFELY(separatorLine);
    }
    
}

- (void)prepareForReuse{
    
    UIImageView *separatorLine = (UIImageView *)[self.contentView viewWithTag:9876];
    
    [separatorLine removeFromSuperview];
}
  
+ (CGFloat)height:(ProductConsultantDTO *)item{
    
    NSString *str_name = (item.consultant==nil || [item.consultant isEqualToString:@""])?L(@"Some One"): item.consultant ;
  
    NSString *str_content = item.consultantContent ==nil?@"": item.consultantContent ;
   
    NSString *str_answer = item.consultantReply ==nil?@"": item.consultantReply ;
    
    CGSize  size_name = returnTextFrame(returnRightString(str_name), kProductAskCELL_label_name_font, kProductAskCELL_label_name_width, UILineBreakModeCharacterWrap);
  
    CGSize size_content = returnTextFrame(returnRightString(str_content), kProductAskCELL_label_content_font, kProductAskCELL_label_content_width, UILineBreakModeCharacterWrap);
    
    CGSize size_answername = returnTextFrame(kProductAskCELL_label_answerName, kProductAskCELL_label_answername_font, kProductAskCELL_label_answername_width, UILineBreakModeCharacterWrap);
   
    CGSize size_answercontent = returnTextFrame(returnRightString(str_answer), kProductAskCELL_label_answercontent_font, kProductAskCELL_label_answercontent_width, UILineBreakModeCharacterWrap);
    
    return size_name.height + size_content.height +size_answername.height +size_answercontent.height+40;
}

@end
