//
//  NewProductAppraisalCell.m
//  SuningEBuy
//
//  Created by 孔斌 on 13-8-27.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NewProductAppraisalCell.h"

@implementation NewProductAppraisalCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier{
	
	if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
		
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		self.autoresizesSubviews = YES;
		
		self.contentView.backgroundColor = [UIColor clearColor];
    }
	return self;
}

- (UIImageView *)cellSeperatorView{
    
    if (!_cellSeperatorView) {
        
        _cellSeperatorView = [[UIImageView alloc] init];
        
        UIImage *cellSeperatorImage = [UIImage streImageNamed:@"line.png"];
        
        _cellSeperatorView.image = cellSeperatorImage;
        
        _cellSeperatorView.contentMode = UIViewContentModeScaleAspectFill;
        
//        [self.contentView addSubview:_cellSeperatorView];
    }
    
    return _cellSeperatorView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size_content = returnTextFrame(self.contentLabel.text, kProductAppraisalCELL_label_content_font, kProductAppraisalCELL_label_content_width, UILineBreakModeCharacterWrap);
    CGSize size_name = returnTextFrame(self.nickNameLabel.text, kProductAppraisalCELL_label_name_font, kProductAppraisalCELL_label_name_width, UILineBreakModeCharacterWrap);
    CGSize size_supContent = returnTextFrame(self.suplContent.text, [UIFont boldSystemFontOfSize:12.0], 280, UILineBreakModeCharacterWrap);

    
    self.reviewTimeLabel.frame = CGRectMake(kProductAppraisalCELL_label_title_width + 10, 10, kProductAppraisalCELL_label_time_width , 16);
    self.nickNameLabel.frame = CGRectMake(15, 10 , kProductAppraisalCELL_label_name_width, size_name.height);
    
//    if ([self.Dto.bestTag isEqualToString:@"1"]) {
//        self.bestTagView.hidden = NO;
//        self.bestTagView.frame = CGRectMake(10, self.nickNameLabel.bottom + 4, 13, 15);
//    }else{
//        self.bestTagView.hidden = YES;
//        self.bestTagView.frame = CGRectMake(5, 0, 0, 0);
//    }

//    self.starDesc.frame = CGRectMake(self.bestTagView.right + 5, self.nickNameLabel.bottom + 4, 60, 15);
//    self.starView.frame = CGRectMake(self.starDesc.right, self.nickNameLabel.bottom + 5, 100, 10);
//    self.cellSeperatorView.frame = CGRectMake(0, self.size.height - 1, 320, 0.5);
    
    self.contentLabel.frame = CGRectMake(15, self.nickNameLabel.bottom + 4, kProductAppraisalCELL_label_content_width, size_content.height);
    
    if (IsStrEmpty(self.Dto.suplContent)) {
        self.suplContent.hidden = YES;
        self.suplContent.frame = CGRectMake(0, 0, 0, 0);
        self.suplName.frame = CGRectMake(15, self.contentLabel.bottom+4, 290, 20);
    }else{
        self.suplContent.hidden = NO;
        self.suplContent.frame = CGRectMake(30, self.contentLabel.bottom , 260, size_supContent.height);
        self.suplName.frame = CGRectMake(15, self.suplContent.bottom+4, 290, 20);
    }
    
}

- (UILabel *)nickNameLabel
{
    if (!_nickNameLabel) {
        _nickNameLabel = [[UILabel alloc]init];
        _nickNameLabel.backgroundColor = [UIColor clearColor];
        _nickNameLabel.textAlignment = UITextAlignmentLeft;
        _nickNameLabel.numberOfLines = 0;
        _nickNameLabel.font = [UIFont systemFontOfSize:13];
        _nickNameLabel.textColor = [UIColor colorWithRed:137.0/255 green:137.0/255 blue:137.0/255 alpha:1];
        [self.contentView addSubview:_nickNameLabel];
    }
    return _nickNameLabel;
}

- (UILabel *)reviewTimeLabel
{
    if (!_reviewTimeLabel) {
        _reviewTimeLabel = [[UILabel alloc]init];
        _reviewTimeLabel.backgroundColor = [UIColor clearColor];
        _reviewTimeLabel.font = [UIFont systemFontOfSize:12.0];
        _reviewTimeLabel.textAlignment = UITextAlignmentLeft;
        _reviewTimeLabel.numberOfLines = 1;
        _reviewTimeLabel.adjustsFontSizeToFitWidth = YES;
        _reviewTimeLabel.textColor = [UIColor colorWithRed:137.0/255 green:137.0/255 blue:137.0/255 alpha:1];
        [self.contentView addSubview:_reviewTimeLabel];
    }
    return _reviewTimeLabel;
}

-(UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textAlignment = UITextAlignmentLeft;
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [UIColor colorWithRed:68.0/255 green:68.0/255 blue:68.0/255 alpha:1];
        _contentLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}


- (EvaluationView *)starView{
    
    if (!_starView) {
        
        _starView = [[EvaluationView alloc] init];
        
        _starView.backgroundColor = [UIColor clearColor];
        
//        [self.contentView addSubview:_starView];
    }
    return _starView;
}

- (UILabel *)starDesc
{
    if (!_starDesc) {
        _starDesc = [[UILabel alloc] init];
        _starDesc.backgroundColor = [UIColor clearColor];
        _starDesc.text = [NSString stringWithFormat:@"%@：",L(@"Product_Satisfaction")];
        _starDesc.font = [UIFont boldSystemFontOfSize:13.0];
        _starDesc.textColor = [UIColor colorWithRed:68.0/255 green:68.0/255 blue:68.0/255 alpha:1];
        [self.contentView addSubview:_starDesc];
    }
    return _starDesc;
}

- (UIImageView *)bestTagView
{
    if (!_bestTagView) {
        _bestTagView = [[UIImageView alloc] init];
        _bestTagView.image = [UIImage imageNamed:@"best_evalution.png"];
        _bestTagView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_bestTagView];
    }
    return _bestTagView;
}

- (UILabel *)suplContent
{
    if (!_suplContent) {
        _suplContent = [[UILabel alloc] init];
        _suplContent.backgroundColor = [UIColor clearColor];
        _suplContent.numberOfLines = 0;
        _suplContent.font = [UIFont boldSystemFontOfSize:12.0];
        _suplContent.textColor = [UIColor colorWithRed:137.0/255 green:137.0/255 blue:137.0/255 alpha:1];
        [self.contentView addSubview:_suplContent];
    }
    return _suplContent;
}

- (UILabel *)suplName
{
    if (!_suplName) {
        _suplName = [[UILabel alloc] init];
        _suplName.backgroundColor = [UIColor clearColor];
        _suplName.font = [UIFont systemFontOfSize:13];
        _suplName.textColor = [UIColor colorWithRed:137.0/255 green:137.0/255 blue:137.0/255 alpha:1];
        [self.contentView addSubview:_suplName];
    }
    return _suplName;
}

- (void)setItem:(NewProductAppraisalDTO *)item
{
    if (item == nil || [item isEqual:[NSNull null]])
    {
        return;
    }
    self.Dto = item;
    
    NSString *str_content = (item.content == nil?L(@"Some One"):item.content);
    NSString *str_name = [self validateName:item.nickname];
    NSString *str_reviewTime;
    NSString *str_suplName = [NSString stringWithFormat:@"%@：%@",L(@"Product_Seller"),item.supplierName];
    
    if (IsStrEmpty(item.reviewTime)) {
        self.reviewTimeLabel.text=L(@"Unknown");
    }
    else
    {
        NSString *str_reviewTime1 = [item.reviewTime substringToIndex:10];
        NSString *str_reviewTime2 = [item.reviewTime substringFromIndex:10];
        str_reviewTime = [NSString stringWithFormat:@"%@ %@",str_reviewTime1,str_reviewTime2];
        self.reviewTimeLabel.text=str_reviewTime;
    }
    
    self.contentLabel.text=returnRightString(str_content);//str_content;
    self.nickNameLabel.text=returnRightString(str_name);
    
    self.suplContent.text = returnRightString(self.Dto.suplContent);
    
    self.suplName.text = returnRightString(str_suplName);
//    [self.starView setStarsImages:self.Dto.qualityStar];
    
    [self setNeedsLayout];
}

+ (CGFloat) height:(NewProductAppraisalDTO *)item{
    if (item) {
        NSString *str_content = item.content ==nil?L(@"Some One"):item.content;
        
        NSString *str_name = nil;
        
        if (item.nickname == nil || [item.nickname isEqualToString:@""]||[item.nickname isEqualToString:@"null"]
            || [item.nickname isEqualToString:@"(null)"]) {
            str_name = L(@"Some One");
        }else{
            str_name = item.nickname;
        }
        

        CGSize size_content = returnTextFrame(returnRightString(str_content), kProductAppraisalCELL_label_content_font, kProductAppraisalCELL_label_content_width, UILineBreakModeCharacterWrap);
        CGSize size_name = returnTextFrame(returnRightString(str_name), kProductAppraisalCELL_label_name_font, kProductAppraisalCELL_label_name_width, UILineBreakModeCharacterWrap);
        
        CGSize size_supContent = returnTextFrame(returnRightString(item.suplContent), [UIFont boldSystemFontOfSize:12.0], 260, UILineBreakModeCharacterWrap);
        
        return size_content.height +size_name.height + 20 + 20 + size_supContent.height;
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

- (void)prepareForReuse
{
    UIImageView *separatorLine = (UIImageView *)[self.contentView viewWithTag:9876];
    
    [separatorLine removeFromSuperview];
}


- (NSDateFormatter *)dateFormatterServer
{
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    
    [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    
    return _dateFormatter;
}

- (NSDateFormatter *)dateFormatterClient
{
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    
    [_dateFormatter setDateFormat:[NSString stringWithFormat:@"yyyy%@MM%@dd%@HH:mm",L(@"Product_Year"),L(@"Product_Month"),L(@"Product_Day")]];
    
    return _dateFormatter;
}

@end
