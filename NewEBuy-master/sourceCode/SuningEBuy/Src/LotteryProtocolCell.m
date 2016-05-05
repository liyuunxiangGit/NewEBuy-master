//
//  LotteryProtocolCell.m
//  SuningEBuy
//
//  Created by david david on 12-7-9.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "LotteryProtocolCell.h"

@interface LotteryProtocolCell()

-(void)checkButtonAction;

@end

@implementation LotteryProtocolCell

@synthesize backgroundImageView = _backgroundImageView;
@synthesize checkButton = _checkButton;
@synthesize desLbl = _desLbl;
@synthesize linkUrlLbl = _linkUrlLbl;
@synthesize isAgreeWithPro = _isAgreeWithPro;
@synthesize delegate;


- (void)dealloc {
    
    TT_RELEASE_SAFELY(_backgroundImageView);
    TT_RELEASE_SAFELY(_checkButton);
    TT_RELEASE_SAFELY(_desLbl);
    TT_RELEASE_SAFELY(_linkUrlLbl);
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.accessoryType = UITableViewCellAccessoryNone;
        
        //        [self.contentView addSubview:self.backgroundImageView];
        
        [self.contentView addSubview:self.checkButton];
        
        [self.contentView addSubview:self.desLbl];
        
        [self.contentView addSubview:self.linkUrlLbl];
        
        self.isAgreeWithPro = YES;
        
    }
    return self;
}


-(UIImageView *)backgroundImageView{
    
    if (_backgroundImageView == nil) {
        
//                _backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
//        
//                _backgroundImageView.image = [UIImage imageNamed:@"lottery_item_bottom_background.png"];
    }
    
    return _backgroundImageView;
}

-(UIButton *)checkButton{
    
    if (_checkButton == nil) {
        
        _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _checkButton.frame = CGRectMake(10, 10, 20, 20);
        
        UIImage *image = [UIImage imageNamed:@"singleCheck_selected"];
        
        [_checkButton setBackgroundImage:image forState:UIControlStateNormal];
        
        [_checkButton addTarget:self action:@selector(checkButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _checkButton;
}

-(UILabel *)desLbl{
    
    if (_desLbl == nil) {
        
        _desLbl = [[UILabel alloc]init];
        
        _desLbl.text = L(@"VPAlreadyReadAndAgree");
        
        _desLbl.tag = 0;
        
        _desLbl.textColor = [UIColor grayColor];
        
        _desLbl.userInteractionEnabled = YES;
        
        _desLbl.font = [UIFont systemFontOfSize:11.0];
        
        _desLbl.backgroundColor = [UIColor clearColor];
        
        CGSize size = [L(@"VPAlreadyReadAndAgree") sizeWithFont:[UIFont systemFontOfSize:11.0] constrainedToSize:CGSizeMake(320, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
        
        _desLbl.frame = CGRectMake(self.checkButton.right + 3, 0, size.width, 40);
        
        
    }
    
    return _desLbl;
}

-(UILabel *)linkUrlLbl{
    
    if (_linkUrlLbl == nil) {
        
        _linkUrlLbl = [[UILabel alloc]init];
        
        _linkUrlLbl.text = L(@"LONegotiate");
        
        _linkUrlLbl.tag = 1;
        
        _linkUrlLbl.userInteractionEnabled = YES;
        
        _linkUrlLbl.textColor = [UIColor darkBlueColor];
        
        _linkUrlLbl.font = [UIFont systemFontOfSize:11.0];
        
        _linkUrlLbl.backgroundColor = [UIColor clearColor];
        
        CGSize size = [L(@"LONegotiate") sizeWithFont:[UIFont systemFontOfSize:11.0] constrainedToSize:CGSizeMake(320, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
        
        _linkUrlLbl.frame = CGRectMake(self.desLbl.right, 0, size.width, 40);
    }
    
    return _linkUrlLbl;
}



#pragma mark - UIView touch
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    
    UIView *view = [touch view];
    
    if ([view isKindOfClass:[UILabel class]]) {
        
        if (view.tag == 0) {
            
            [self checkButtonAction];
            
        }else{
            
            if ([delegate conformsToProtocol:@protocol(LotteryProtocolCellDelegate)]) {
                
                [delegate respondsToSelector:@selector(presentModalProtocolView)];
                
                [delegate presentModalProtocolView];
            }
        }
    }
    
    
}

#pragma mark - action
-(void)checkButtonAction{
    
    if (self.isAgreeWithPro) {
        
        self.isAgreeWithPro = NO;
        
        UIImage *image = [UIImage imageNamed:@"singleCheck_unselect"];
        
        [self.checkButton setBackgroundImage:image forState:UIControlStateNormal];
        
    }else{
        
        self.isAgreeWithPro = YES;
        
        UIImage *image = [UIImage imageNamed:@"singleCheck_selected"];
        
        [self.checkButton setBackgroundImage:image forState:UIControlStateNormal];
        
    }
    
    if ([delegate conformsToProtocol:@protocol(LotteryProtocolCellDelegate)]) {
        
        if ([delegate respondsToSelector:@selector(returnUserCheck:)]) {
            
            [delegate returnUserCheck:self.isAgreeWithPro];
        }
    }
}
@end
