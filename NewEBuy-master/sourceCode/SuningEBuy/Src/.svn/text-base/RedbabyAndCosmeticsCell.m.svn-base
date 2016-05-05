//
//  RedbabyAndCosmeticsCell.m
//  SuningEBuy
//
//  Created by li xiaokai on 13-4-12.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "RedbabyAndCosmeticsCell.h"

#define  SecondCategoryBtn_Tag_Begin  100

#define  BtnWith 70
#define  BtnHeight 35

@implementation RedbabyAndCosmeticsCell
@synthesize item = _item;
@synthesize tilleLabel = _titleLabel;
@synthesize cellImage = _cellImage;
@synthesize mydelegate = _mydelegate;
@synthesize groundView = _groundView;

-(void)dealloc{
    
    TT_RELEASE_SAFELY(_titleLabel);
    TT_RELEASE_SAFELY(_cellImage);
    TT_RELEASE_SAFELY(_item);
    TT_RELEASE_SAFELY(_groundView);
    
}
-(UILabel *)tilleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,
                                                                10,
                                                                270,
                                                                30)];
        _titleLabel.textColor = [UIColor colorWithRGBHex:0x59493F];//[UIColor darkTextColor];//[UIColor blackColor];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14];
    }
    
    return _titleLabel;
}

-(EGOImageView *)cellImage{
    
    if (!_cellImage) {
        
        _cellImage = [[EGOImageView alloc] initWithFrame:CGRectMake(11, 40, 298, 98)];
        [_cellImage setExclusiveTouch:YES];
    }
    
    return _cellImage;
}

-(UIImageView *)groundView{
    
    if (!_groundView) {
        
        _groundView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 165 -10)];
        _groundView.image = [UIImage streImageNamed:@"redbabyAndCosmeticsCellground.png"];

    }
    
    return _groundView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        

        [self.contentView addSubview:self.groundView];
        
        [self.contentView addSubview:self.tilleLabel];
        
        
        [self.contentView addSubview:self.cellImage];
        
        for (int i=0; i<SecondListNum; i++) {
            
            if (0 == i) {
                
                continue;
            }
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(28+100*(i-1), 134, BtnWith, BtnHeight)];
            btn.tag = SecondCategoryBtn_Tag_Begin+i;
            [btn setExclusiveTouch:YES];
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
            [btn setTitleColor:[UIColor colorWithRGBHex:0x7E6B5A] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:btn];
            TT_RELEASE_SAFELY(btn);
            
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                             action:@selector(touchImage:)];
		[self.cellImage addGestureRecognizer:tap];
        _cellImage.userInteractionEnabled = YES;
		TT_RELEASE_SAFELY(tap);
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) setItem:(V2FristCategoryDTO *)aItem  cellIndex:(NSInteger)index{
	
	if (aItem != _item) {
		
		
		_item = aItem;
		
        _titleLabel.text = [NSString stringWithFormat:@"%02dF   %@",index,aItem.categoryName];//aItem.categoryName;
        
        if (0 < [_item.secList count]) {
            
            V2SecCategoryDTO *dto = [_item.secList objectAtIndex:0];
            
            [self.cellImage setImageURL:[NSURL URLWithString:dto.categoryImageURL]];
        }
        
        for (int i=0; i<SecondListNum; i++) {
            
            if (0 == i) {
                
                continue;
            }
            
            UIButton *btn = (UIButton*)[self.contentView viewWithTag:SecondCategoryBtn_Tag_Begin+i];
            
            if (i < [_item.secList count]) {
                btn.hidden = NO;
                
                V2SecCategoryDTO *dto = [_item.secList objectAtIndex:i];
                [btn setTitle:dto.categoryName forState:UIControlStateNormal];
                btn.titleLabel.lineBreakMode = UILineBreakModeTailTruncation;
            }
            else{
                
                btn.hidden = YES;
            }
            
        }
	}
}

-(void)btnAction:(UIButton *)btn{
    
    int index = btn.tag - SecondCategoryBtn_Tag_Begin;
    
    if ( nil != self.mydelegate &&
        [self.mydelegate respondsToSelector:@selector(secondCategorySelect:)]
        && index < [_item.secList count])
    {
        [self.mydelegate secondCategorySelect:[_item.secList objectAtIndex:index]];
    }
}

-(void)touchImage:(UITapGestureRecognizer*)recognizer{
    
    
    
    if ( nil != self.mydelegate &&
        [self.mydelegate respondsToSelector:@selector(secondCategorySelect:)]
        && 0 < [_item.secList count])
    {
        [self.mydelegate secondCategorySelect:[_item.secList objectAtIndex:0]];
    }
}
@end
