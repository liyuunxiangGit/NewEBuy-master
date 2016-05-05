//
//  baoXianItemCell.m
//  SuningEBuy
//
//  Created by xy ma on 12-5-11.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "baoXianItemCell.h"
#import "PlanTicketSwitch.h"
#import "OrderSubmitRootViewController.h"

#define  leftPadding    15
#define  topPadding     40

@interface baoXianItemCell()

@property(nonatomic, strong) PickerButton *chooseINSButton;
@property(nonatomic, strong) UIButton *radio1;
@property(nonatomic, strong) UIButton *radio2;
@property(nonatomic, strong) UILabel *singleLabel;
@property(nonatomic, strong) UILabel *doubleLabel;
@property(nonatomic, strong) OrderSubmitRootViewController *controller;

@end

/*********************************************************************/

@implementation baoXianItemCell

@synthesize baoxianxuanzeLbl = _baoxianxuanzeLbl;
@synthesize whiteBackView = _whiteBackView;
@synthesize baoXianNameLbl = _baoXianNameLbl;
@synthesize baoXianPriceLbl = _baoXianPriceLbl;
@synthesize baoXianSuningLbl = _baoXianSuningLbl;
@synthesize controller = _controller;

@synthesize chooseINSButton = _chooseINSButton;
@synthesize radio1 = _radio1;
@synthesize radio2 = _radio2;
@synthesize singleLabel = _singleLabel;
@synthesize doubleLabel = _doubleLabel;

-(void)dealloc{
    
	TT_RELEASE_SAFELY(_baoXianNameLbl);
	TT_RELEASE_SAFELY(_baoXianPriceLbl);
    TT_RELEASE_SAFELY(_baoXianSuningLbl);
    TT_RELEASE_SAFELY(_controller);
    TT_RELEASE_SAFELY(_chooseINSButton);
    TT_RELEASE_SAFELY(_radio1);
    TT_RELEASE_SAFELY(_radio2);
    TT_RELEASE_SAFELY(_singleLabel);
    TT_RELEASE_SAFELY(_doubleLabel);
}

//初始化
- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier
                    controller:(OrderSubmitRootViewController *)controller
{
	self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView = nil;
        self.backgroundColor = [UIColor clearColor];
        self.controller = controller;
    }
	return self;
    
}

- (void)setupPickerDataSource
{
    NSArray *insuranceList = self.controller.insuranceList;
    
    NSMutableArray *pickerButtonSource = [[NSMutableArray alloc] init];
    
    for (InsuranceDTO *dto in insuranceList)
    {
        [pickerButtonSource addObject:dto.insuranceName?dto.insuranceName:@""];
    }
    
    [pickerButtonSource addObject:L(@"BTIDoNotNeedInsurance")];
    
    [self.chooseINSButton setItemList:pickerButtonSource];
    
    TT_RELEASE_SAFELY(pickerButtonSource);
}

- (void)setRadioStatus
{
    InsuranceDTO *dto = self.controller.selectedInsurance;

    
    if (dto.copyCount == CopyCountSingle) {
        
        [self.radio1 setImage:[UIImage imageNamed:@"checked_icon.png"] forState:UIControlStateNormal];
        [self.radio2 setImage:[UIImage imageNamed:@"unchecked_icon.png"] forState:UIControlStateNormal];
    }else if (dto.copyCount == CopyCountDouble){
        
        [self.radio1 setImage:[UIImage imageNamed:@"unchecked_icon.png"] forState:UIControlStateNormal];
        [self.radio2 setImage:[UIImage imageNamed:@"checked_icon.png"] forState:UIControlStateNormal];
    }else{
        dto.copyCount = CopyCountSingle;
        [self.radio1 setImage:[UIImage imageNamed:@"checked_icon.png"] forState:UIControlStateNormal];
        [self.radio2 setImage:[UIImage imageNamed:@"unchecked_icon.png"] forState:UIControlStateNormal];
    }
    
}

+ (CGFloat)height:(OrderSubmitRootViewController *)controller
{
    if ([PlanTicketSwitch canUserNewServer]) {
        
        if (controller.selectedInsurance == nil) {
            
            return 50+topPadding;
            
        }else{
            
            NSString *detailStr = [NSString stringWithFormat:@"%@%@",L(@"BTInsuranceDetails"),
                                   controller.selectedInsurance.insuranceDetailInfo];
            CGSize size = [detailStr sizeWithFont:[UIFont systemFontOfSize:14]
                                constrainedToSize:CGSizeMake(280, 300)
                                    lineBreakMode:UILineBreakModeCharacterWrap];
            return 130+size.height+topPadding;
        }
        
    }else{
        
        return 50+topPadding;
    }
}


- (void) setItem
{
    
    self.baoxianxuanzeLbl.frame = CGRectMake(leftPadding, 10, 200, 25);

    UIFont *font = [UIFont systemFontOfSize:14];
    CGSize size = [@"a" sizeWithFont:font];

    if ([PlanTicketSwitch canUserNewServer]) {
        
        if (self.chooseINSButton.itemList == nil ||
            [self.chooseINSButton.itemList count] == 0) {
            [self setupPickerDataSource];
        }
        
        self.chooseINSButton.frame = CGRectMake(leftPadding, 10+topPadding, (320-2*leftPadding), 30);

        if (self.controller.selectedInsurance) {
            
            self.baoXianPriceLbl.hidden = NO;
            self.baoXianNameLbl.hidden = NO;
            self.radio1.hidden = NO;
            self.singleLabel.hidden = NO;
            self.radio2.hidden = NO;
            self.doubleLabel.hidden = NO;
            self.baoXianSuningLbl.hidden = NO;
            
            self.whiteBackView.frame = CGRectMake(0, topPadding, 320, 120);

            InsuranceDTO *dto = self.controller.selectedInsurance;
            
            self.baoXianPriceLbl.text = [NSString stringWithFormat:@"%.1f%@", [dto.salePrice floatValue],L(@"BTYuanPerPortion")];
            self.baoXianPriceLbl.frame = CGRectMake(leftPadding,50+topPadding, 80, size.height);
            
            self.baoXianNameLbl.text = L(@"BTPortion");
            self.baoXianNameLbl.frame = CGRectMake(self.baoXianPriceLbl.right+15,
                                                   self.baoXianPriceLbl.top, 45, size.height);
            
            NSInteger ticketCount = [self.controller ticketCount];
            
            if ([dto.sellNum intValue] >= 1) {
                
                self.radio1.frame = CGRectMake(_baoXianNameLbl.right,
                                               (_baoXianNameLbl.top+(size.height-9)/2), 12, 9);

                self.singleLabel.frame = CGRectMake(self.radio1.right+10,
                                                    self.baoXianNameLbl.top, 25, size.height);
                self.singleLabel.text = [NSString stringWithFormat:@"%d", ticketCount];
            }
            
            if ([dto.sellNum intValue] >= 2) {
                
                self.radio2.frame = CGRectMake(_singleLabel.right,
                                               _radio1.top, 12, 9);

                self.doubleLabel.frame = CGRectMake(self.radio2.right+10,
                                                    self.baoXianNameLbl.top, 60, size.height);
                self.doubleLabel.text = [NSString stringWithFormat:@"%d(%@)", ticketCount*2,L(@"BTPairOfInsurance")];

            }
            
            [self setRadioStatus];
            
            self.baoXianSuningLbl.text =
            [NSString stringWithFormat:@"%@%@", L(@"BTInsuranceDetails"),dto.insuranceDetailInfo];
            CGSize size = [self.baoXianSuningLbl.text sizeWithFont:font
                                                 constrainedToSize:CGSizeMake(280, 300)
                                                     lineBreakMode:UILineBreakModeCharacterWrap];
            self.baoXianSuningLbl.frame = CGRectMake(leftPadding,
                                                     self.baoXianPriceLbl.bottom+20,
                                                     size.width, size.height);

        }else{
            
            self.whiteBackView.frame = CGRectMake(0, topPadding, 320, 50);
            
            self.baoXianPriceLbl.hidden = YES;
            self.baoXianNameLbl.hidden = YES;
            self.radio1.hidden = YES;
            self.singleLabel.hidden = YES;
            self.radio2.hidden = YES;
            self.doubleLabel.hidden = YES;
            self.baoXianSuningLbl.hidden = YES;
        }
        
        
    }else{

        self.whiteBackView.frame = CGRectMake(0, topPadding, 320, 50);
        
        self.baoXianNameLbl.hidden = NO;
        self.baoXianPriceLbl.hidden = NO;
        self.baoXianSuningLbl.hidden = NO;
        self.baoXianNameLbl.hidden = NO;

        self.baoXianNameLbl.text = L(@"BTSunnyAccidentTrafficInsurance");
        self.baoXianPriceLbl.text = [NSString stringWithFormat:@"20%@",L(@"BTYuanPerPortion")];
        self.baoXianSuningLbl.text = @"BTSuningPresent";
        
        self.baoXianNameLbl.frame = CGRectMake(leftPadding, topPadding+10, 120, 30);
        self.baoXianPriceLbl.frame = CGRectMake(135, _baoXianNameLbl.top, 90, 30);
        self.baoXianSuningLbl.frame = CGRectMake(225, _baoXianNameLbl.top, 90, 30);
    }
    
    [self.contentView sendSubviewToBack:self.whiteBackView];
    
}

#pragma mark -
#pragma mark UIView
-(UILabel *)baoxianxuanzeLbl{
    if (_baoxianxuanzeLbl == nil) {
        _baoxianxuanzeLbl = [[UILabel alloc]init];
        _baoxianxuanzeLbl.backgroundColor = [UIColor clearColor];
        _baoxianxuanzeLbl.font = [UIFont systemFontOfSize:14.0];
        _baoxianxuanzeLbl.text = L(@"BTInsuranceChoose");
        [self.contentView addSubview:_baoxianxuanzeLbl];
    }
    return _baoxianxuanzeLbl;
}

-(UIView *)whiteBackView{
    if (!_whiteBackView) {
        _whiteBackView  = [[UIView alloc]init];
        _whiteBackView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_whiteBackView];
    }
    return _whiteBackView;
}



-(UILabel *) baoXianNameLbl{
	
	if (!_baoXianNameLbl) {
		
		UIFont *font = [UIFont systemFontOfSize:14];
		CGSize size = [@"a" sizeWithFont:font];
		_baoXianNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 5, 60, size.height)];
		_baoXianNameLbl.backgroundColor = [UIColor clearColor];
		_baoXianNameLbl.font = font;
		_baoXianNameLbl.autoresizingMask = UIViewAutoresizingNone;
		[self.contentView addSubview:_baoXianNameLbl];
	}	
	return _baoXianNameLbl;
}

-(UILabel *) baoXianPriceLbl{
	
	if (!_baoXianPriceLbl) {
		UIFont *font = [UIFont systemFontOfSize:14];
		CGSize size = [@"a" sizeWithFont:font];
		_baoXianPriceLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 5, 60, size.height)];
		_baoXianPriceLbl.backgroundColor = [UIColor clearColor];
		_baoXianPriceLbl.font = font;
		_baoXianPriceLbl.autoresizingMask = UIViewAutoresizingNone;
        [self.contentView addSubview:_baoXianPriceLbl];
		
	}	
	return _baoXianPriceLbl;
}


- (UILabel *) baoXianSuningLbl{
	
	if (!_baoXianSuningLbl) {
		
		UIFont *font = [UIFont systemFontOfSize:14];
        CGSize size = [@"a" sizeWithFont:font];
		_baoXianSuningLbl = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 5, 60, size.height)];
		_baoXianSuningLbl.backgroundColor = [UIColor clearColor];
		_baoXianSuningLbl.font = font;
		_baoXianSuningLbl.autoresizingMask = UIViewAutoresizingNone;
        _baoXianSuningLbl.numberOfLines = 0;
        _baoXianSuningLbl.lineBreakMode = UILineBreakModeCharacterWrap;
        [self.contentView addSubview:_baoXianSuningLbl];
	}	
	return _baoXianSuningLbl;
}

- (PickerButton *)chooseINSButton
{
    if (!_chooseINSButton)
    {
        _chooseINSButton = [[PickerButton alloc] initWithItemList:nil];
        _chooseINSButton.delegate = self;
        _chooseINSButton.backgroundColor = [UIColor clearColor];
        UIImage *image = [UIImage newImageFromResource:@"down_icon.png"];
        [_chooseINSButton setBackgroundImage:image
                                    forState:UIControlStateNormal];
        [_chooseINSButton setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 40)];
        _chooseINSButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_chooseINSButton setTitleColor:[UIColor orange_Red_Color] forState:UIControlStateNormal];
        [_chooseINSButton setTitle:L(@"BTChooseInsuranceKind") forState:UIControlStateNormal];
        _chooseINSButton.isShowSelectItemOnButton = YES;
        [self.contentView addSubview:_chooseINSButton];
        
    }
    
    return _chooseINSButton;
}

- (UIButton *)radio1
{
    if (!_radio1) {
        _radio1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _radio1.tag = 1;
        [_radio1 addTarget:self action:@selector(tappTheRadio:)
          forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_radio1];
    }
    return _radio1;
}

- (UIButton *)radio2
{
    if (!_radio2) {
        _radio2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _radio2.tag = 2;
        [_radio2 addTarget:self action:@selector(tappTheRadio:)
          forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_radio2];
    }
    return _radio2;
}

- (UILabel *) singleLabel{
	
	if (!_singleLabel) {
		
		UIFont *font = [UIFont systemFontOfSize:14];
		CGSize size = [@"a" sizeWithFont:font];
		_singleLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 5, 60, size.height)];
		_singleLabel.backgroundColor = [UIColor clearColor];
		_singleLabel.font = font;
		_singleLabel.autoresizingMask = UIViewAutoresizingNone;
        [self.contentView addSubview:_singleLabel];
		
	}
	return _singleLabel;
}

- (UILabel *) doubleLabel{
	
	if (!_doubleLabel) {
		
		UIFont *font = [UIFont systemFontOfSize:14];
		CGSize size = [@"a" sizeWithFont:font];
		_doubleLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 5, 60, size.height)];
		_doubleLabel.backgroundColor = [UIColor clearColor];
		_doubleLabel.font = font;
		_doubleLabel.autoresizingMask = UIViewAutoresizingNone;
		[self.contentView addSubview:_doubleLabel];
	}
	return _doubleLabel;
}

#pragma mark -
#pragma mark picker button delegate

- (void)pickerButton:(PickerButton *)button
      didSelectIndex:(NSInteger)index
             andItem:(NSString *)item
{
    if (index >= 0 && index < [self.controller.insuranceList count]) {
        
        InsuranceDTO *dto = [self.controller.insuranceList objectAtIndex:index];
        
        InsuranceDTO *selectedInsurance = [dto copy];
        if (self.controller.selectedInsurance) {
            selectedInsurance.copyCount = self.controller.selectedInsurance.copyCount;
        }else{
            selectedInsurance.copyCount = CopyCountSingle;
        }
        self.controller.selectedInsurance = selectedInsurance;
        
        TT_RELEASE_SAFELY(selectedInsurance);
        
    }else if (index == [self.controller.insuranceList count]){  //不需要保险的情况
        
        self.controller.selectedInsurance = nil;
    }
    [self.controller calculateTotalAmount];
    
    [self.controller updateTable];
    
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:4];
    [self.controller.tpTableView scrollToRowAtIndexPath:indexpath
                                       atScrollPosition:UITableViewScrollPositionTop
                                               animated:NO];
}

- (void)tappTheRadio:(id)sender
{
    int tag = [sender tag];
    
    if (tag == 1) {
        
        self.controller.selectedInsurance.copyCount = CopyCountSingle;
    }else{
        self.controller.selectedInsurance.copyCount = CopyCountDouble;
    }
    
    [self.controller calculateTotalAmount];
    
    [self.controller updateTable];
    
    [self setItem];
}

@end
