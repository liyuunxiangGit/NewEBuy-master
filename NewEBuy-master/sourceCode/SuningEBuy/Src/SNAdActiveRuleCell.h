//
//  SNAdActiveRuleCell.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-8-19.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SNAdActiveRuleCellDelegate;

@interface SNAdActiveRuleCell : UITableViewCell


@property (nonatomic, weak) id<SNAdActiveRuleCellDelegate>    delegate;
@property (nonatomic, strong) UILabel                           *adTitleLabel;
@property (nonatomic, strong) UILabel                           *adContentLabel;

@property (nonatomic, strong) UIImageView                       *sepImageView;
@property (nonatomic, strong) UIImageView                       *upAndDownImageView;

+ (CGFloat) height:(NSString *)item;

- (void)setAdContent:(NSString *)content isUpAndDown:(BOOL)isUp;

//- (void)showDetail;
//- (void)hideDetail;

@end


@protocol SNAdActiveRuleCellDelegate <NSObject>

-(void)setAdRowHeight:(CGFloat)height;

@end