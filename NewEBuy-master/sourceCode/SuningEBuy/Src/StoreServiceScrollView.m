//
//  StoreServiceScrollView.m
//  SuningEBuy
//
//  Created by xingxianping on 14-2-13.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "StoreServiceScrollView.h"

@implementation StoreServiceScrollView

@synthesize buttonArr = _buttonArr;
@synthesize dataArr = _dataArr;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (NSMutableArray *)buttonArr
{
    if (!_buttonArr) {
        _buttonArr = [[NSMutableArray alloc]init];
    }
    return _buttonArr;
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}

- (void)creatServiceButtons:(int )num
{
    for (int i = [self.buttonArr count]; i<num; i++) {
        UIButton *btn = [[UIButton alloc]init];
        btn.frame =CGRectMake(15+i*75, 15, 60, 60);

        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        
        btn.titleLabel.numberOfLines =0;
        btn.titleLabel.textAlignment =UITextAlignmentCenter;
        btn.titleLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        btn.titleLabel.font =[UIFont systemFontOfSize:13];
        btn.titleLabel.contentMode = UIViewContentModeTop;

        [btn setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [btn setBackgroundImage:[UIImage streImageNamed:@"button_white_normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage streImageNamed:@"button_gray_normal"] forState:UIControlStateSelected];
        
        [self addSubview:btn];
        
        [self.buttonArr addObject:btn];
        
    }
}

- (void)updateBtnWithArr:(NSMutableArray *)arr andIndex:(int)tag
{
    for (int i = 0; i<[arr count]; i++) {
        UIButton *btn = [self.buttonArr objectAtIndex:i];
        
        StoreServiceDTO *dto = [arr objectAtIndex:i];
        [btn setTitle:dto.serviceName forState:UIControlStateNormal];
        [btn setTitle:dto.serviceName forState:UIControlStateSelected];
        
//        CGSize size = [dto.serviceName sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(100, 30)];
//        CGFloat width =size.width>60?size.width:60;
        
//        if (i ==0) {
//            btn.frame =CGRectMake(15, 15, width, 60);
//        }
//        else
//        {
//            UIButton *btn2=[self.buttonArr objectAtIndex:i-1];
//            
//            btn.frame =CGRectMake(btn2.right+15, 15, size.width+15, 60);
//            
//
//        }
//
        [UIView animateWithDuration:0.5 animations:^{
            if (tag == i) {
                btn.selected =YES;
            }
            else
            {
                btn.selected =NO;
            }
        }];
        
        
    }
}

- (void)btnClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if (btn.tag >0 && btn.tag < self.buttonArr.count-1) {
        [UIView animateWithDuration:0.3 animations:^{self.contentOffset = CGPointMake(btn.frame.origin.x -100, 0);
        }];
    }
    
    [self updateBtnWithArr:self.dataArr andIndex:btn.tag];
    
    [_buttonDelegate serviceButtonClickedDelegate:btn.tag];
}


@end
