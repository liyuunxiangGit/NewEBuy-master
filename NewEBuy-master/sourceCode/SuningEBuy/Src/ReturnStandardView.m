//
//  ReturnStandardView.m
//  SuningEBuy
//
//  Created by 漫 王 on 12-10-8.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ReturnStandardView.h"

#define   DefaultFont            [UIFont boldSystemFontOfSize:15.0]
#define   DefaultColor           [UIColor grayColor]

@interface ReturnStandardView ()

@property (nonatomic,strong)UILabel  *appraisalLabel;

@property (nonatomic,strong)UILabel  *phoneNoLabel;

@property (nonatomic, strong)UILabel  *emailLabel;

@property (nonatomic, strong)UILabel *tipLabel;

@end

@implementation ReturnStandardView

@synthesize appraisalLabel = _appraisalLabel;

@synthesize phoneNoLabel = _phoneNoLabel;

@synthesize emailLabel = _emailLabel;

@synthesize tipLabel =_tipLabel;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_appraisalLabel);
    
    TT_RELEASE_SAFELY(_phoneNoLabel);
    
    TT_RELEASE_SAFELY(_emailLabel);
    
    TT_RELEASE_SAFELY(_tipLabel);
    
}

- (id)initWithDTO:(ReturnGoodsPrepareDTO *)dto{
    
    self =[self init];
    
    if (self) {
        
        
        NSString *string = L(@"calculate font height");
        
        CGSize size = [string sizeWithFont:DefaultFont];
        
        if ([dto.appraisal isEqualToString:@"1"]) {
            
            self.appraisalLabel.frame = CGRectMake(20, 0, 280, 30);
            
            self.appraisalLabel.text = L(@"test people of my company");
        
        }else if([dto.appraisal isEqualToString:@"2"]){
            
            self.appraisalLabel.frame = CGRectMake(20, 0, 280, size.height);
            
            self.phoneNoLabel.frame = CGRectMake(20, self.appraisalLabel.bottom, 280, size.height);
            
            self.emailLabel.frame = CGRectMake(20, self.phoneNoLabel.bottom, 280, size.height);
            
            self.tipLabel.frame = CGRectMake(20, self.emailLabel.bottom, 280, size.height);
            
            if (dto.factoryContect == nil || [dto.factoryContect isEqualToString:@""]) {
                
                dto.factoryContect = @"--";
            }
            self.appraisalLabel.text = L(@"test people of factory");
            
            self.phoneNoLabel.text =  [L(@"brand telephone") stringByAppendingFormat:@"%@",dto.factoryContect];

            self.emailLabel.text = L(@"my company enmail");
            
            self.tipLabel.text = L(@"quality tip1");
        }
        else if([dto.appraisal isEqualToString:@"3"]){
            
            self.appraisalLabel.frame = CGRectMake(20, 0, 280, size.height);
            
            self.tipLabel.frame = CGRectMake(20, self.appraisalLabel.bottom, 280, 60);
            
            if (dto.factoryContect == nil || [dto.factoryContect isEqualToString:@""]) {
                
                dto.factoryContect = @"--";
            }

            self.appraisalLabel.text = L(@"test people of my company");

            self.tipLabel.text = L(@"quality tip2");

        }
        else{
            
            self.tipLabel.frame = CGRectMake(20, 0, 280, 60);

            self.tipLabel.text = L(@"quality tip3");

        }
    
        TT_RELEASE_SAFELY(dto);
    }
    
    return self;
}

-(UILabel *)appraisalLabel{
    
    if (_appraisalLabel == nil) {
        
        _appraisalLabel = [[UILabel alloc]init];
        
        _appraisalLabel.backgroundColor = [UIColor clearColor];
        
        _appraisalLabel.font = DefaultFont;
        
        _appraisalLabel.textColor = DefaultColor;
 
        [self addSubview:_appraisalLabel];
        
    }
    
    return _appraisalLabel;
}

-(UILabel *)phoneNoLabel{
    
    if (_phoneNoLabel == nil) {
        
        _phoneNoLabel = [[UILabel alloc]init];
        
        _phoneNoLabel.backgroundColor = [UIColor clearColor];
        
        _phoneNoLabel.font = DefaultFont;
        
        _phoneNoLabel.textColor = DefaultColor;
        
        [self addSubview:_phoneNoLabel];
        
    }
    
    return _phoneNoLabel;
}

-(UILabel *)emailLabel{
    
    if (_emailLabel == nil) {
        
        _emailLabel = [[UILabel alloc]init];
        
        _emailLabel.backgroundColor = [UIColor clearColor];
        
        _emailLabel.font = DefaultFont;
        
        _emailLabel.textColor = DefaultColor;
        
        [self addSubview:_emailLabel];
        
    }
    
    return _emailLabel;
}


-(UILabel *)tipLabel{
    
    if (_tipLabel == nil) {
        
        _tipLabel = [[UILabel alloc]init];
        
        _tipLabel.backgroundColor = [UIColor clearColor];
        
        _tipLabel.font = DefaultFont;
        
        _tipLabel.textColor = DefaultColor;
        
        _tipLabel.numberOfLines = 0;
        
        [self  addSubview:_tipLabel];
        
    }
    
    return _tipLabel;
}




@end
