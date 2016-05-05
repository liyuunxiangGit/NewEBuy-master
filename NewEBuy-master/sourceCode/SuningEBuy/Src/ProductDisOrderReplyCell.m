//
//  ProductDisOrderReplyCell.m
//  SuningEBuy
//
//  Created by xy ma on 12-2-22.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "ProductDisOrderReplyCell.h"

@implementation ProductDisOrderReplyCell

@synthesize titleLbl = _titleLbl;
@synthesize timeLbl = _timeLbl;
@synthesize contentLbl = _contentLbl;
@synthesize nameLbl = _nameLbl;
@synthesize dataSource = _dataSource;

-(void)dealloc{
    
    TT_RELEASE_SAFELY(_titleLbl);
    TT_RELEASE_SAFELY(_timeLbl);
    TT_RELEASE_SAFELY(_contentLbl);
    TT_RELEASE_SAFELY(_nameLbl);
    TT_RELEASE_SAFELY(_dataSource);
}


- (void)layoutSubviews{
	
	[super layoutSubviews];

    CGSize size_title = returnTextFrame(self.titleLbl.text, kProductAppraisalCELL_label_title_font, kProductAppraisalCELL_label_title_width, UILineBreakModeCharacterWrap);
    CGSize size_content = returnTextFrame(self.contentLbl.text, kProductAppraisalCELL_label_content_font, kProductAppraisalCELL_label_content_width, UILineBreakModeCharacterWrap);
    CGSize size_name = returnTextFrame(self.nameLbl.text, kProductAppraisalCELL_label_name_font, kProductAppraisalCELL_label_name_width, UILineBreakModeCharacterWrap);
    
    
    self.titleLbl.frame = CGRectMake(10, 5, kProductAppraisalCELL_label_title_width, size_title.height);
    self.timeLbl.frame = CGRectMake(kProductAppraisalCELL_label_title_width+10, 5, kProductAppraisalCELL_label_time_width, 16);
    self.contentLbl.frame = CGRectMake(10, size_title.height + 10, kProductAppraisalCELL_label_content_width, size_content.height);
    self.nameLbl.frame = CGRectMake(10, size_title.height + 10 + size_content.height +5 , kProductAppraisalCELL_label_name_width, size_name.height);
    
}

-(void)setItem:(DisProductDetailsDTO *)item
{
    if (item == nil)
    {
        return;
    }
    self.dataSource = item;
   
    self.titleLbl.text = (item.title == nil || [item.title  isEqualToString:@""]) ?L(@"Display Order No Title"):returnRightString(item.title);
    self.timeLbl.text = (item.createTime == nil || [item.createTime  isEqualToString:@""])?L(@"Display Order No CreateTime"):item.createTime;
    self.contentLbl.text = (item.content == nil || [item.content  isEqualToString:@""]) ?L(@"Display Order No Content"):returnRightString(item.content);
    self.nameLbl.text = (item.nickName == nil||(NSNull *)item.nickName == [NSNull null]) ?L(@"Display Order No name"):returnRightString(item.nickName);
       
    [self setNeedsLayout];
    
}


//"articleId": 23164,
//"authorId": 33012344785,
//"answerType": 0,
//"title": "",
//"createTime": "2012-02-15 09:48:03",
//"content": "高低杠",
//"qaType": 1,
//"nickName": null
+(CGFloat) height:(DisProductDetailsDTO *)item{
    if (item) {
        
        NSString *str_title = (item.title == nil || [item.title  isEqualToString:@""]) ?@"title":item.title;
        // NSString *str_time = (item.createTime == nil || [item.createTime  isEqualToString:@""])?@"no time":item.createTime;
        NSString *str_content = (item.content == nil || [item.content  isEqualToString:@""]) ?@"no content":item.content;
        NSString *str_name = (item.nickName == nil||(NSNull *)item.nickName == [NSNull null]) ?L(@"Display Order No name"):item.nickName;
        
        CGSize size_title = returnTextFrame(returnRightString(str_title), kProductAppraisalCELL_label_title_font, kProductAppraisalCELL_label_title_width, UILineBreakModeCharacterWrap);
        CGSize size_content = returnTextFrame(str_content, kProductAppraisalCELL_label_content_font, kProductAppraisalCELL_label_content_width, UILineBreakModeCharacterWrap);
        CGSize size_name = returnTextFrame(returnRightString(str_name), kProductAppraisalCELL_label_name_font, kProductAppraisalCELL_label_name_width, UILineBreakModeCharacterWrap);
        
        return size_title.height + size_content.height +size_name.height + 20;   
	}
	return 50;
}


+ (CGFloat) heightforText:(NSString *)stringContent{
    
    UIFont *font = [UIFont systemFontOfSize:14];

    if (stringContent) {
         CGSize size_content = returnTextFrame(stringContent, font, 290, UILineBreakModeCharacterWrap);
        return size_content.height+20;

        }

   
    return 50;
}

-(UILabel *)titleLbl{
    if (nil == _titleLbl) {
        _titleLbl =  [[UILabel alloc]init];
        _titleLbl.backgroundColor = [UIColor clearColor];
        _titleLbl.textAlignment = UITextAlignmentLeft;
        _titleLbl.numberOfLines = 0;
        _titleLbl.textColor = [UIColor orangeColor];
        _titleLbl.font = kProductAppraisalCELL_label_title_font;
        [self.contentView addSubview:_titleLbl];
    }
    return _titleLbl;
}
-(UILabel *)timeLbl{
    if (nil == _timeLbl) {
        _timeLbl = [[UILabel alloc]init];
        _timeLbl.backgroundColor = [UIColor clearColor];
        _timeLbl.textAlignment = UITextAlignmentLeft;
        _timeLbl.numberOfLines = 1;
        _timeLbl.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_timeLbl];
    }
    return _timeLbl;
}
-(UILabel *)contentLbl{
    if (nil == _contentLbl) {
        _contentLbl = [[UILabel alloc]init];
        _contentLbl.backgroundColor = [UIColor clearColor];
        _contentLbl.textAlignment = UITextAlignmentLeft;
        _contentLbl.numberOfLines = 0;
        _contentLbl.font = kProductAppraisalCELL_label_content_font;
        [self.contentView addSubview:_contentLbl];
    }
    return _contentLbl;
}
-(UILabel *)nameLbl{
    if (nil == _nameLbl) {
        _nameLbl = [[UILabel alloc]init];
        _nameLbl.backgroundColor = [UIColor clearColor];
        _nameLbl.textAlignment = UITextAlignmentLeft;
        _nameLbl.numberOfLines = 0;
        _nameLbl.font = kProductAppraisalCELL_label_name_font;
        [self.contentView addSubview:_nameLbl];
    }
    return  _nameLbl;
}

@end
