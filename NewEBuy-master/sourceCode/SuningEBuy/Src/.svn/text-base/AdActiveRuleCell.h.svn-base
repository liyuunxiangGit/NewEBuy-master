//
//  AdActiveRuleCell.h
//  SuningEBuy
//
//  Created by wei xie on 12-8-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RuleCopyTextView.h"

@protocol AdActiveRuleCellDelegate <NSObject>

-(void)setAdRowHeight:(CGFloat)height;

@end
#define kOffsetHight     8

@interface AdActiveRuleCell : UITableViewCell{
    
    UILabel     *ruleTitleLabel_;
    RuleCopyTextView     *ruleContentLabel_;
    
    UIImageView *lineView_;
    
    NSString    *ruleContent_;
    
    UIButton *showDetailBtn_;
    
    UIButton *_bigShowDetailBtn;
    
    UIView   *ruleContentView_;
    
    UIView *_backView;
    
    id <AdActiveRuleCellDelegate> __weak delegate;
    
    //add by zhangbeibei:20141021   判断活动文字label是否是展示全部的文字行，初始状态下默认最多展示2行，当折叠按钮打开的时候，应该展示全部的行
    BOOL showLabelFullLine;
} 

@property (nonatomic,strong) UILabel *ruleTitleLabel;
@property (nonatomic,strong) RuleCopyTextView *ruleContentLabel;
@property (nonatomic,strong) NSString *ruleContent;
@property (nonatomic,strong) UIImageView *lineView;
@property (nonatomic,strong) UIButton *showDetailBtn;
@property (nonatomic,strong) UIView   *ruleContentView;
@property (nonatomic,weak) id<AdActiveRuleCellDelegate> delegate;

@property (nonatomic,strong) UIButton *bigShowDetailBtn;

@property (nonatomic,strong) UIView *backView;

+ (CGFloat) height:(NSString *)ruleString;
+ (CGFloat) cellHeight:(NSString *)ruleString;

+ (BOOL)canShowRuleCell:(NSString *)rule;

@end
