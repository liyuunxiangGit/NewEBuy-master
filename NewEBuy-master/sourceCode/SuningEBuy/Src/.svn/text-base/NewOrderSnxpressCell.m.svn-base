//
//  NewOrderSnxpressCell.m
//  SuningEBuy
//
//  Created by xmy on 2/11/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NewOrderSnxpressCell.h"

#define KExpressLblX 50
#define KLblWidth 239.5
#define KLblHeight 20

#define KLblFont 14.0

@implementation NewOrderSnxpressCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

-(void)refreshCell:(NSDictionary *)dic celType:(CellViewType)cellType WithMorePack:(BOOL)isMorePackage
{
    
    if (IsNilOrNull(dic)) {
        return;
    }
    
    NSString *itemText = [dic objectForKey:@"itemText"];
    NSString *itemDate = [dic objectForKey:@"itemDate"];
    NSString *itemTime = [dic objectForKey:@"itemTime"];
    NSString *operator = [dic objectForKey:@"operator"];
    NSString *conLabelContent = nil;

//    NSMutableString *mutableStr = [[NSMutableString alloc] initWithString:itemText];

//    NSString *str = [mutableStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    
//    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:KLblFont] constrainedToSize:CGSizeMake(239.5, MAXFLOAT) lineBreakMode:UILineBreakModeCharacterWrap];
//    
//    height = size.height+60;
    
    CGFloat cellHeight = [NewOrderSnxpressCell expressHeight:dic];

//    self.upLineImg.hidden = YES;
    conLabelContent = [self setWebViewFontAndColor:itemText font:14.0f color:@"#707070"];
//    conLabelContent = [self setWebViewFontAndColor:_listDto.itemText font:14.0f color:@"#FF7700"];
//    self.contentLbl.textColor = [UIColor dark_Gray_Color];
    self.operatorLbl.textColor = [UIColor dark_Gray_Color];
    self.timeLbl.textColor = [UIColor dark_Gray_Color];
    
    if(cellType == TopCell)
    {
        conLabelContent = [self setWebViewFontAndColor:itemText font:14.0f color:@"#FF7700"];
//        self.contentLbl.textColor = [UIColor colorWithRGBHex:0xff7700];
        self.operatorLbl.textColor = [UIColor colorWithRGBHex:0xff7700];
        self.timeLbl.textColor = [UIColor colorWithRGBHex:0xff7700];
        
        if(isMorePackage == NO)
        {
            self.iconImg.image = [UIImage imageNamed:@"Service_Detail_List_Cell_Arrow.png"];
            
            self.downLineImg.hidden = YES;
            self.upLineImg.hidden = YES;
            self.iconImg.frame = CGRectMake(20, 10, 16, 10);
            
        }
        else
        {
            self.iconImg.image = [UIImage imageNamed:@"Service_Detail_List_Cell_Arrow.png"];
            
            self.downLineImg.hidden = NO;
            self.upLineImg.hidden = YES;
            self.iconImg.frame = CGRectMake(20, 10, 16, 10);
            self.downLineImg.frame = CGRectMake(23.5, _iconImg.bottom-1, 1, cellHeight - 9);
            
        }
    }
    else if(cellType == BottomCell)
    {
        [_iconImg setImage:[UIImage imageNamed:@"Service_Detail_List_Cell_Point_Gray.png"]];
        
        self.iconImg.frame = CGRectMake(20, 10, 8, 8);
//        self.downLineImg.frame = CGRectMake(23.5, 0, 2, 10);
        self.downLineImg.hidden = YES;
        self.upLineImg.hidden = NO;
        self.upLineImg.frame = CGRectMake(23.5, 0, 1, 10);

    }
    else
    {
        [_iconImg setImage:[UIImage imageNamed:@"Service_Detail_List_Cell_Point_Gray.png"]];

        self.iconImg.frame = CGRectMake(20, 10, 8, 8);
//        self.downLineImg.frame = CGRectMake(23.5, _iconImg.bottom-1, 2, cellHeight - 6);
        self.downLineImg.hidden = YES;
        self.upLineImg.hidden = NO;
        self.upLineImg.frame = CGRectMake(23.5, _iconImg.bottom-1, 1, cellHeight - 6);

    }
    
    
    NSString *operStr = [NSString stringWithFormat:@"%@：%@",L(@"MyEBuy_Operator"),operator];
    
    NSString *strTime = [NSString stringWithFormat:@"%@ %@",itemDate,itemTime];
    
    
    CGSize infoSize = [itemText sizeWithFont:[UIFont systemFontOfSize:KLblFont] constrainedToSize:CGSizeMake(239.5, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    
    CGSize infoSize1 = [operStr sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(239.5, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    
    CGSize infoSize2 = [strTime sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(239.5, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];

    self.contentLbl.frame = CGRectMake(KExpressLblX - 8, 0, 239.5, infoSize.height + 15);
//    self.contentLbl.text = itemText?itemText:@"";
    [self.contentLbl loadHTMLString:conLabelContent baseURL:nil];
    if(IsStrEmpty(operator))
    {
        self.operatorLbl.frame = CGRectMake(KExpressLblX, self.contentLbl.bottom, KLblWidth, 0);
        
        self.operatorLbl.text = @"";
        self.timeLbl.frame = CGRectMake(KExpressLblX, self.operatorLbl.bottom, KLblWidth, infoSize2.height);
        
    }
    else
    {
        self.operatorLbl.frame = CGRectMake(KExpressLblX, self.contentLbl.bottom, KLblWidth, infoSize1.height);
        
        self.operatorLbl.text = [NSString stringWithFormat:@"%@：%@",L(@"MyEBuy_Operator"),operator];
        self.timeLbl.frame = CGRectMake(KExpressLblX, self.operatorLbl.bottom, KLblWidth, infoSize2.height);
        
    }
    
    
    self.timeLbl.text = strTime?strTime:@"";
        
/*    switch (cellType) {
 
        case TopCell:
        {
 
            UIImageView *back = [[UIImageView alloc] initWithImage:[UIImage streImageNamed:@"yellow_mid@2x.png"]];
            
//            back.frame = self.backgroundView.frame;
            
            self.backgroundView = back;
            
            self.backImg.frame = CGRectMake(50, 10, 240, size.height+70);
            
            UIImage *image = [UIImage newImageFromResource:@"New_Orange.png"];
            UIImage *strImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(100, 0, 177, 486)];
            self.backImg.image = strImage;
            
            self.contentLbl.frame = CGRectMake(70, 20, 220, size.height);
            self.contentLbl.text = itemText;
            self.contentLbl.textColor = [UIColor whiteColor];
            
            if(IsStrEmpty(operator))
            {
                self.operatorLbl.frame = CGRectMake(70, size.height+20, 200, 0);

                self.operatorLbl.text = @"";
                self.timeLbl.frame = CGRectMake(70, size.height+20, 200, 30);

            }
            else
            {
                self.operatorLbl.frame = CGRectMake(70, size.height+20, 200, 30);

                self.operatorLbl.text = [NSString stringWithFormat:@"操作人：%@",operator];
                self.timeLbl.frame = CGRectMake(70, size.height+50, 200, 30);

            }
            
            self.operatorLbl.textColor = [UIColor whiteColor];
            
            self.timeLbl.text = [NSString stringWithFormat:@"%@ %@",itemDate,itemTime];
            self.timeLbl.textColor = [UIColor whiteColor];

            self.upLineImg.frame = CGRectMake(35, 0, 2, 30);
            self.iconImg.frame = CGRectMake(31, _upLineImg.bottom+2, 10, 10);
            self.downLineImg.frame = CGRectMake(35, _iconImg.bottom+2, 2, height-35);
            
            self.iconImg.image = [UIImage newImageFromResource:@"New_icon_active.png"];

            break;
        }
        case MiddleCell:{
            
//            [self setCoolBgViewWithCellPosition:CellPositionCenter hasLine:NO];

            UIImageView *back = [[UIImageView alloc] initWithImage:[UIImage streImageNamed:@"yellow_mid@2x.png"]];
            
//            back.frame = self.backgroundView.frame;
            
            self.backgroundView = back;
            self.backImg.frame = CGRectMake(50, 10, 240, size.height+70);
            UIImage *image = [UIImage newImageFromResource:@"New_gray.png"];
            UIImage *strImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(90, 20, 40, 186)];
            self.backImg.image = strImage;
            
            self.contentLbl.frame = CGRectMake(70, 20, 220, size.height);
            self.contentLbl.text = itemText;
            self.contentLbl.textColor = [UIColor colorWithRGBHex:0x999081];
            
            if(IsStrEmpty(operator))
            {
                self.operatorLbl.frame = CGRectMake(70, size.height+20, 200, 0);

                self.operatorLbl.text = @"";
                self.timeLbl.frame = CGRectMake(70, size.height+20, 200, 30);
                
            }
            else
            {
                self.operatorLbl.frame = CGRectMake(70, size.height+20, 200, 30);
                self.timeLbl.frame = CGRectMake(70, size.height+50, 200, 30);

                self.operatorLbl.text = [NSString stringWithFormat:@"操作人：%@",operator];
            }
            

           
            self.operatorLbl.textColor = [UIColor colorWithRGBHex:0x999081];
            
            self.timeLbl.text = [NSString stringWithFormat:@"%@ %@",itemDate,itemTime];
            self.timeLbl.textColor = [UIColor colorWithRGBHex:0x999081];

            self.upLineImg.frame = CGRectMake(35, 0, 2, self.backImg.frame.size.height/2-3);
            self.iconImg.frame = CGRectMake(31,self.backImg.frame.size.height/2, 10, 10);
            self.downLineImg.frame = CGRectMake(35, _iconImg.bottom+2, 2, height-35);
            
            self.iconImg.image = [UIImage newImageFromResource:@"New_icon.png"];
            
            break;
        }
        case BottomCell:{
            
//            [self setCoolBgViewWithCellPosition:CellPositionBottom hasLine:NO];
            UIImageView *back = [[UIImageView alloc] initWithImage:[UIImage streImageNamed:@"yellow_buttom@2x.png"]];
            
//            back.frame = self.backgroundView.frame;
            
            self.backgroundView = back;
            
            self.backImg.frame = CGRectMake(50, 10, 240, size.height+70);
            UIImage *image = [UIImage newImageFromResource:@"New_gray.png"];
            UIImage *strImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(90, 20, 40, 186)];
            self.backImg.image = strImage;
            
            self.contentLbl.frame = CGRectMake(70, 20, 220, size.height);
            self.contentLbl.text = itemText;
            self.contentLbl.textColor = [UIColor colorWithRGBHex:0x999081];
            
            if(IsStrEmpty(operator))
            {
                self.operatorLbl.frame = CGRectMake(70, size.height+20, 200, 0);
                
                self.operatorLbl.text = @"";
                self.timeLbl.frame = CGRectMake(70, size.height+20, 200, 30);
                
            }
            else
            {
                self.operatorLbl.frame = CGRectMake(70, size.height+20, 200, 30);
                self.operatorLbl.text = [NSString stringWithFormat:@"操作人：%@",operator];
                self.timeLbl.frame = CGRectMake(70, size.height+50, 200, 30);

                
            }
            
            self.operatorLbl.textColor = [UIColor colorWithRGBHex:0x999081];
            
            self.timeLbl.text = [NSString stringWithFormat:@"%@ %@",itemDate,itemTime];
            self.timeLbl.textColor = [UIColor colorWithRGBHex:0x999081];
            
            self.upLineImg.frame = CGRectMake(35, 0, 2, (height-20)/2.0-2);
            self.iconImg.frame = CGRectMake(31, self.backImg.frame.size.height/2, 10, 10);
            self.downLineImg.frame = CGRectMake(35, _iconImg.bottom+2, 2, (height-20)/2.0);
            
            self.iconImg.image = [UIImage newImageFromResource:@"New_icon.png"];
            
            break;
        }
            
            
        default:
            break;
    }
    */

    
}

+ (CGFloat)expressHeight:(NSDictionary *)dic
{
    
    if (IsNilOrNull(dic)) {
        return 0;
    }
    
    NSString *itemText = [dic objectForKey:@"itemText"];
    NSString *itemDate = [dic objectForKey:@"itemDate"];
    NSString *itemTime = [dic objectForKey:@"itemTime"];
    NSString *operator = [dic objectForKey:@"operator"];

    NSString *operStr = [NSString stringWithFormat:@"%@：%@",L(@"MyEBuy_Operator"),operator];

    NSString *strTime = [NSString stringWithFormat:@"%@ %@",itemDate,itemTime];

    
    CGSize infoSize = [itemText sizeWithFont:[UIFont systemFontOfSize:KLblFont] constrainedToSize:CGSizeMake(239.5, MAXFLOAT) lineBreakMode:UILineBreakModeCharacterWrap];
    
    CGSize infoSize1 = [operStr sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(239.5, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    
    CGSize infoSize2 = [strTime sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(239.5, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];

    return   infoSize.height+infoSize1.height+infoSize2.height+20;
}


#pragma mark -
#pragma mark UIView
-(UIImageView *)iconImg{
    
    if (!_iconImg) {
        
        _iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 16, 16)];
        
        _iconImg.backgroundColor = [UIColor clearColor];
        
        [_iconImg setImage:[UIImage imageNamed:@"Service_Detail_List_Cell_Point_Gray.png"]];
        
        [self.contentView addSubview:_iconImg];
    }
    
    return _iconImg;
}

-(UIImageView *)upLineImg{
    
    if (!_upLineImg) {
        
        _upLineImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 18, 2)];
        [_upLineImg setImage:[UIImage streImageNamed:@"Service_Detail_List_Cell__Gray_Line.png"]];
        
        _upLineImg.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_upLineImg];
    }
    
    return _upLineImg;
}

-(UIImageView *)downLineImg{
    
    if (!_downLineImg) {
        
        _downLineImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 18, 2)];
        [_downLineImg setImage:[UIImage streImageNamed:@"Service_Detail_List_Cell_Line.png"]];
        
        _downLineImg.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_downLineImg];
    }
    
    return _downLineImg;
}

-(UIImageView *)backImg{
    
    if (!_backImg) {
        
        _backImg = [[UIImageView alloc] init];
        
        _backImg.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_backImg];
    }
    
    return _backImg;
}

-(UILabel *)operatorLbl{
    
    if (!_operatorLbl) {
        _operatorLbl = [[UILabel alloc]init];
        _operatorLbl.textColor = [UIColor colorWithRGBHex:0x999081];
        _operatorLbl.font = [UIFont systemFontOfSize:14];
        _operatorLbl.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_operatorLbl];
    }
    return _operatorLbl;
}

-(UIWebView *)contentLbl{
    
    if (!_contentLbl) {
        CGRect labelRect ;
        labelRect = CGRectMake(48,0,240,42);
        //        _conLabel = [[UILabel alloc] initWithFrame:labelRect];
        //        _conLabel.textAlignment = UITextAlignmentLeft;
        //        _conLabel.font = [UIFont systemFontOfSize:14];
        //        _conLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        //        _conLabel.backgroundColor = [UIColor clearColor];
        //        _conLabel.tag = 11;
        //        [_conLabel setNumberOfLines:0];
        //        [_conLabel setAdjustsFontSizeToFitWidth:NO];
        //        [self.contentView addSubview:_conLabel];
        _contentLbl = [[UIWebView alloc] initWithFrame:labelRect];
        _contentLbl.dataDetectorTypes = UIDataDetectorTypePhoneNumber;
        [_contentLbl setBackgroundColor:[UIColor clearColor]];
        [_contentLbl setOpaque:NO];
        //        _conLabel.font = [UIFont systemFontOfSize:14.0f];
        //        _conLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        //        _conLabel.text = @"我的电话号码是：15651698091有事请打我电话！";
        //        _conLabel.scrollEnabled = NO;
        //        _conLabel.editable = NO;
        //        _conLabel.selectable = YES;
        _contentLbl.delegate = self;
        _contentLbl.scrollView.scrollEnabled = NO;
        //在viewdidload或适当的地方创建一个自定义的长按手势
        //        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:nil];
        //        longPress.delegate = self;   //记得在.h文件里加上<UIGestureRecognizerDelegate>委托
        //        longPress.minimumPressDuration = 0.4;  //这里为什么要设置0.4，因为只要大于0.5就无效，我像大概是因为默认的跳出放大镜的手势的长按时间是0.5秒，
        //        //如果我们自定义的手势大于或小于0.5秒的话就来不及替换他的默认手势了，这是只是我的猜测。但是最好大于0.2
        //        //秒，因为有的pdf有一些书签跳转功能，这个值太小的话可能会使这些功能失效。
        //        [self.contentView addGestureRecognizer:longPress];
        [self.contentView addSubview:_contentLbl];

    }
    return _contentLbl;
}

-(UILabel *)timeLbl{
    
    if (!_timeLbl) {
        _timeLbl = [[UILabel alloc]init];
        _timeLbl.font = [UIFont systemFontOfSize:12];
        _timeLbl.backgroundColor = [UIColor clearColor];
        _timeLbl.textAlignment = UITextAlignmentLeft;
        [self.contentView addSubview:_timeLbl];
    }
    return _timeLbl;
}

//- (CGFloat)cellTextHeight:(NSString*)str
//{
//    float nameH = [self lblNumberOfLines:[UIFont systemFontOfSize:KLblFont] WithLbl:str WithLblWidth:239.5]+5;
//    return nameH;
//}
//
//- (CGFloat)timeOrOperaTextHeight:(NSString*)str
//{
//    float nameH;
//    
//    if(IsStrEmpty(str))
//    {
//        nameH = 0;
//    }
//    else
//    {
//        nameH = [self lblNumberOfLines:[UIFont systemFontOfSize:KLblFont] WithLbl:str WithLblWidth:239.5]+5;
//
//    }
//    
//    return nameH;
//}
//
#pragma mark - Delegate Methods
#pragma mark   代理对应的方法

//UIActionSheet代理
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (actionSheet.tag) {
        case 100:{
            switch (buttonIndex) {
                case 0:
                    [self callTelephone];
                    break;
                case 1:
                    [self copyTelephone];
                    break;
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
}

- (void)callTelephone
{
    if (self.telephoneNmber != nil) {
        
        
        
        //        NSString *telUrl = [NSString stringWithFormat:@"telprompt:%@",phone];
        
        
        
        NSURL *url = [[NSURL alloc] initWithString:self.telephoneNmber];
        
        
        
        [[UIApplication sharedApplication] openURL:url];
        
    }
}

- (void)copyTelephone
{
    UIPasteboard *telephone = [UIPasteboard generalPasteboard];
    telephone.string = [self.telephoneNmber substringFromIndex:4];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:[[[request URL] absoluteString] substringFromIndex:4] delegate:self cancelButtonTitle:L(@"Cancel") destructiveButtonTitle:L(@"MyEBuy_DialTheNumber") otherButtonTitles:L(@"MyEBuy_CopyTheText"), nil];
        actionSheet.tag = 100;
        self.telephoneNmber = [[request URL] absoluteString];
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
        return NO;
        
    }
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString:@"document.body.style.webkitTouchCallout='none'; document.body.style.KhtmlUserSelect='none'"];
    CGRect frame = webView.frame;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    //    if (frame.size.height > 37) {
    //        frame.size.height = 37;
    //    }
    webView.frame = frame;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    return NO;  //这里一定要return NO,至于为什么大家去看看这个方法的文档吧。
//    //还有就是这个委托在你长按的时候会被多次调用，大家可以用nslog输出gestureRecognizer和otherGestureRecognizer
//    //看看都是些什么东西。
//}
//
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]])
//    {
//        return NO;
//    }
//    return YES;
//}

- (NSString *)setWebViewFontAndColor:(NSString *)str font:(float)size color:(NSString *)colorStr
{
    //    NSString *conContent = [NSString stringWithFormat:@"<html> \n"
    //                            "<head> \n"
    //                            "<style type=\"text/css\"> \n"
    //                            "body {font-family: \"%@\"; font-size: %f; color: %@;}\n"
    //                            "</style> \n"
    //                            "</head> \n"
    //                            "<body>%@</body> \n"
    //                            "</html>", @"宋体", size ,colorStr,str] ;
    NSString *conContent = [NSString stringWithFormat:@"<div style=\"word-break:break-all; float:left;width:240px; font-size:14px;font-family:helvetica;background-color:transparent; color:%@;\">%@</div>",colorStr,str];
    //    NSString *conContent1 = [NSString stringWithFormat:@"<div id ='foo' align='left' style='line-height:18px; float:left;width:300px; font-size:28px;font-family:helvetica;background-color:transparent; color:#ff7070;>%@<div>",str] ;
    return conContent;
}


@end
