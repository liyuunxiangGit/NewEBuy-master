//
//  OrderDetailNumbersView.m
//  SuningLottery
//
//  Created by yangbo on 4/12/13.
//  Copyright (c) 2013 suning. All rights reserved.
//

#import "OrderDetailNumbersView.h"
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"
#import "ComputeLotteryNumber.h"
#import "RegexKitLite.h"

#define ORDER_DETAIL_NUMBERS_VIEW_WIDTH ([[UIScreen mainScreen] bounds].size.width)     //投注内容view的宽度

#define ORDER_DETAIL_NUMBERS_VIEW_OFFSET_X 17   //投注内容view的originX

int P(int m, int n);      //排列函数
int C(int m,int n);       //组合函数

int P(int m, int n)
{
	int i;
	int t = m;
	for(i = 1; i < n; i++)
	{
		t = t * (m-i);
	}
	return t;
}


int C(int m,int n)
{
	int i;
	int a = 1;
	int b = 1;
	int c = 1;
    
	for(i = 1; i <=m; i++)
		a = a*i;
	for(i = 1; i <=n; i++)
		b = b*i;
	for(i = 1; i <(m-n); i++)
		c = c*i;
    
	return a/(b*c);
}

@implementation OrderDetailNumbersView

- (id)initWithNumbersString:(NSString *)ccodes multiple:(NSString *)multiple lotteryType:(LotteryType)type
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor clearColor];
        
        UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORDER_DETAIL_NUMBERS_VIEW_OFFSET_X, 14, ORDER_DETAIL_NUMBERS_VIEW_WIDTH - ORDER_DETAIL_NUMBERS_VIEW_OFFSET_X * 2, 17)];
        tagLabel.text = L(@"Betting content");
        tagLabel.textColor = RGBACOLOR(0xb4, 0x4e, 0x4b, 1);
        tagLabel.backgroundColor = [UIColor clearColor];
        tagLabel.font = [UIFont systemFontOfSize:17.0f];
        tagLabel.shadowColor = [UIColor whiteColor];
        tagLabel.shadowOffset = CGSizeMake(0, 1);
        [self addSubview:tagLabel];
        
        float height = 40;
        
        NSArray *array = [ccodes componentsSeparatedByString:@";"];
        
        for (NSString *str in array) {
            NSArray *strArray = [self betTypeWithNumber:str multiple:multiple lotteryType:type];
            
            NSMutableAttributedString *showString = [strArray objectAtIndex:0];
            OHAttributedLabel *label = [[OHAttributedLabel alloc] init];
            label.attributedText = showString;
            label.shadowColor = [UIColor whiteColor];
            label.shadowOffset = CGSizeMake(0, 1);
            label.backgroundColor = [UIColor clearColor];
            label.underlineLinks = NO;
            
            //设置textAlignment和lineBreakMode
            [showString setTextAlignment:kCTLeftTextAlignment lineBreakMode:kCTLineBreakByWordWrapping];
            
            CGSize size = [showString sizeConstrainedToSize:CGSizeMake((ORDER_DETAIL_NUMBERS_VIEW_WIDTH - 18*2)/2, 1000)];
            label.frame = CGRectMake(18, height, (ORDER_DETAIL_NUMBERS_VIEW_WIDTH - 18*2)/2, size.height);
            
            [self addSubview:label];
            
            height += size.height + 4;
            
            
            NSMutableAttributedString *betString = [strArray objectAtIndex:1];
            OHAttributedLabel *betLabel = [[OHAttributedLabel alloc] init];
            betLabel.attributedText = betString;
            betLabel.shadowColor = [UIColor whiteColor];
            betLabel.shadowOffset = CGSizeMake(0, 1);
            betLabel.backgroundColor = [UIColor clearColor];
            betLabel.underlineLinks = NO;
            betLabel.textAlignment = UITextAlignmentRight;
            
            size = [betString sizeConstrainedToSize:CGSizeMake((ORDER_DETAIL_NUMBERS_VIEW_WIDTH - 18*2)/2, 1000)];
            
            betLabel.frame = CGRectMake(ORDER_DETAIL_NUMBERS_VIEW_WIDTH - 18-size.width, CGRectGetMinY(label.frame), size.width, size.height);
            
            [self addSubview:betLabel];
        }
        
        //分割线
        UIImageView *separeLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"separeline.png"]];
        separeLine.image = [[UIImage imageNamed:@"orderdetail_separeline.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
        separeLine.frame = CGRectMake(0, height + 15, ORDER_DETAIL_NUMBERS_VIEW_WIDTH, 1);
        [self addSubview:separeLine];
        
        self.frame = CGRectMake(0, 0, ORDER_DETAIL_NUMBERS_VIEW_WIDTH, height + 16);
    }
    return self;
}

//判断号码格式是否正确
- (BOOL)isCcodeFontRight:(NSString *)code
{
    if([code length] == 0)
        return NO;
    return [code isMatchedByRegex:@"[\\d\\s|:,;]{1,}"];
}

//获取 投注类型 注数 倍数 字符串 如： 单式 1注 1倍
- (NSArray *)betTypeWithNumber:(NSString *)codes multiple:(NSString *)multiple lotteryType:(LotteryType)type
{
    
    NSString *ballSelectionType = @"";      //投注类型
    NSString *bets = @"";                   //注数
    
    NSString *redBallStr = @"";             //红球号码字符串
    NSString *blueBallStr = @"";            //篮球号码字符串
    
    NSArray *separateArray = [codes componentsSeparatedByString:@":"];
    NSString *ballsStr = [[separateArray objectAtIndex:0] stringByReplacingOccurrencesOfString:@"," withString:@" "];
    
    ballsStr = [ballsStr stringByReplacingOccurrencesOfString:@"|" withString:@" | "];
    
    if([ballsStr length] == 0)
        return nil;
    
    NSString *betTypeStr = nil;         //投注类型字符串
    if([codes length] > 3)
       betTypeStr = [codes stringByMatching:@"\\w*\\d*:\\d$"];
    
    switch (type) {
        case eColorBall:    //双色球
        {
            if([self isCcodeFontRight:ballsStr])
            {
                bets = [NSString stringWithFormat:@"%d",(int)[ComputeLotteryNumber computeLotterySSQNumber:ballsStr]];
            }else{
                bets = @"";
            }
            ballSelectionType = [bets integerValue] > 1 ? L(@"LOPlural") : L(@"LOSingle");
            
            redBallStr = [[ballsStr componentsSeparatedByString:@"|"] objectAtIndex:0];
            
            if([[ballsStr componentsSeparatedByString:@"|"] count] > 1)
                blueBallStr = [[ballsStr componentsSeparatedByString:@"|"] objectAtIndex:1];
            
        }
            break;
        case eBigLottery:  //大乐透
        {            
            if([self isCcodeFontRight:ballsStr])
            {
                bets = [NSString stringWithFormat:@"%d",(int)[ComputeLotteryNumber computeLotteryDLTNumber:ballsStr]];
            }else{
                bets = @"";
            }
            
            ballSelectionType = [bets integerValue] > 1 ? L(@"LOPlural") : L(@"LOSingle");
            
            redBallStr = [[ballsStr componentsSeparatedByString:@"|"] objectAtIndex:0];
            
            if([[ballsStr componentsSeparatedByString:@"|"] count] > 1)
                blueBallStr = [[ballsStr componentsSeparatedByString:@"|"] objectAtIndex:1];
        }
            break;
        case sevenLe:       //七乐彩
        {
            bets = [NSString stringWithFormat:@"%d",(int)[ComputeLotteryNumber computeLotterySevenLeNumber:[[ballsStr componentsSeparatedByString:@" "] count]]];
            
            ballSelectionType = [bets integerValue] > 1 ? L(@"LOPlural") : L(@"LOSingle");
            
            redBallStr = ballsStr;
        }
            break;
        case sevenStars:    //七星彩
        {
            NSString *bStr = [ballsStr stringByReplacingOccurrencesOfString:@" " withString:@"|"];
            
            NSString *str = @"";
            for(int i = 0; i < [bStr length]; i++)
            {
                str  = [[str stringByAppendingString:@" "] stringByAppendingString:[bStr substringWithRange:NSMakeRange(i, 1)]];
            }
            
            
            if([self isCcodeFontRight:ballsStr])
            {
                bets = [NSString stringWithFormat:@"%d",(int)[ComputeLotteryNumber computeLotterySevenStarsNumber:[str substringFromIndex:1]]];
            }else{
                bets = @"";
            }
            
            ballSelectionType = [bets integerValue] > 1 ? L(@"LOPlural") : L(@"LOSingle");
            
            redBallStr = [str substringFromIndex:1];
        }
            break;
        case ArrangeThree:  //排列三
        case welfare3D:
        {            
            if([betTypeStr isEqualToString:@"1:1"])
            {
                NSString *bStr = [ballsStr stringByReplacingOccurrencesOfString:@" " withString:@"|"];
                
                NSString *str = @"";
                for(int i = 0; i < [bStr length]; i++)
                {
                    str  = [[str stringByAppendingString:@" "] stringByAppendingString:[bStr substringWithRange:NSMakeRange(i, 1)]];
                }
                
                
                if([self isCcodeFontRight:ballsStr])
                {
                     bets = [NSString stringWithFormat:@"%d",(int)[ComputeLotteryNumber computeLotteryFC3DNumber:str ballType:zhiXuan]];
                }else{
                    bets = @"";
                }
                
                ballSelectionType = [bets integerValue] > 1 ? L(@"LOPluralDirectly") : L(@"LOSingleDirectly");
                
                redBallStr =  [str substringFromIndex:1];
            }else if([betTypeStr isEqualToString:@"1:4"])
            {
                
                if([self isCcodeFontRight:ballsStr])
                {
                    bets = [NSString stringWithFormat:@"%d",(int)[ComputeLotteryNumber computeLotteryFC3DNumber:[@" " stringByAppendingString:ballsStr] ballType:zhiXuanHeZhi]];
                }else{
                    bets = 0;
                }
                
                ballSelectionType = L(@"Direct value");
                
                redBallStr  = ballsStr;
            }else if([betTypeStr isEqualToString:@"2:3"])
            {
                
                if([self isCcodeFontRight:ballsStr])
                {
                    bets = [NSString stringWithFormat:@"%d",(int)[ComputeLotteryNumber computeLotteryFC3DNumber:[@" " stringByAppendingString:ballsStr] ballType:zuSan]];
                }else{
                    bets = @"";
                }
                
                ballSelectionType = L(@"LOThreePlural");
                
                redBallStr = ballsStr;
            }else if([betTypeStr isEqualToString:@"3:1"] || [betTypeStr isEqualToString:@"3:3"])
            {
                
                if([self isCcodeFontRight:ballsStr])
                {
                    bets = [NSString stringWithFormat:@"%d",(int)[ComputeLotteryNumber computeLotteryFC3DNumber:[@" " stringByAppendingString:ballsStr] ballType:zuLiu]];
                }else{
                    bets = @"";
                }
                
                ballSelectionType = [bets integerValue] > 1 ? L(@"LOSixPlural") : L(@"LOSixSingle");
                
                redBallStr = ballsStr;
            }else if([betTypeStr isEqualToString:@"2:4"])
            {
                 
                if([self isCcodeFontRight:ballsStr])
                {
                    bets = [NSString stringWithFormat:@"%d",(int)[ComputeLotteryNumber computeLotteryFC3DNumber:[@" " stringByAppendingString:ballsStr] ballType:zuSanHeZhi]];
                }else{
                    bets = @"";
                }
                
                ballSelectionType = L(@"Groups of three and values");
                
                redBallStr = ballsStr;
            }else if([betTypeStr isEqualToString:@"3:4"])
            {
                
                if([self isCcodeFontRight:ballsStr])
                {
                    bets = [NSString stringWithFormat:@"%d",(int)[ComputeLotteryNumber computeLotteryFC3DNumber:[@" " stringByAppendingString:ballsStr] ballType:zuLiuHeZhi]];
                }else{
                    bets = @"";
                }
                
                ballSelectionType = L(@"Group six and values");
                
                redBallStr = ballsStr;
            }
            
        }
            break;
        case ArrangeFive:   //排列五
        {
            NSString *bStr = [ballsStr stringByReplacingOccurrencesOfString:@" " withString:@"|"];
            
            NSString *str = @"";
            for(int i = 0; i < [bStr length]; i++)
            {
                str  = [[str stringByAppendingString:@" "] stringByAppendingString:[bStr substringWithRange:NSMakeRange(i, 1)]];
            }
            
            NSArray *bBallArray = [ballsStr componentsSeparatedByString:@" "];
            
            int bet = 1;
            
            for(int i = 0; i < [bBallArray count]; i++)
            {
                bet *= [[bBallArray objectAtIndex:i] length];
            }
            
            bets = [NSString stringWithFormat:@"%d",bet];
            
            ballSelectionType = [bets integerValue] > 1 ? L(@"Duplex") : L(@"Single entry");
            
            redBallStr = [str substringFromIndex:1];
        }
            break;
        default:
            break;
    }
    
    NSMutableAttributedString *ballAttributeString = [[NSMutableAttributedString alloc] initWithString:redBallStr];
    [ballAttributeString setFont:[UIFont systemFontOfSize:13]];
    [ballAttributeString setTextColor:RGBACOLOR(0x7d, 0, 0, 1)];
    
    if(blueBallStr != nil && [blueBallStr length] > 0)
    {
        NSMutableAttributedString *blueBallAttributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"|%@",blueBallStr]];
        [blueBallAttributedString setFont:[UIFont systemFontOfSize:13]];
        [blueBallAttributedString setTextColor:RGBACOLOR(0, 0x1c, 0x58, 1)];
        [ballAttributeString appendAttributedString:blueBallAttributedString];
    }
    
    NSMutableAttributedString *betTypeAttributeStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",ballSelectionType]];
    [betTypeAttributeStr setFont:[UIFont systemFontOfSize:13]];
    [betTypeAttributeStr setTextColor:RGBACOLOR(0x41, 0x1f, 0x1d, 1)];
    
    NSMutableAttributedString *descAttributeString = nil;

    if(multiple == nil)
    {
        descAttributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@%@",bets,L(@"Note")]];
    }else{
     descAttributeString  = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@%@  %@%@",bets,L(@"Note"),multiple,L(@"LOMagnify")]];

    }
        
    [descAttributeString setFont:[UIFont systemFontOfSize:13]];
    [descAttributeString setTextColor:RGBACOLOR(0x7d, 0, 0, 1) range:NSMakeRange(2, [bets length])];
    [descAttributeString setTextColor:RGBACOLOR(0x41, 0x1f, 0x1d, 1) range:NSMakeRange(2+[bets length], 1)];
    if(multiple != nil)
    {
        [descAttributeString setTextColor:RGBACOLOR(0x7d, 0, 0, 1) range:NSMakeRange(5+[bets length], [multiple length])];
        [descAttributeString setTextColor:RGBACOLOR(0x41, 0x1f, 0x1d, 1) range:NSMakeRange(5+[bets length]+[multiple length], 1)];
    }
    [betTypeAttributeStr appendAttributedString:descAttributeString];
    
    NSArray *returnArray = [NSArray arrayWithObjects:ballAttributeString,betTypeAttributeStr, nil];
    

    
    return returnArray;
    
}

//- (NSMutableAttributedString *)resuleString:(NSMutableAttributedString  *)ballAttributeString
//{
//    NSMutableAttributedString *str = [NSMutableAttributedString attributedStringWithString:@""];
//    
//    NSMutableAttributedString *string = ballAttributeString;
//    while (1) {
//        
//        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)string);
//        CFRange range = {0,0};
//        CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, string.length), NULL, CGSizeMake((ORDER_DETAIL_NUMBERS_VIEW_WIDTH - 18*2)/2, 20), &range);
//        
//        if(string.length <= range.location + range.length)
//        {
//            [str appendAttributedString:string];
//            break;
//        }
//        
//        if([[[string  attributedSubstringFromRange:NSMakeRange(range.location+range.length, 1)] string] isEqualToString:@" "])
//        {
//            [string deleteCharactersInRange:NSMakeRange(range.location+range.length, 1)];
//            
//            [str appendAttributedString:[string attributedSubstringFromRange:NSMakeRange(range.location, range.length)]];
//            
//            string = [NSMutableAttributedString attributedStringWithAttributedString:[string  attributedSubstringFromRange:NSMakeRange(range.location+range.length+1, string.length - range.location - range.length-1)]];
//        }else{
//            
//            [str appendAttributedString:[string attributedSubstringFromRange:NSMakeRange(range.location, range.length)]];
//            
//            string = [NSMutableAttributedString attributedStringWithAttributedString:[string  attributedSubstringFromRange:NSMakeRange(range.location+range.length, string.length - range.location - range.length)]];
//        }
//        
//        NSLog(@"##%@##",str.string);
//    }
//    return str;
//}

@end
