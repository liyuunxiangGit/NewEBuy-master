//
//  BookAppraisalCell.m
//  SuningEBuy
//
//  Created by lanfeng on 12-5-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BookAppraisalCell.h"


@implementation BookAppraisalCell

@synthesize titleLbl = _titleLbl;
@synthesize timeLbl = _timeLbl;
@synthesize contentLbl = _contentLbl;
@synthesize nameLbl = _nameLbl;
@synthesize evaluationView = _evaluationView;
@synthesize dataSource = _dataSource;

-(void)dealloc{
    
    TT_RELEASE_SAFELY(_titleLbl);
    TT_RELEASE_SAFELY(_timeLbl);
    TT_RELEASE_SAFELY(_contentLbl);
    TT_RELEASE_SAFELY(_nameLbl);
    TT_RELEASE_SAFELY(_evaluationView);
    TT_RELEASE_SAFELY(_dataSource);
}


- (void)layoutSubviews{
	
	[super layoutSubviews];
    
  //  self.backgroundColor = RGBCOLOR(247, 247, 247);
    
    CGSize size_title = returnTextFrame(self.titleLbl.text, kProductAppraisalCELL_label_title_font, kProductAppraisalCELL_label_title_width, UILineBreakModeCharacterWrap);
    CGSize size_content = returnTextFrame(self.contentLbl.text, kProductAppraisalCELL_label_content_font, kProductAppraisalCELL_label_content_width, UILineBreakModeCharacterWrap);
    CGSize size_name = returnTextFrame(self.nameLbl.text, kProductAppraisalCELL_label_name_font, kProductAppraisalCELL_label_name_width, UILineBreakModeCharacterWrap);
    
    
    self.titleLbl.frame = CGRectMake(10, 5, kProductAppraisalCELL_label_title_width, size_title.height);

    self.contentLbl.frame = CGRectMake(10, 10, kProductAppraisalCELL_label_content_width, size_content.height);
    self.nameLbl.frame = CGRectMake(10,  10 + size_content.height +5 , kProductAppraisalCELL_label_name_width, size_name.height);
    
    self.timeLbl.frame = CGRectMake(kProductAppraisalCELL_label_title_width+5,  10 + size_content.height +5, kProductAppraisalCELL_label_time_width, 16);
    
    // self.evaluationView.frame = CGRectMake(self.timeLbl.left+30, self.nameLbl.top, self.evaluationView.width, self.evaluationView.height);
    
    //add separate line
    UIImageView *separatorLine = (UIImageView *)[self.contentView viewWithTag:9876];
    
    if (separatorLine == nil)
    {
        UIImageView *separatorLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.contentView.bottom-1, 320, 2)];
        
        separatorLine.tag = 9876;
        separatorLine.hidden = YES;
        separatorLine.image = [UIImage imageNamed:@"cellSeparatorLine.png"];
        
        [self.contentView addSubview:separatorLine];
        
        TT_RELEASE_SAFELY(separatorLine);
    }    
}

- (void)prepareForReuse
{
    UIImageView *separatorLine = (UIImageView *)[self.contentView viewWithTag:9876];
    
    [separatorLine removeFromSuperview];
}

/*
 - (void)drawRect:(CGRect)rect{
 [super drawRect:rect];
 CGContextRef contex = UIGraphicsGetCurrentContext();
 CGContextSetRGBStrokeColor(contex, 142.0/255.0, 161.0/255.0, 189.0/255.0, 1.0);
 CGContextSetLineWidth(contex, 1.0);
 CGContextMoveToPoint(contex, 0, self.bounds.size.height - 2);
 CGContextAddLineToPoint(contex, self.bounds.size.width, self.bounds.size.height -2);
 CGContextClosePath(contex);
 CGContextStrokePath(contex);
 }
 */
- (NSDateFormatter *)dateFormatterServer
{
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    
    [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return _dateFormatter;
}

- (NSDateFormatter *)dateFormatterClient
{
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    
    [_dateFormatter setDateFormat:[NSString stringWithFormat:@"yyyy%@MM%@dd%@HH:mm",L(@"Product_Year"),L(@"Product_Month"),L(@"Product_Day")]];
    
    return _dateFormatter;
}



- (void)setItem:(BookAppraisalDTO *)item
{
    if (item == nil || [item isEqual:[NSNull null]])
    {
        return;
    }
    
    self.dataSource = item;
    
    NSString *str_title = (item.evaluationTitle == nil? L(@"Some One"):item.evaluationTitle);
    NSString *str_time = L(@"Unknown");
    NSDate *date = [[self dateFormatterServer] dateFromString:item.evaluationTime?item.evaluationTime:@""];
    if (date)
    {
        str_time = [[self dateFormatterClient] stringFromDate:date];
    }
    NSString *str_content = (item.evaluationContents == nil?L(@"Some One"):item.evaluationContents);
    NSString *str_name = [self validateName:item.evaluationPerson];
    
    self.titleLbl.text =returnRightString(str_title);
    self.timeLbl.text = returnRightString(str_time);
    self.contentLbl.text = returnRightString(str_content);
    self.nameLbl.text = returnRightString(str_name);
    //[self.evaluationView setStarsImages:item.stars];
    
    [self setNeedsLayout];
    
}

+ (CGFloat) height:(BookAppraisalDTO *)item{
    if (item) {
//        NSString *str_title = item.evaluationTitle== nil? L(@"Some One"):item.evaluationTitle;
        NSString *str_time = item.evaluationTime==nil?L(@"Some One"):item.evaluationTime;
        NSString *str_content = item.evaluationContents ==nil?L(@"Some One"):item.evaluationContents;
        
        NSString *str_name = nil;
        
        if (item.evaluationPerson == nil || [item.evaluationPerson isEqualToString:@""]||[item.evaluationPerson isEqualToString:@"null"]
            || [item.evaluationPerson isEqualToString:@"(null)"]) {
            str_name = L(@"Some One");
        }else{
            str_name = item.evaluationPerson;
        }
        
        NSRange range = [str_time rangeOfString:@"."];
        int location = range.location;
        if (location != NSNotFound) {
            //str_time = [str_time substringToIndex:location];
        }
        
//        CGSize size_title = returnTextFrame(returnRightString(str_title), kProductAppraisalCELL_label_title_font, kProductAppraisalCELL_label_title_width, UILineBreakModeCharacterWrap);
        CGSize size_content = returnTextFrame(returnRightString(str_content), kProductAppraisalCELL_label_content_font, kProductAppraisalCELL_label_content_width, UILineBreakModeCharacterWrap);
        CGSize size_name = returnTextFrame(returnRightString(str_name), kProductAppraisalCELL_label_name_font, kProductAppraisalCELL_label_name_width, UILineBreakModeCharacterWrap);
        
        //return size_title.height + size_content.height +size_name.height + 20;
        return size_content.height +size_name.height + 20;  
	}
	return 50;
}


/*
 *  这是由于后台可能返回的昵称为 1：空；2：null；3：(null)
 *
 */
-(NSString *)validateName:(NSString *)name{
    if (name) {
        if ([name isEqualToString:@""] || [name isEqualToString:@"null"] || [name isEqualToString:@"(null)"]) 
        {
            return L(@"Some One");
            
        }else
        {
            return name;
        }
        
    }else 
    {
        return L(@"Some One");
    }
}



-(UILabel *)titleLbl{
    if (nil == _titleLbl) {
        _titleLbl =  [[UILabel alloc]init];
        _titleLbl.backgroundColor = [UIColor clearColor];
        _titleLbl.textAlignment = UITextAlignmentLeft;
        _titleLbl.numberOfLines = 0;
        _titleLbl.hidden = YES;
        _titleLbl.textColor = RGBCOLOR(40, 91, 161);
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
        _timeLbl.textColor = [UIColor colorWithRed:137.0/255 green:137.0/255 blue:137.0/255 alpha:1];
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
       // _contentLbl.font = kProductAppraisalCELL_label_content_font;
        _contentLbl.textColor = [UIColor colorWithRed:68.0/255 green:68.0/255 blue:68.0/255 alpha:1];
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
        _nameLbl.textColor = [UIColor colorWithRed:137.0/255 green:137.0/255 blue:137.0/255 alpha:1];
        [self.contentView addSubview:_nameLbl];
    }
    return  _nameLbl;
}

- (EvaluationView *)evaluationView
{
    if (!_evaluationView) {
        
        _evaluationView = [[EvaluationView alloc] init];
        
        _evaluationView.backgroundColor = [UIColor clearColor];
        
        _evaluationView.frame = CGRectMake(190, 60, 70, 19);
        
        [self.contentView addSubview:_evaluationView];
    }
    return _evaluationView;
}

@end