//
//  ServiceDetailListInforCell.m
//  SuningEBuy
//
//  Created by wei xie on 12-9-6.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ServiceDetailListInforCell.h"

#define LABEL_WIDTH  240
#define TIMELABEL_HEIGHT 21

@implementation ServiceDetailListInforCell

@synthesize conLabel = _conLabel;

@synthesize saleLabel = _saleLabel;

@synthesize timeLabel = _timeLabel;

@synthesize timeLine = _timeLine;

@synthesize timePoint = _timePoint;

@synthesize telephoneNmber = _telephoneNmber;
- (void)dealloc{
    
    TT_RELEASE_SAFELY(_listDto);
    TT_RELEASE_SAFELY(_conLabel);
    TT_RELEASE_SAFELY(_saleLabel);
    TT_RELEASE_SAFELY(_timeLabel);
    
    TT_RELEASE_SAFELY(_iconImg);
    
    TT_RELEASE_SAFELY(_timeLine);
    TT_RELEASE_SAFELY(_timePoint);
    TT_RELEASE_SAFELY(_telephoneNmber);
//    TT_RELEASE_SAFELY(_backView);
}

- (id)initWithReuseIndetifier:(NSString *)reuseIndetifier{
    
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIndetifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor clearColor];
        
        self.autoresizesSubviews = YES;
    }
    
    return self;
}

- (UIWebView *)conLabel{
    
    if (!_conLabel) {
        
        CGRect labelRect ;
        labelRect = CGRectMake(48,0,LABEL_WIDTH,42);
//        _conLabel = [[UILabel alloc] initWithFrame:labelRect];
//        _conLabel.textAlignment = UITextAlignmentLeft;
//        _conLabel.font = [UIFont systemFontOfSize:14];
//        _conLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
//        _conLabel.backgroundColor = [UIColor clearColor];
//        _conLabel.tag = 11;
//        [_conLabel setNumberOfLines:0];
//        [_conLabel setAdjustsFontSizeToFitWidth:NO];
//        [self.contentView addSubview:_conLabel];
        _conLabel = [[UIWebView alloc] initWithFrame:labelRect];
        _conLabel.dataDetectorTypes = UIDataDetectorTypeAll;
        [_conLabel setBackgroundColor:[UIColor clearColor]];
        [_conLabel setOpaque:NO];
//        _conLabel.font = [UIFont systemFontOfSize:14.0f];
//        _conLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
//        _conLabel.text = @"我的电话号码是：15651698091有事请打我电话！";
//        _conLabel.scrollEnabled = NO;
//        _conLabel.editable = NO;
//        _conLabel.selectable = YES;
        _conLabel.delegate = self;
        _conLabel.scrollView.scrollEnabled = NO;
        //在viewdidload或适当的地方创建一个自定义的长按手势
//        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:nil];
//        longPress.delegate = self;   //记得在.h文件里加上<UIGestureRecognizerDelegate>委托
//        longPress.minimumPressDuration = 0.4;  //这里为什么要设置0.4，因为只要大于0.5就无效，我像大概是因为默认的跳出放大镜的手势的长按时间是0.5秒，
//        //如果我们自定义的手势大于或小于0.5秒的话就来不及替换他的默认手势了，这是只是我的猜测。但是最好大于0.2
//        //秒，因为有的pdf有一些书签跳转功能，这个值太小的话可能会使这些功能失效。
//        [self.contentView addGestureRecognizer:longPress];
        [self.contentView addSubview:_conLabel];

    }
    
    return _conLabel;
}


- (UILabel *)saleLabel{
    
    if (!_saleLabel) {
        
        CGRect saleRect ;
        saleRect = CGRectMake(150,50,80,TIMELABEL_HEIGHT);		
        _saleLabel = [[UILabel alloc] initWithFrame:saleRect];
        _saleLabel.textAlignment = UITextAlignmentLeft;
        _saleLabel.font = [UIFont systemFontOfSize:12];
        _saleLabel.textColor = [UIColor colorWithRed:0/255.0 green:51/255.0 blue:153/255.0 alpha:1];
        _saleLabel.backgroundColor = [UIColor clearColor];
        _saleLabel.tag = 12;
        [_saleLabel setAdjustsFontSizeToFitWidth:NO];
        [self.contentView addSubview:_saleLabel];
    }
    
    return _saleLabel;
}

- (UILabel *)timeLabel{
    
    if (!_timeLabel) {
        
        CGRect timeRect ;
        timeRect = CGRectMake(230,50,60,TIMELABEL_HEIGHT);		
        _timeLabel = [[UILabel alloc] initWithFrame:timeRect];
        _timeLabel.textAlignment = UITextAlignmentLeft;
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.tag = 13;
        [_timeLabel setAdjustsFontSizeToFitWidth:NO];
        [self.contentView addSubview:_timeLabel];
    }
    
    return _timeLabel;
}

- (void)setDetailListCellContent:(ServiceDetailInfoDTO *)detailListDto{
    
    if (IsNilOrNull(detailListDto)) {
        
        return; 
    }
    
    if (_listDto != detailListDto) {
        
        
        self.listDto = detailListDto;
    }
    NSString *conLabelContent = nil;
    UIImage *img = nil;
    if (1 == _listDto.cell || 4 == _listDto.cell) {
        conLabelContent = [self setWebViewFontAndColor:_listDto.itemText font:14.0f color:@"#FF7700"];
//        conLabelContent = [self setWebViewFontAndColor:@"阿什顿卷卡式带看见俺很少的看见俺很少的看见俺说的空间按时到卡上15651698091" font:14.0f color:@"#FF7700"];

//        self.conLabel.textColor = [UIColor colorWithHexString:@"#FF7700"];
        self.saleLabel.textColor = [UIColor colorWithHexString:@"#FF7700"];
        self.timeLabel.textColor = [UIColor colorWithHexString:@"#FF7700"];
        
        if (1 == _listDto.cell) {
            
            img = [UIImage imageNamed:@"Service_Detail_List_Cell_Hollow_Point.png"];
        }
        else if(4 == _listDto.cell){

            img = [UIImage imageNamed:@"Service_Detail_List_Cell_Hollow_Point.png"];
        }
        
    }
    else{
        
        if (2 == _listDto.cell) {
            
            img = [UIImage imageNamed:@"Service_Detail_List_Cell_Point.png"];
        }
        else if(3 == _listDto.cell){
         
            img = [UIImage imageNamed:@"cellmid.png"];

        }
        conLabelContent = [self setWebViewFontAndColor:_listDto.itemText font:14.0f color:@"#707070"];
//        conLabelContent = [self setWebViewFontAndColor:@"阿什顿卷卡式带看见俺很少的看见俺很少的看见俺说的空间按时到卡上15651698091" font:14.0f color:@"#FF7700"];

//        self.conLabel.textColor = [UIColor dark_Gray_Color];
        self.saleLabel.textColor = [UIColor dark_Gray_Color];
        self.timeLabel.textColor = [UIColor dark_Gray_Color];
    }
    self.iconImg.image = [img resizableImageWithCapInsets:UIEdgeInsetsMake(30, 0, 5, 0)];

    
//    NSString *conContent = [NSString stringWithFormat:@"<html> \n"
//                            "<head> \n"
//                            "<style type=\"text/css\"> \n"
//                            "body {font-family: \"%@\"; font-size: %f; color: %@;}\n"
//                            "</style> \n"
//                            "</head> \n"
//                            "<body>%@</body> \n"
//                            "</html>", @"宋体", 14.0 ,@"#707070",@"我的电话号码是15651698091"] ;
    //改变字体大小颜色就:
    //    NSString *jsString = [[NSString alloc] initWithFormat:@"document.body.style.fontSize=%f;document.body.style.color=%@",14.0f,@"#0x707070"];
    //    [self.conLabel stringByEvaluatingJavaScriptFromString:jsString];
    [self.conLabel loadHTMLString:conLabelContent baseURL:nil];

    self.saleLabel.text = _listDto.itemDate;
    self.timeLabel.text = _listDto.itemTime;

    CGSize maximumSize = CGSizeMake(240, MAXFLOAT);
    
    CGSize stringSize = [_listDto.itemText sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:maximumSize lineBreakMode:UILineBreakModeWordWrap];

    if (stringSize.height > 37)
    {
        stringSize.height = 37;
    }
//    float height = [ServiceDetailListInforCell trackHeight:_listDto.itemText];
    self.conLabel.frame = CGRectMake(42,0,LABEL_WIDTH,stringSize.height + 10);
    self.saleLabel.frame = CGRectMake(50, self.conLabel.bottom + 0, 80, [ServiceDetailListInforCell timeLabelHight]);
    self.timeLabel.frame = CGRectMake(130, self.conLabel.bottom + 0, 60, [ServiceDetailListInforCell timeLabelHight]);
    self.iconImg.frame = CGRectMake(5, 0, 18, [ServiceDetailListInforCell cellHeight:_listDto.itemText]);

}

- (void)setDetailListCellContentForIos7:(ServiceDetailInfoDTO *)detailListDto{
    
    if (IsNilOrNull(detailListDto)) {
        
        return;
    }
    
    if (_listDto != detailListDto) {
        
        
        self.listDto = detailListDto;
    }
    NSString *conLabelContent = nil;
    UIImage *imgLine = nil;
    UIImage *imgPoint = nil;
    if (1 == _listDto.cell || 4 == _listDto.cell) {
        conLabelContent = [self setWebViewFontAndColor:_listDto.itemText font:14.0f color:@"#FF7700"];
//        conLabelContent = [self setWebViewFontAndColor:@"阿什顿卷卡式带看见俺很少的看见俺很少的看见俺说的空间按时到卡上15651698091" font:14.0f color:@"#FF7700"];

//        self.conLabel.textColor = [UIColor  colorWithRGBHex:0xff7700];
        self.saleLabel.textColor = [UIColor colorWithRGBHex:0xff7700];
        self.timeLabel.textColor = [UIColor colorWithRGBHex:0xff7700];
        
        if (1 == _listDto.cell) {
            self.timeLine.hidden = NO;
            self.timeLineGray.hidden = YES;
            self.timeLine.frame = CGRectMake(23.5, 20, 1, [ServiceDetailListInforCell cellHeight:_listDto.itemText] - 10);
            self.timePoint.frame = CGRectMake(20, 10, 16, 10);
            imgPoint = [UIImage imageNamed:@"Service_Detail_List_Cell_Arrow.png"];
            imgLine = [UIImage imageNamed:@"Service_Detail_List_Cell_Line.png"];
        }
        else if(4 == _listDto.cell){
            
            imgPoint = [UIImage imageNamed:@"Service_Detail_List_Cell_Arrow.png"];
            self.timePoint.frame = CGRectMake(20, 10, 16, 10);
        }
        
    }
    else{
        
        if (2 == _listDto.cell) {
            self.timeLine.hidden = YES;
            self.timeLineGray.hidden = NO;
            self.timeLineGray.frame = CGRectMake(23.5, 0, 1, 15);
            self.timePoint.frame = CGRectMake(20, 10, 8, 8);
            imgPoint = [UIImage imageNamed:@"Service_Detail_List_Cell_Point_Gray.png"];
            imgLine = [UIImage imageNamed:@"Service_Detail_List_Cell__Gray_Line.png"];
        }
        else if(3 == _listDto.cell){
            self.timeLine.hidden = YES;
            self.timeLineGray.hidden = NO;
            self.timePoint.frame = CGRectMake(20, 10, 8, 8);
            self.timeLineGray.frame = CGRectMake(23.5, self.timePoint.bottom, 1, [ServiceDetailListInforCell cellHeight:_listDto.itemText]);

            imgPoint = [UIImage imageNamed:@"Service_Detail_List_Cell_Point_Gray.png"];
            imgLine = [UIImage imageNamed:@"Service_Detail_List_Cell__Gray_Line.png"];
            
        }
        conLabelContent = [self setWebViewFontAndColor:_listDto.itemText font:14.0f color:@"#707070"];
//        conLabelContent = [self setWebViewFontAndColor:@"阿什顿卷卡式带看见俺很少的看见俺很少的看见俺说的空间按时到卡上15651698091" font:14.0f color:@"#FF7700"];

//        self.conLabel.textColor = [UIColor dark_Gray_Color];
        self.saleLabel.textColor = [UIColor dark_Gray_Color];
        self.timeLabel.textColor = [UIColor dark_Gray_Color];
    }
    
    self.timePoint.image = imgPoint;
    self.timeLine.image = imgLine;
    self.timeLineGray.image = imgLine;
    
    
//    self.conLabel.text = @"我的电话号码是15651698091";//_listDto.itemText;
//    NSString *conContent = [NSString stringWithFormat:@"<html> \n"
//     "<head> \n"
//     "<style type=\"text/css\"> \n"
//     "body {font-family: \"%@\"; font-size: %f; color: %@;}\n"
//     "</style> \n"
//     "</head> \n"
//     "<body>%@</body> \n"
//     "</html>", @"宋体", 14.0 ,@"#707070",@"我的电话号码是15651698091"] ;
    //改变字体大小颜色就:
//    NSString *jsString = [[NSString alloc] initWithFormat:@"document.body.style.fontSize=%f;document.body.style.color=%@",14.0f,@"#0x707070"];
//    [self.conLabel stringByEvaluatingJavaScriptFromString:jsString];
    [self.conLabel loadHTMLString:conLabelContent baseURL:nil];
    self.saleLabel.text = _listDto.itemDate;
    self.timeLabel.text = _listDto.itemTime;
    
    CGSize maximumSize = CGSizeMake(240, MAXFLOAT);
    
    CGSize stringSize = [_listDto.itemText sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:maximumSize lineBreakMode:UILineBreakModeWordWrap];

//    float height = [ServiceDetailListInforCell trackHeight:_listDto.itemText];
    self.conLabel.frame = CGRectMake(42,0,LABEL_WIDTH,stringSize.height + 10);
    self.saleLabel.frame = CGRectMake(50, self.conLabel.bottom + 0, 80, [ServiceDetailListInforCell timeLabelHight]);
    self.timeLabel.frame = CGRectMake(130, self.conLabel.bottom + 0, 60, [ServiceDetailListInforCell timeLabelHight]);
    self.iconImg.frame = CGRectMake(5, 0, 18, [ServiceDetailListInforCell cellHeight:_listDto.itemText]);
}


+(float)trackHeight:(NSString *)trackStr{
    
    NSString *trafString = [NSString stringWithFormat:@"%@",trackStr];
    CGSize trafficTips = [trafString sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(LABEL_WIDTH, 10000) lineBreakMode:UILineBreakModeCharacterWrap];
    
    if (trafficTips.height <21) {
        
        return 21;
    }
    
    return trafficTips.height;
}

+(float)timeLabelHight{
    
    return TIMELABEL_HEIGHT;
}

+(float)cellHeight:(NSString *)trackStr{
    
    return [ServiceDetailListInforCell trackHeight:trackStr] + [ServiceDetailListInforCell timeLabelHight] +25;
}

- (UIImageView *)timePoint
{
    if (!_timePoint) {
        _timePoint = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 16, 10)];
        _timePoint = [[UIImageView alloc] init];
        [self.contentView addSubview:_timePoint];
    }
    return _timePoint;
}

- (UIImageView *)timeLine
{
    if (!_timeLine) {
//        _timeLine = [[UIImageView alloc] initWithFrame:CGRectMake(26, 25, 5, [ServiceDetailListInforCell cellHeight:_listDto.itemText] - 15)];
        _timeLine = [[UIImageView alloc] init];
        [self.contentView addSubview:_timeLine];
    }
    return _timeLine;
}

- (UIImageView *)timeLineGray
{
    if (!_timeLineGray) {
        //        _timeLine = [[UIImageView alloc] initWithFrame:CGRectMake(26, 25, 5, [ServiceDetailListInforCell cellHeight:_listDto.itemText] - 15)];
        _timeLineGray = [[UIImageView alloc] init];
        [self.contentView addSubview:_timeLineGray];
    }
    return _timeLineGray;
}


-(UIImageView *)iconImg{
    
    if (!_iconImg) {
        
        _iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 18, 20)];
        
        [self.contentView addSubview:_iconImg];
    }
    
    return _iconImg;
}

//-(UIImageView *)backView{
//    
//    if (!_backView) {
//        
//        _backView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, 270, 20)];
//        
//        [self.contentView addSubview:_backView];
//    }
//    
//    return _backView;
//}

#pragma mark
#pragma UITextView Delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return NO;
}
- (void)textViewDidChange:(UITextView *)textView
{
    
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:[[URL absoluteString] substringFromIndex:4] delegate:self cancelButtonTitle:L(@"Cancel") destructiveButtonTitle:L(@"SSCall") otherButtonTitles:L(@"SSCopyText"), nil];
    actionSheet.tag = 100;
    self.telephoneNmber = [URL absoluteString];
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];

    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange
{
    return YES;
}


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
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:[[[request URL] absoluteString] substringFromIndex:4] delegate:self cancelButtonTitle:L(@"Cancel") destructiveButtonTitle:L(@"SSCall") otherButtonTitles:L(@"SSCopyText"), nil];
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
    NSString *conContent = [NSString stringWithFormat:@"<div style=\"word-wrap:break-word; float:left;width:240px; font-size:14px;font-family:helvetica;background-color:transparent; color:%@;\">%@</div>",colorStr,str];
//    NSString *conContent1 = [NSString stringWithFormat:@"<div id ='foo' align='left' style='line-height:18px; float:left;width:300px; font-size:28px;font-family:helvetica;background-color:transparent; color:#ff7070;>%@<div>",str] ;
    return conContent;
}



@end
