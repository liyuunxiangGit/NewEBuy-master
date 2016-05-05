//
//  ProductInfoCell.m
//  SuningEBuy
//
//  Created by li xiaokai on 13-7-15.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ProductInfoCell.h"


@implementation ProductInfoCell

@synthesize ruleTextView = _ruleTextView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}


-(UIButton *)markBtn{
    
    if (!_markBtn) {        
        _markBtn = [[UIButton alloc] init];
        _markBtn.selected = NO;
        _markBtn.backgroundColor = [UIColor clearColor];
        [_markBtn addTarget:self action:@selector(expandAction) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(287, 20, 10, 10)];
        // bgImageView.contentMode = UIViewContentModeCenter;
        backImageView.image = [UIImage imageNamed:@"sellpointdown@2x.png"];
        [_markBtn addSubview:backImageView];
//        [self.contentView addSubview:_markBtn];
    }
    
    return _markBtn;
}

- (RuleCopyTextView *)ruleTextView{
    
    if (!_ruleTextView) {
        _ruleTextView = [[RuleCopyTextView alloc] init];
        _ruleTextView.backgroundColor = [UIColor clearColor];
        _ruleTextView.textAlignment = UITextAlignmentLeft;
        _ruleTextView.textColor = [UIColor darkGrayColor];
        _ruleTextView.font = [UIFont systemFontOfSize:kDefaulContendFont];
        _ruleTextView.userInteractionEnabled = YES;
        _ruleTextView.editable = NO;
        _ruleTextView.scrollEnabled = NO;
        _ruleTextView.frame = CGRectMake(0, 0, 300, 5);

        [self.contentView addSubview:_ruleTextView];
    }    
    return _ruleTextView;
}

-(void)expandAction{
    
    if (!self.markBtn.selected) {
        self.markBtn.selected = !self.markBtn.selected;
        
        if ([_delegate respondsToSelector:@selector(expandChange:)]) {
            [_delegate expandChange:self.markBtn.selected];
        }
        self.markBtn.hidden = YES;
    }
}
-(void) setInfoString:(NSString *)aItem{
    
//    [super setInfoString:aItem];
    
    CGSize labelsize = [aItem sizeWithFont:[UIFont boldSystemFontOfSize:kDefaulContendFont] constrainedToSize:CGSizeMake(300, 300) lineBreakMode:UILineBreakModeWordWrap];
    
    CGRect ruleFrame = self.ruleTextView.frame;
    
    ruleFrame.size.height = labelsize.height;
    ruleFrame.size.width = 290;
    
    self.ruleTextView.frame = ruleFrame;
    
    self.ruleTextView.text = aItem;

    self.ruleTextView.textColor = [UIColor colorWithRed:222.0/255 green:174.0/255 blue:93.0/255 alpha:1];
    CGRect frame = self.ruleTextView.frame;
    
    if ([self isShowMark:aItem]) {
        
        frame.size.width = 290;
        if (self.markBtn.isSelected) {
            frame.size.height = [ProductInfoCell heightWithMark:aItem] + 10;
        }
        else{
            frame.size.height = [ProductInfoCell height:aItem] + 10;
            self.markBtn.frame = CGRectMake(frame.origin.x, frame.origin.y, 300, frame.size.height);
            [self.contentView addSubview:self.markBtn];
            [self.contentView bringSubviewToFront:self.markBtn];
        }
        //frame.size.height = [ProductInfoCell heightWithMark:aItem];
        //self.markBtn.hidden = NO;
    }
    else{
        
        frame.size.width = 300;
        frame.size.height = [ProductInfoCell height:aItem] + 10;
       // self.markBtn.hidden = YES;
    }

    self.ruleTextView.frame = frame;
}

+ (float)alineHeight{
    
    UIFont *couendFont = [UIFont systemFontOfSize:kDefaulContendFont];
    CGSize labelsize = [@"1" sizeWithFont:couendFont constrainedToSize:CGSizeMake(kDefaulContendWidth, 1000) lineBreakMode:UILineBreakModeTailTruncation];
    
    return  labelsize.height;
}


+(float)heightWithDefault:(NSString *)astring{
    
    UIFont *couendFont = [UIFont systemFontOfSize:kDefaulContendFont];
    CGSize labelsize = [astring sizeWithFont:couendFont constrainedToSize:CGSizeMake(kDefaulContendWidth, 1000) lineBreakMode:UILineBreakModeTailTruncation];
    
    return  labelsize.height;
}
+(float)heightWithMark:(NSString *)astring{
    
    UIFont *couendFont = [UIFont systemFontOfSize:kDefaulContendFont];
    CGSize labelsize = [astring sizeWithFont:couendFont constrainedToSize:CGSizeMake(kContendWidthWitnMark, 1000) lineBreakMode:UILineBreakModeTailTruncation];
    
    return  labelsize.height;
}


+ (CGFloat) height:(NSString *)astring{
    
    if (astring == nil) {
        
        return 0;
    }
    
    float defaultHeight = [ProductInfoCell heightWithDefault:astring];
    
    float alineHeight = [ProductInfoCell alineHeight];
    
    if (defaultHeight > (2*alineHeight)) {
        
        return 2*alineHeight;
    }
        
    return defaultHeight;
}

-(BOOL)isShowMark:(NSString *)astring{
    
    if (astring == nil) {
        
        return 0;
    }
    
    float defaultHeight = [ProductInfoCell heightWithDefault:astring];
    
    float alineHeight = [ProductInfoCell alineHeight];
    
    if (defaultHeight > (2*alineHeight)) {
        
        return YES;
    }
    
    return NO;
}

+(float)cellHeight:(NSString *)string{
    
    
    return [ProductInfoCell height:string] + 10;
}
+(float)cellHeight:(NSString *)string withExpand:(BOOL)expand{
    
    if (expand == NO) {
        
        return [ProductInfoCell cellHeight:string] + 10;
    }
    else{
        
        return [ProductInfoCell heightWithMark:string] + 20;
    }
}
@end
