//
//  NProParamHeadCell.m
//  SuningEBuy
//
//  Created by xmy on 19/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NProParamHeadCell.h"

@implementation NProParamHeadCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.contentView.backgroundColor = [UIColor clearColor];
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UILabel *)infoLbl{
    
    if (!_infoLbl) {
        
        _infoLbl = [[UILabel alloc] init];
        
        _infoLbl.frame = CGRectMake(20, 5, 280, 5);
                
        _infoLbl.textAlignment = UITextAlignmentLeft;
                
        _infoLbl.textColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1];
        
        _infoLbl.backgroundColor = [UIColor clearColor];
        
        _infoLbl.font = [UIFont boldSystemFontOfSize:12];
        
        _infoLbl.lineBreakMode = UILineBreakModeWordWrap;
        
        _infoLbl.numberOfLines = 0;
                
    }
    
    return _infoLbl;
    
}

- (void)setImageViewsPropetry:(UIImageView*)img
{
    img.backgroundColor = [UIColor clearColor];
}

- (UIImageView*)arrowImageView
{
    if(!_arrowImageView)
    {
        _arrowImageView = [[UIImageView alloc] init];
        
        [self setImageViewsPropetry:_arrowImageView];

    }
    
    return _arrowImageView;
}

- (UIImageView*)backImageView
{
    if(!_backImageView)
    {
        _backImageView = [[UIImageView alloc] init];
        
        [self setImageViewsPropetry:_backImageView];
    
    }
    
    return _backImageView;
}

- (UIImageView*)lineImageView
{
    if(!_lineImageView)
    {
        _lineImageView = [[UIImageView alloc] init];
        
        [self setImageViewsPropetry:_lineImageView];
        
        _lineImageView.image = [UIImage streImageNamed:@"line.png"];

    }
    
    return _lineImageView;
}

- (UIImageView*)bottomLine
{
    if(!_bottomLine)
    {
        _bottomLine = [[UIImageView alloc] init];
        
        [self setImageViewsPropetry:_bottomLine];
        
        _bottomLine.image = [UIImage streImageNamed:@"N_ShiXian.png"];
        
    }
    
    return _bottomLine;
}


- (UIButton*)arrowBtn
{
    if(!_arrowBtn)
    {
        _arrowBtn = [[UIButton alloc] initWithFrame:CGRectMake(260, 15, 44, 44)];
        
        _arrowBtn.backgroundColor = [UIColor clearColor];
                
    }
    
    return _arrowBtn;
}

- (void)setNProParamHeadCellInfo:(DataProductBasic*)dto
                        WithBool:(BOOL)isFold
                    WithPosition:(NSInteger)row
{
//    if(dto == nil)
//    {
//        return;
//    }
    
    self.lineImageView.frame  = CGRectMake(0, 0.5, 320, 0.5);
    self.bottomLine.frame  = CGRectMake(0, 30.5, 300, 1);

    self.textLabel.font = [UIFont systemFontOfSize:15];
    if(row == 0)
    {
        self.lineImageView.hidden = YES;
        self.bottomLine.hidden = NO;

//        [self.backImageView setImage:[UIImage streImageNamed:@"yellow_top.png"]];
        
        self.textLabel.text = L(@"Production Para");
    }
    else if(row == 2)
    {
        self.lineImageView.hidden = NO;
        self.bottomLine.hidden = NO;

//        [self.backImageView setImage:[UIImage streImageNamed:@"yellow_mid.png"]];
        
        self.textLabel.text = L(@"Packing List");

    }
    else if(row  == 4)
    {
        self.lineImageView.hidden = NO;

        self.textLabel.text = L(@"afterBuy Service");

        if(isFold == YES)
        {
            self.bottomLine.hidden = YES;

//            self.backImageView.image = [UIImage streImageNamed:@"yellow_buttom.png"];
        }
        else
        {
            self.bottomLine.hidden = NO;

//            self.backImageView.image =  [UIImage streImageNamed:@"yellow_mid.png"];
        }
    }
    
    if(isFold == YES)
    {
        
        self.arrowImageView.image = [UIImage streImageNamed:@"arrow_top_gray.png"];
    }
    else
    {
        self.arrowImageView.image =  [UIImage streImageNamed:@"arrow_bottom_gray.png"];
    }
    
    self.arrowImageView.frame = CGRectMake(20, 20, 11, 6);
    
    [self.arrowBtn addSubview:self.arrowImageView];
    
//    self.backgroundView = self.backImageView;
    
    self.accessoryView = self.arrowBtn;
    
    [self.contentView addSubview:self.arrowBtn];
    [self.contentView addSubview:self.lineImageView];
}


@end
