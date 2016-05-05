//
//  BoardingPersonCell.m
//  SuningEBuy
//
//  Created by lanfeng on 12-5-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BoardingPersonCell.h"





@implementation BoardingPersonCell

@synthesize btnImageView = _btnImageView;
@synthesize checkBtn = _checkBtn;
@synthesize nameLbl = _nameLbl;
@synthesize travellerTypeLbl = _travellerTypeLbl;
@synthesize boardingPersionCellDelegate;


- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier{
	self = [super initWithReuseIdentifier:reuseIdentifier];
	return self;
}

-(void)setItem:(BoardingInfoDTO *)dto andSelected:(NSString *)selected{
    if (dto == nil) {
        return;
    }
    
    if ([selected isEqualToString:@"0"]) 
    {
        isSelected = NO;
        UIImage *image = [UIImage imageNamed:@"plane_person_unselected.png"];
        self.btnImageView.image = image;
        
    }else{
        
        isSelected = YES;
        UIImage *image = [UIImage imageNamed:@"plane_person_selected.png"];
        self.btnImageView.image = image;
    }
    
   
    self.checkBtn.frame = CGRectMake(0, 0, 44, 44);


    NSString *name = dto.firstName == nil?@"":dto.firstName;
    if ([dto.travellerType isEqualToString:@"2"]) {
        self.travellerTypeLbl.text = [NSString stringWithFormat:@"(%@)",L(@"Child")];
    }else{
        self.travellerTypeLbl.text = [NSString stringWithFormat:@"(%@)",L(@"Adult")];
    }
    self.nameLbl.text = name;

}

- (void)dealloc {
    TT_RELEASE_SAFELY(_btnImageView);
    TT_RELEASE_SAFELY(_checkBtn);
    TT_RELEASE_SAFELY(_nameLbl);
    TT_RELEASE_SAFELY(_travellerTypeLbl);
}


#pragma mark - UIView 
-(UIButton *)checkBtn{
    if (_checkBtn == nil) {
        _checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _checkBtn.frame = CGRectMake(0, 0, 44, 44);
        [_checkBtn setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:_checkBtn];
        [_checkBtn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkBtn;
}

-(UIView *)btnImageView{
    if (_btnImageView == nil) {
        _btnImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 11, 20, 20)];
        UIImage *image = [UIImage imageNamed:@"plane_person_unselected.png"];
        _btnImageView.image = image;
        [self.contentView addSubview:_btnImageView];
    }
    return  _btnImageView;
}

-(UILabel *)nameLbl{

    if (_nameLbl == nil) {
        _nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 80, 44)];
        _nameLbl.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_nameLbl];
    }
    return _nameLbl;
}


-(UILabel *)travellerTypeLbl{
    if (_travellerTypeLbl == nil) {
        _travellerTypeLbl = [[UILabel alloc]initWithFrame:CGRectMake(160, 0, 80, 44)];
        _travellerTypeLbl.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_travellerTypeLbl];
    }
    return _travellerTypeLbl;
}

#pragma mark - action
-(void)choose:(id)sender{
    if (isSelected == YES) {
        isSelected = NO;
        UIImage *image = [UIImage imageNamed:@"plane_person_unselected.png"];
        self.btnImageView.image = image;
    }else{
        isSelected = YES;
        UIImage *image = [UIImage imageNamed:@"plane_person_selected.png"];
        self.btnImageView.image = image;
    }
    
    if ([boardingPersionCellDelegate conformsToProtocol:@protocol(BoardingPersionCellDelegate)]) {
        if ([boardingPersionCellDelegate respondsToSelector:@selector(isSelected:andTag:)]) {
            [boardingPersionCellDelegate isSelected:isSelected andTag:self.tag];
        }
    }
}

@end
