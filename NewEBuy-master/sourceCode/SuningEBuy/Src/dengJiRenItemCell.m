//
//  dengJiRenItemCell.m
//  SuningEBuy
//
//  Created by xy ma on 12-5-11.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "dengJiRenItemCell.h"

#define  leftPadding    15
#define  topPadding     40

@implementation dengJiRenItemCell

@synthesize dengjirenLbl = _dengjirenLbl;
@synthesize whiteBackView  = _whiteBackView;
@synthesize peopleInfoView = _peopleInfoView;
@synthesize boardingInfoDto = _boardingInfoDto;
@synthesize dengJREditBtn = _dengJREditBtn;
@synthesize delegate;
@synthesize personList = _personList;
@synthesize certiList;
@synthesize tipLabel = _tipLabel;

//初始化
- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
	self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
     
        self.backgroundView = nil;
        self.backgroundColor = [UIColor clearColor];
        
        NSArray *tempArray1 = [[NSArray alloc]initWithObjects:L(@"BTIdentityCard"),L(@"005"),L(@"BTMilitaryCredentials"),L(@"BTGoBackHomeCredentials"),L(@"BTHKMacaoPass"),L(@"BTTaiwanCompatriotCredentials"),L(@"Others"),nil];
        self.certiList = tempArray1;
        TT_RELEASE_SAFELY(tempArray1);
        
        
        NSMutableArray *tempArray2 = [[NSMutableArray alloc]init];
        self.personList = tempArray2;
        TT_RELEASE_SAFELY(tempArray2);
    }
	
    return self;
}


-(void)dealloc{

    TT_RELEASE_SAFELY(_dengjirenLbl);
    TT_RELEASE_SAFELY(_whiteBackView);
    TT_RELEASE_SAFELY(_tipLabel);
    TT_RELEASE_SAFELY(_dengJREditBtn);
    TT_RELEASE_SAFELY(_peopleInfoView);
   
    TT_RELEASE_SAFELY(_boardingInfoDto);
    TT_RELEASE_SAFELY(certiList);
    TT_RELEASE_SAFELY(_personList);

}


-(void) setDengJiRenInfoByArray:(NSMutableArray *)array{
    
    if (_personList != array) 
    {
        self.personList = array;
    }
    
    [self setNeedsLayout];
}




-(void) layoutSubviews{
	
	[super layoutSubviews];
    
    self.dengjirenLbl.frame = CGRectMake(leftPadding, 15, 200, 20);
    
    NSInteger count = [self.personList count];
    
    if (count > 0) {
        
        CGFloat height = 25*count*2+20;
        
        self.whiteBackView.frame = CGRectMake(0, topPadding, 320, height);
        
        if ([self.tipLabel superview] != nil) {
            
            [self.tipLabel removeFromSuperview];
        }
        
        self.dengJREditBtn.frame = CGRectMake(230, topPadding+10, 80, 36);
        int row = [self.personList count]*2;
        
        self.peopleInfoView.frame = CGRectMake(leftPadding, topPadding+10, 215, 25*row);

    }else{
        
        self.whiteBackView.frame = CGRectMake(0, topPadding, 320, 56);
        
        if ([self.tipLabel superview] == nil) {
            
            [self.contentView  addSubview:self.tipLabel];
        }
        
        self.dengJREditBtn.frame = CGRectMake(230, topPadding+10, 80, 36);

    }
}

#pragma mark -
#pragma mark UIView
-(UILabel *)dengjirenLbl{
    if (_dengjirenLbl == nil) {
        _dengjirenLbl = [[UILabel alloc]init];
        _dengjirenLbl.backgroundColor = [UIColor clearColor];
        _dengjirenLbl.font = [UIFont systemFontOfSize:14.0];
        _dengjirenLbl.text = L(@"BTPassengerInfo");
        [self.contentView addSubview:_dengjirenLbl];
    }
    return _dengjirenLbl;
}

-(UIView *)whiteBackView{
    if (!_whiteBackView) {
        _whiteBackView  = [[UIView alloc]init];
        _whiteBackView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_whiteBackView];
    }
    return _whiteBackView;
}


- (UIButton *)dengJREditBtn
{
    
    if (!_dengJREditBtn)
    {        
        _dengJREditBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _dengJREditBtn.backgroundColor = [UIColor clearColor];
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"orange_button.png"];
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        [_dengJREditBtn setBackgroundImage:stretchableButtonImageNormal 
                                     forState:UIControlStateNormal];
        
        UIImage *buttonImagePressed = [UIImage imageNamed:@"orange_button_clicked.png"];
        UIImage *stretchableButtonImagePressed = [buttonImagePressed stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        [_dengJREditBtn setBackgroundImage:stretchableButtonImagePressed forState:UIControlStateHighlighted];

        
        [_dengJREditBtn setTitle:L(@"BTPassengerManage") forState:UIControlStateNormal];
        
        [_dengJREditBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _dengJREditBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        
        [_dengJREditBtn addTarget:self action:@selector(dengJREditAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_dengJREditBtn];
        
    }
    return _dengJREditBtn;
}


-(UILabel *)tipLabel{
    if (_tipLabel == nil) {
        _tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(leftPadding,topPadding+10, 215, 36)];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.font = [UIFont systemFontOfSize:14.0];
        _tipLabel.text = L(@"BTNoPassengerInfo");
        _tipLabel.textColor = [UIColor darkRedColor];
    }
    return _tipLabel;
}

-(UIView *)peopleInfoView{
    
    if (_peopleInfoView == nil) {
        _peopleInfoView = [[UIView alloc]init];
        _peopleInfoView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_peopleInfoView];
    }
    
    [_peopleInfoView removeAllSubviews];
    
    NSString *nameStr = @"";
    NSString *peopleIdStr = @"";
    
    for (int i = 0;i<[self.personList count]; i++) {
        
        if ([[self.personList objectAtIndex:i]isKindOfClass:[BoardingInfoDTO class]]) {
            BoardingInfoDTO *dto = [self.personList objectAtIndex:i];
            
            if ([dto.travellerType isEqualToString:@"2"]) {
                nameStr = [NSString stringWithFormat:@"%@%@(%@)",L(@"user name:"),dto.firstName,L(@"Child")];
            }else{
                nameStr = [NSString stringWithFormat:@"%@%@(%@)",L(@"user name:"),dto.firstName,L(@"Adult")];
            }
            
            int index = 0;
            if ([dto.cardType isEqualToString:@"9"]) {
                index = 6;
            }else{
                index = [dto.cardType intValue];
            }
            
            peopleIdStr = [NSString stringWithFormat:@"%@：%@",[self.certiList objectAtIndex:index],dto.idCode];
        }
        UILabel *nameLbl = [[UILabel alloc]init];
        nameLbl.backgroundColor = [UIColor clearColor];
        nameLbl.font = [UIFont systemFontOfSize:14];
        nameLbl.text = nameStr;
        nameLbl.frame = CGRectMake(0, 25*(i*2),215,25);
        [_peopleInfoView addSubview:nameLbl];
        TT_RELEASE_SAFELY(nameLbl);
        
        UILabel *peopleIdLbl = [[UILabel alloc]init];
        peopleIdLbl.backgroundColor = [UIColor clearColor];
        peopleIdLbl.font = [UIFont systemFontOfSize:14];
        peopleIdLbl.text = peopleIdStr;
        peopleIdLbl.frame = CGRectMake(0, 25*(i*2+1),215,25);
        [_peopleInfoView addSubview:peopleIdLbl];
        TT_RELEASE_SAFELY(peopleIdLbl);
    }
    
    return _peopleInfoView;
}


#pragma mark - action
-(void)dengJREditAction:(id)sender{
    
    if ([delegate conformsToProtocol:@protocol(dengJiRenItemCellDelegate)]) {
        if ([delegate respondsToSelector:@selector(dengJiRenManagement:)]) {
            [delegate dengJiRenManagement:self];
        }
    }
}

+(CGFloat)height:(NSInteger)count;
{
    CGFloat height = 0.0;
    
    if (count == 0) {
        height = 56+topPadding;
    }else
    {
        height = 25*count*2+20+topPadding;
    }
    
    return height;
}

@end
