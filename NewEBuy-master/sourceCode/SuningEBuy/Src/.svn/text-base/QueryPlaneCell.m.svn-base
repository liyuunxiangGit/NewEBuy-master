//
//  QueryPlaneCell.m
//  SuningEBuy
//
//  Created by lanfeng on 12-5-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QueryPlaneCell.h"

@implementation QueryPlaneCell

@synthesize whiteBackView = _whiteBackView;
@synthesize leftLabel = _leftLabel;
@synthesize rightLabel = _rightLabel;
@synthesize lineView = _lineView;
@synthesize arrowView = _arrowView;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_whiteBackView);
    TT_RELEASE_SAFELY(_leftLabel);
    TT_RELEASE_SAFELY(_rightLabel);
    TT_RELEASE_SAFELY(_lineView);
    TT_RELEASE_SAFELY(_arrowView);
}

#pragma mark -
#pragma mark 计算cell高度
+(CGFloat)height:(NSInteger)index{
    
    if (index == 0) {
        return 64;
    }else{
        return 44;
    }
}

-(void)setItem:(NSInteger)index
      leftItem:(NSString *)leftItem
     rightItem:(NSString *)rightItem{
    
    CGFloat originY = 0;
    
    if (index == 0) {
        
        originY+=20;
        self.lineView.hidden = YES;
        
    }else{
        self.lineView.hidden = NO;
    }
    
    self.backgroundColor = [UIColor clearColor];
    self.whiteBackView.frame = CGRectMake(0, originY, 320, 44);
    self.leftLabel.frame = CGRectMake(20, originY, 80, 44);
    self.rightLabel.frame = CGRectMake(100, originY, 150, 44);
    self.lineView.frame = CGRectMake(0, 0, 320, 1);
    self.arrowView.frame = CGRectMake(290, originY+15, 9, 15);
    
    self.leftLabel.text = leftItem;
    self.rightLabel.text = rightItem;
    
    [self.contentView bringSubviewToFront:self.lineView];
}

#pragma mark -
#pragma mark UIView
-(UIView *)whiteBackView{
    if (!_whiteBackView) {
        _whiteBackView = [[UIView alloc]init];
        _whiteBackView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_whiteBackView];
    }
    return _whiteBackView;
}


-(UILabel *)leftLabel{

    if (_leftLabel == nil) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.backgroundColor = [UIColor clearColor];
        _leftLabel.font = [UIFont boldSystemFontOfSize:16.0];
        _leftLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_leftLabel];
    }
    return _leftLabel;
}

-(UILabel *)rightLabel{
    
    if (_rightLabel == nil) {
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.backgroundColor = [UIColor clearColor];
        _rightLabel.font = [UIFont boldSystemFontOfSize:16.0];
        _rightLabel.textAlignment = UITextAlignmentRight;
        _rightLabel.textColor = [UIColor orange_Red_Color];
        [self.contentView addSubview:_rightLabel];
    }
    return _rightLabel;
}

-(UIImageView *)lineView{
    if (!_lineView) {
        _lineView = [[UIImageView alloc]init];
        _lineView.image = [UIImage newImageFromResource:@"line.png"];
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}


-(UIImageView *)arrowView{
    
    if (!_arrowView) {
        _arrowView = [[UIImageView alloc]init];
        _arrowView.image = [UIImage newImageFromResource:@"arrow_right_btn.png"];
        [self.contentView addSubview:_arrowView];
    }
    return _arrowView;
}

@end
