//
//  OrderDetailView.m
//  SuningLottery
//
//  Created by yangbo on 4/12/13.
//  Copyright (c) 2013 suning. All rights reserved.
//

#import "OrderDetailView.h"
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"
#import "LotteryDataModel.h"


#define ORDER_DETAIL_VIEW_WIDTH ([[UIScreen mainScreen] bounds].size.width)

#define ORDER_DETAIL_VIEW_OFFSET_X 17

@interface OrderDetailView ()

@property (nonatomic, retain) id listDto;
@property (nonatomic, retain) TradeOrderDetailDto *tradeOrderDetailDto;
@property (nonatomic, retain) NSMutableArray *followPeroidArray;

@end

@implementation OrderDetailView

- (void)dealloc
{
    TT_RELEASE_SAFELY(_string);
    TT_RELEASE_SAFELY(_tradeOrderDetailDto);
    TT_RELEASE_SAFELY(_followPeroidArray);
    TT_RELEASE_SAFELY(_listDto);
    
    
    [super dealloc];
}

- (id)initWithOrderDetail:(TradeOrderDetailDto *)detailDto followList:(NSMutableArray *)followList withListDTO:(id)listDTO
{
    if(self = [super init])
    {
        
        _tradeOrderDetailDto = [detailDto retain];
        _followPeroidArray = [followList retain];
        _listDto = [listDTO retain];
        
        self.backgroundColor = [UIColor clearColor];

        UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORDER_DETAIL_VIEW_OFFSET_X, 14, ORDER_DETAIL_VIEW_WIDTH - ORDER_DETAIL_VIEW_OFFSET_X * 2, 17)];
        tagLabel.text = L(@"LotteryOrderListDetail");
        tagLabel.textColor =  RGBACOLOR(0xb4, 0x4e, 0x4b, 1);
        tagLabel.font = [UIFont systemFontOfSize:17.0f];
        tagLabel.backgroundColor = [UIColor clearColor];
        tagLabel.shadowColor = [UIColor whiteColor];
        tagLabel.shadowOffset = CGSizeMake(0, 1);
        [self addSubview:tagLabel];
        
        _string = [[self orderDetailString] retain];
        
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)_string);

        CGSize size = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, _string.length), NULL, CGSizeMake(ORDER_DETAIL_VIEW_WIDTH, 1000), NULL);
        CFRelease(framesetter);
        
        //分割线
        UIImageView *separeLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"separeline.png"]];
        separeLine.image = [[UIImage imageNamed:@"orderdetail_separeline.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
        separeLine.frame = CGRectMake(0, size.height + CGRectGetMaxY(tagLabel.frame) + 10 + 13, ORDER_DETAIL_VIEW_WIDTH, 1);
        [self addSubview:separeLine];
        
        self.frame = CGRectMake(0, 0, ORDER_DETAIL_VIEW_WIDTH, CGRectGetMaxY(separeLine.frame));
        
        [separeLine release];
        [tagLabel release];
        
        _cancleCoupon = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleCoupon.frame = CGRectMake(self.width-95, 108, 80, 32);
        [_cancleCoupon addTarget:self action:@selector(cancelCoupon) forControlEvents:UIControlEventTouchUpInside];
        [_cancleCoupon setTitle:L(@"LODoNotUseCertification") forState:UIControlStateNormal];
//        [_cancleCoupon setBackgroundImage:[UIImage imageNamed:@"chuan_button"] forState:UIControlStateNormal];
//        [_cancleCoupon setBackgroundImage:[UIImage imageNamed:@"chuan_button_pressed"] forState:UIControlStateHighlighted];
//        [_cancleCoupon setBackgroundImage:[UIImage imageNamed:@"chuan_button_pressed"] forState:UIControlStateSelected];
        [_cancleCoupon setTitleColor:RGBCOLOR(242, 106, 3) forState:UIControlStateNormal];
        _cancleCoupon.titleLabel.font = [UIFont boldSystemFontOfSize: 15.0];
        _cancleCoupon.hidden = YES;
        [self addSubview:_cancleCoupon];
    }
    return self;
}

-(void)cancelCoupon
{
    if ([_delegate respondsToSelector:@selector(cancelButtonClicked)]) {
        [_delegate cancelButtonClicked];
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(0, rect.size.height), 1.f, -1.f);
    CGContextConcatCTM(context, transform);
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)_string);
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddRect(path, &transform, CGRectMake(ORDER_DETAIL_VIEW_OFFSET_X, 41, ORDER_DETAIL_VIEW_WIDTH - ORDER_DETAIL_VIEW_OFFSET_X * 2, rect.size.height));
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    CFRelease(framesetter);
    
    //设置shader
    CGContextSetShadowWithColor(context, CGSizeMake(0, 1), 0, [UIColor whiteColor].CGColor);
    
    CTFrameDraw(frame, context);
    CFRelease(frame);
}

-(NSMutableAttributedString *)orderDetailString
{
    
    UIColor *tagColor = RGBACOLOR(0x41, 0x1f, 0x1d, 1);
    UIColor *stringColor = RGBACOLOR(0x33, 0x33, 0x33, 1);
    
    UIFont *tagFont = [UIFont systemFontOfSize:13];
    UIFont *stringFont = [UIFont systemFontOfSize:12];
    
    
    NSMutableAttributedString *tagItem1 = [NSMutableAttributedString attributedStringWithString:[NSString stringWithFormat:@"%@  ",L(@"Order Number")]];
    [tagItem1 setFont:tagFont];
    [tagItem1 setTextColor:tagColor];
    
    NSString *projid = @"";
    if([_listDto isKindOfClass:[LotteryDealsDto class]])
    {
        projid = [_listDto projid];
    }else{
        projid = [_listDto zhid];
    }
    
    NSMutableAttributedString *stringItem1 = [NSMutableAttributedString attributedStringWithString:[NSString stringWithFormat:@"%@\n",projid]];
    [stringItem1 setFont:stringFont];
    [stringItem1 setTextColor:stringColor];
    
    NSMutableAttributedString *tagItem2 = [NSMutableAttributedString attributedStringWithString:[NSString stringWithFormat:@"%@  ",L(@"Product Name:")]];
    [tagItem2 setFont:tagFont];
    [tagItem2 setTextColor:tagColor];
    
    //获取期号
    NSString *period = @"";
    if(_tradeOrderDetailDto != nil)
    {
        period = _tradeOrderDetailDto.periodid;
    }
    else if([_followPeroidArray count] > 0)
    {
        FollowPerodDetailDto  *dto = [_followPeroidArray objectAtIndex:0];
        period = dto.cperiodid;
    }
    
    //获取类型 ：代购 or 追号
    NSString *desc = nil;
    if(_tradeOrderDetailDto != nil)
        desc = L(@"Purchase");
    else if([_followPeroidArray count] > 0)
    {
        desc = L(@"serialpurchasing");
    }
    
    NSMutableAttributedString *stringItem2 = [NSMutableAttributedString attributedStringWithString:[NSString stringWithFormat:L(@"LOIssue"),[LotteryDataModel lotteryNameWithType:[LotteryDataModel lotterTypeWithgid:[_listDto gid]]],period,desc]];
    [stringItem2 setFont:stringFont];
    [stringItem2 setTextColor:stringColor];
    
    NSMutableAttributedString *tagItem3 = [NSMutableAttributedString attributedStringWithString:[NSString stringWithFormat:@"%@  ",L(@"Betting time")]];
    [tagItem3 setFont:tagFont];
    [tagItem3 setTextColor:tagColor];
    
    NSString *buydate = nil;
    if(_tradeOrderDetailDto != nil)
        buydate = [_tradeOrderDetailDto buydate];
    else  
    {
        buydate = [_listDto adddate];
    }
    
    NSMutableAttributedString *stringItem3 = [NSMutableAttributedString attributedStringWithString:[NSString stringWithFormat:@"%@\n",buydate]];
    [stringItem3 setFont:stringFont];
    [stringItem3 setTextColor:stringColor];
    
    NSMutableAttributedString *tagItem4 = [NSMutableAttributedString attributedStringWithString:[NSString stringWithFormat:@"%@  ",L(@"Amount of bets")]];
    [tagItem4 setFont:tagFont];
    [tagItem4 setTextColor:tagColor];
    
    double totalMoney = 0;
    if(_tradeOrderDetailDto != nil)
    {
        totalMoney = [_tradeOrderDetailDto.bmoney doubleValue];
    }
    else if([_followPeroidArray count] > 0)
    {
        totalMoney = [[_listDto tmoney] doubleValue];
    }
    
    NSMutableAttributedString *stringItem4 = [NSMutableAttributedString attributedStringWithString:[NSString stringWithFormat:@"%.0f%@\n",totalMoney,L(@"Money Unit")]];
    [stringItem4 setFont:stringFont];
    [stringItem4 setTextColor:stringColor];
    
    [tagItem1 appendAttributedString:stringItem1];
    [tagItem1 appendAttributedString:tagItem2];
    [tagItem1 appendAttributedString:stringItem2];
    [tagItem1 appendAttributedString:tagItem3];
    [tagItem1 appendAttributedString:stringItem3];
    [tagItem1 appendAttributedString:tagItem4];
    [tagItem1 appendAttributedString:stringItem4];

    
    if([_listDto isKindOfClass:[LotteryDealsSerialNumberDto class]])
    {
        
        NSMutableAttributedString *tagTtem5 = [NSMutableAttributedString attributedStringWithString:[NSString stringWithFormat:@"%@  ",L(@"Order Status")]];
        [tagTtem5 setFont:tagFont];
        [tagTtem5 setTextColor:stringColor];
        
        NSString *orderStatus = @"";
        if(_tradeOrderDetailDto)
        {
            orderStatus = [_tradeOrderDetailDto localState];
        }else{
            orderStatus = [_listDto localState];
        }
        
        NSMutableAttributedString *stringItem5 = [NSMutableAttributedString attributedStringWithString:[NSString stringWithFormat:@"%@\n",orderStatus]];
        [stringItem5 setFont:stringFont];
        [stringItem5 setTextColor:stringColor];
        [tagItem1 appendAttributedString:tagTtem5];
        [tagItem1 appendAttributedString:stringItem5];

              
    }
    else
    {
        NSMutableAttributedString *tagTtem6 = [NSMutableAttributedString attributedStringWithString:[NSString stringWithFormat:@"%@  ",L(@"Order Status")]];
        [tagTtem6 setFont:tagFont];
        [tagTtem6 setTextColor:tagColor];
        
        NSString *ticketStatus = _tradeOrderDetailDto.localState;
        
        NSMutableAttributedString *stringItem6 = [NSMutableAttributedString attributedStringWithString:[NSString stringWithFormat:@"%@\n",ticketStatus]];
        [stringItem6 setFont:stringFont];
        [stringItem6 setTextColor:stringColor];
        
        NSMutableAttributedString *tagItem7 = [NSMutableAttributedString attributedStringWithString:[NSString stringWithFormat:@"%@  ",L(@"Win Status")]];
        [tagItem7 setFont:tagFont];
        [tagItem7 setTextColor:tagColor];
        
        NSString *winStatus = _tradeOrderDetailDto.winState;
        NSMutableAttributedString *stringItem7 = [NSMutableAttributedString attributedStringWithString:[NSString stringWithFormat:@"%@\n",winStatus]];
        [stringItem7 setFont:stringFont];
        [stringItem7 setTextColor:stringColor];
        
        [tagItem1 appendAttributedString:tagTtem6];
        [tagItem1 appendAttributedString:stringItem6];
        [tagItem1 appendAttributedString:tagItem7];
        [tagItem1 appendAttributedString:stringItem7];
      }

    
    
    
    NSMutableAttributedString *tagItem8 = [NSMutableAttributedString attributedStringWithString:[NSString stringWithFormat:@"%@  ",L(@"Amount won")]];
    [tagItem8 setFont:tagFont];
    [tagItem8 setTextColor:tagColor];
    
    double winLottery = 0;
     double taxLottery = 0;
    NSMutableAttributedString *stringItem8=nil;
    if(_tradeOrderDetailDto != nil){
        if([[_tradeOrderDetailDto localState] isEqualToString:L(@"Winned the lottery prize")]){
            
            winLottery = [_tradeOrderDetailDto.bonus doubleValue];
            taxLottery = [_tradeOrderDetailDto.tax doubleValue];
        }
        else{
            winLottery = 0;
        }
        stringItem8 = [NSMutableAttributedString attributedStringWithString:[NSString stringWithFormat:L(@"LOIssue2"),winLottery,taxLottery]];
    }
    else if([_followPeroidArray count] > 0)
    {
        winLottery = [[_listDto bonus] doubleValue];
        
        //chupeng 2014.3.28 这里会引起崩溃，listDto类型不正确，而且这个taxLottery并没有用到，所以注释
        //taxLottery= [[_listDto tax] doubleValue];
        //注：追号订单详情没有返回税后金额
        stringItem8 = [NSMutableAttributedString attributedStringWithString:[NSString stringWithFormat:@"%0.2f%@\n",winLottery,L(@"Constant_RMB")]];
    }
    

    
    if (winLottery == 0)
    {
        stringItem8 = [NSMutableAttributedString attributedStringWithString:L(@"LOIssue3")];
    }
    
    if(winLottery == 0)
    {
        [stringItem8 setTextColor:stringColor];
    }else{
        [stringItem8 setTextColor:[UIColor redColor]];
    }
    
    [tagItem1 appendAttributedString:tagItem8];
    [tagItem1 appendAttributedString:stringItem8];
    
    //追号进度
    if([_listDto isKindOfClass:[LotteryDealsSerialNumberDto class]])
    {
        NSMutableAttributedString *tagItem9 = [NSMutableAttributedString attributedStringWithString:[NSString stringWithFormat:@"%@  ",L(@"LOAdditionalNumberRate")]];
        [tagItem9 setFont:tagFont];
        [tagItem9 setTextColor:tagColor];
        
        NSMutableAttributedString *stringItem9 = [NSMutableAttributedString attributedStringWithString:[NSString stringWithFormat:L(@"LOIssue4") , [[_listDto success] integerValue]+[[_listDto failure] integerValue],[_listDto pnums]]];
        [stringItem9 setFont:stringFont];
        [stringItem9 setTextColor:stringColor];
        
        [tagItem1 appendAttributedString:tagItem9];
        [tagItem1 appendAttributedString:stringItem9];
    }
    
    //段落
    //line break
    CTParagraphStyleSetting lineBreakMode;
    CTLineBreakMode lineBreak = kCTLineBreakByCharWrapping; //换行模式
    lineBreakMode.spec = kCTParagraphStyleSpecifierLineBreakMode;
    lineBreakMode.value = &lineBreak;
    lineBreakMode.valueSize = sizeof(CTLineBreakMode);
    //行间距
    CTParagraphStyleSetting LineSpacing;
    CGFloat spacing = 4.0;  //指定间距
    LineSpacing.spec = kCTParagraphStyleSpecifierLineSpacingAdjustment;
    LineSpacing.value = &spacing;
    LineSpacing.valueSize = sizeof(CGFloat);
    
    CTParagraphStyleSetting settings[] = {lineBreakMode,LineSpacing};
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, 2);   //第二个参数为settings的长度
    [tagItem1 addAttribute:(NSString *)kCTParagraphStyleAttributeName
                   value:(id)paragraphStyle
                   range:NSMakeRange(0, tagItem1.length)];
    
    return  tagItem1;
}

@end
