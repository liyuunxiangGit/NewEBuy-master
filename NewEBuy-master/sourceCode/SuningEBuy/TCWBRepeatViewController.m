//
//  TCWBRepeatViewController.m
//  TCWeiBoSDKDemo
//
//  Created by zzz on 9/18/12.
//  Copyright (c) 2012 bysft. All rights reserved.
//

#import "TCWBRepeatViewController.h"
#import "key.h"
#import "RegexKitLite.h"
#import <QuartzCore/QuartzCore.h>
#import "UINoteView.h"


@implementation TCWBRepeatViewController
@synthesize dictRepeat;
@synthesize wbEngine;

- (void)dealloc {
    [wbEngine cancelSpecifiedDelegateAllRequest:self];
    textView = nil;
    viewWordNum = nil;
}

- (id)initWithEngine:(TCWBEngine *)engine parameter:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.dictRepeat = [NSDictionary dictionaryWithDictionary:dict];
        self.wbEngine = engine;
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    DLog(@"%@",NSStringFromCGRect(self.view.frame));
    
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor colorWithRed:199.0/255.0 green:203.0/255.0 blue:205.0/255.0 alpha:1.0];
    // 导航条
    UIImageView *imageViewNavBar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"composeupbg.png"]];
    [imageViewNavBar setFrame:CGRectMake(0, 0, self.view.frame.size.width, NavBarHeight)];
    [imageViewNavBar setUserInteractionEnabled:YES];
    [self.view addSubview:imageViewNavBar];
    
    // 标题
    UILabel *labelTitle = [[UILabel alloc] init];
    [labelTitle setBackgroundColor:[UIColor clearColor]];
    [labelTitle setFont:[UIFont systemFontOfSize:17]];
    [labelTitle setTextColor:[UIColor whiteColor]];
    [labelTitle setTextAlignment:UITextAlignmentCenter];
    NSBundle *main = [NSBundle mainBundle];
    NSString *strRebroadcast = [main localizedStringForKey:kLanguageRelay value:nil table:kTCWBTable];    
    [labelTitle setText:strRebroadcast];
    CGSize szTitle = [labelTitle.text sizeWithFont:labelTitle.font];
    [labelTitle setFrame:CGRectMake((320 - szTitle.width)/2, (44 - szTitle.height)/2, szTitle.width, szTitle.height)];
    [self.view addSubview:labelTitle];
    
    // 取消
    NSString *strCancel = [main localizedStringForKey:KLanguageCancel value:nil table:kTCWBTable];
    UIButton *buttonLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonLeft.frame = CGRectMake(5, 5.5, 52, 33);
	buttonLeft.titleLabel.font = [UIFont systemFontOfSize:14];
    [buttonLeft setTitle:strCancel forState:UIControlStateNormal];
    [buttonLeft setBackgroundImage:[UIImage imageNamed:@"composequxiaobtn.png"] forState:UIControlStateNormal];
	[buttonLeft addTarget:self action:@selector(cancelCompose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonLeft];
    
    // 转播
    NSString *strSend = [main localizedStringForKey:kLanguageRelay value:nil table:kTCWBTable];
    UIButton *buttonRight = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonRight.frame = CGRectMake(263, 5, 52, 33);
	[buttonRight setTitle:strSend forState:UIControlStateNormal];
    buttonRight.titleLabel.font = [UIFont systemFontOfSize:14];
	[buttonRight setBackgroundImage:[UIImage imageNamed:@"composesentbtn.png"] forState:UIControlStateNormal];
    [buttonRight setBackgroundImage:[UIImage imageNamed:@"composesentbtnhover.png"] forState:UIControlStateHighlighted];
    [buttonRight addTarget:self action:@selector(DoneCompose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonRight];
    
    // 放置文本框的背景
    UIView *viewBase = [[UIView alloc] initWithFrame:CGRectMake(9, (53.00000/460.000000)*self.view.frame.size.height, 302, (87.5/460.000000)*self.view.frame.size.height)];
    viewBase.backgroundColor = [UIColor whiteColor];
    viewBase.layer.cornerRadius = 8;
    [self.view addSubview:viewBase];
    
    // 文本框
    textView = [[UITextView alloc] initWithFrame:CGRectMake(9, (53.00000/460.000000)*self.view.frame.size.height, 302, (67.5/460.000000)*self.view.frame.size.height)];
    textView.backgroundColor = [UIColor clearColor];
    textView.delegate = self;
    textView.text = [self.dictRepeat objectForKey:@"content"];
    textView.textColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];
    textView.font = [UIFont systemFontOfSize:16];
//    textView.layer.cornerRadius = 8;
//    textView.layer.masksToBounds = YES;
    [self.view addSubview:textView];
    
    // 计算文本字数的视图
    viewWordNum = [[WordsLeftView alloc] initWithFrame:CGRectMake(292, (122.500000/460.00000)*self.view.frame.size.height, 30, 30)];
    [self.view addSubview:viewWordNum];
    
    // 计算初始文字
    int textUTF8StrLength = [self calcStrWordCount:textView.text];
    if (textUTF8StrLength > MaxInputWords + 200) {
        textView.text = [textView.text substringToIndex:MaxInputWords + 200];
    }
    NSInteger charLeft = MaxInputWords - textUTF8StrLength ;
    wordNum = charLeft;
    // 修正字个数
    [viewWordNum setWordsNum:charLeft];
//    viewWordNum.wordsNum = MaxInputWords;
    
    // video缩略图边框
    UIImageView *imageviewRim = [[UIImageView alloc] initWithFrame:CGRectMake(65.5, (156.000000/460.000000)*self.view.frame.size.height, 189, 127)];
    imageviewRim.userInteractionEnabled = YES;
    imageviewRim.image = [UIImage imageNamed:@"composepic_biankuang.png"];
    [self.view addSubview:imageviewRim];
    
    
    //图片缩略图，分页显示
    scroViewPic = [[UIScrollView alloc] initWithFrame:CGRectMake(3.5, 3.5, 182, 120)];
    scroViewPic.delegate = self;
    scroViewPic.backgroundColor = [UIColor clearColor];
    scroViewPic.contentSize = CGSizeMake(182 * 2, 120);
    scroViewPic.showsHorizontalScrollIndicator = NO;
    scroViewPic.showsVerticalScrollIndicator = YES;
    scroViewPic.pagingEnabled = YES;
    scroViewPic.scrollEnabled = NO;
    scroViewPic.tag = 101;
    [imageviewRim addSubview:scroViewPic];
    
    // 图片信息
    NSURL *urlPic = [NSURL URLWithString:[self.dictRepeat objectForKey:@"imageRefURL"]];
    NSData *dataPic = [NSData dataWithContentsOfURL:urlPic];
    UIImage *image1 = [UIImage imageWithData:dataPic];
    
    // video缩略图
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 182, 120)];
    imageView.image = [UIImage imageNamed:@"composevideo_pic.png"];
    imageView.userInteractionEnabled = YES;
    imageView.tag = IMAGETAG;
    [scroViewPic addSubview:imageView];
        
    // 开始按钮（不可点击）
    UIButton *btnStart = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnStart setImage:[UIImage imageNamed:@"repeatVideoStarticon.png"] forState:UIControlStateNormal];
    btnStart.frame = CGRectMake(70, 39, 43, 43);
    btnStart.tag = 90;
    btnStart.hidden = YES;
    btnStart.enabled = NO;
    [imageView addSubview:btnStart];
        
    // loading视图
    UIActivityIndicatorView *loadView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(70, 39, 43, 43)];
    loadView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    loadView.tag = LOADINGVIWTAG;
    [loadView startAnimating];
    [imageView addSubview:loadView];

    // 如果图片存在，把图片放在第一页
    if (image1) {
        scroViewPic.scrollEnabled = YES;
        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:IMAGETAG];
        imageView.frame = CGRectMake(182, 0, 182, 120);
        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 182, 120)];
        imageView1.image = image1;
        [scroViewPic addSubview:imageView1];
        TT_RELEASE_SAFELY(imageView1);
        
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(50, 100, 82, 10)];
        pageControl.numberOfPages = 2;
        [imageviewRim addSubview:pageControl];
    }
    
    // 获得video相关信息
    [self.wbEngine getViedoMsgWith:@"json" 
                          videoURL:[NSURL URLWithString:[self.dictRepeat objectForKey:@"videoImageRefURL"]] 
                          delegate:self 
                         onSuccess:@selector(getViedoMiniPicSuccess:) 
                         onFailure:@selector(getViedoMiniPicFaile:)];
    
    // 错误提示
    UINoteView *noteview = [[UINoteView alloc] initWithFrame:CGRectMake(80, (140.00000/460.000000) * self.view.frame.size.height, 220, (135.000000/460.000000) * self.view.frame.size.height)];
    [noteview setTag:NOTEVIEWTAG];
    
    [self.view addSubview:noteview];


}


// 完成并转播
- (void)DoneCompose:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.enabled = NO;
    [self dismissModalViewControllerAnimated:YES];
    id delegate = ((DelegateObject *)[self.dictRepeat objectForKey:@"requestDelegate"]).delegate;
    SEL postStartCallback = NSSelectorFromString([self.dictRepeat objectForKey:@"postStartCallback"]);
    if ([delegate respondsToSelector:postStartCallback]) {
        SuppressPerformSelectorLeakWarning
        ([delegate performSelector:postStartCallback]);
    }
    NSMutableDictionary *dicAppFrom = [NSMutableDictionary dictionaryWithObject:@"ios-sdk-2.0-publish" forKey:@"appfrom"];
    NSURL *urlVideo = [NSURL URLWithString:[self.dictRepeat objectForKey:@"videoImageRefURL"]];
    NSURL *urlPic = [NSURL URLWithString:[self.dictRepeat objectForKey:@"imageRefURL"]];
    [self.wbEngine repeatMsgWithFormat:@"json"
                               content:([textView hasText] ? textView.text:@"分享")
                              clientip:nil 
                             longitude:nil
                              latitude:nil 
                                picURL:urlPic 
                              videoURL:urlVideo
                              musicURL:nil 
                            musicTitle:nil
                           musicAuthor:nil
                              syncflag:nil 
                        compatibleflag:nil 
                           parReserved:dicAppFrom
                              delegate:delegate 
                             onSuccess:NSSelectorFromString([self.dictRepeat objectForKey:@"successCallback"]) 
                             onFailure:NSSelectorFromString([self.dictRepeat objectForKey:@"failureCallback"])];

}
// 取消
- (void)cancelCompose:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}


// 获得video缩略图成功回调
- (void)getViedoMiniPicSuccess:(NSDictionary *)dict {
    DLog(@"%s %@", __FUNCTION__,dict);
    NSDictionary *dictData = [dict objectForKey:@"data"];
    if (![dictData isKindOfClass:[NSNull class]]) {
        NSString *strPicURL = [dictData objectForKey:@"minipic"];
        if (strPicURL.length != 0) {
            UIImageView *pivImageView = (UIImageView *)[self.view viewWithTag:IMAGETAG];
            pivImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:strPicURL]]];
            UIButton *button = (UIButton *)[self.view viewWithTag:90];
            button.hidden = NO;
        }else {
            NSString *strNote = @"网络错误";
           [self performSelector:@selector(showNoteView:) withObject:strNote afterDelay:1.5];
        }
    }
    UIActivityIndicatorView *activityIndicatorView = (UIActivityIndicatorView *)[self.view viewWithTag:LOADINGVIWTAG];
    [activityIndicatorView stopAnimating];
}

// 获得video缩略图失败回调
- (void)getViedoMiniPicFaile:(NSError *)error {
    DLog(@"%s %@", __FUNCTION__,error);
    UIActivityIndicatorView *activityIndicatorView = (UIActivityIndicatorView *)[self.view viewWithTag:LOADINGVIWTAG];
    [activityIndicatorView stopAnimating];
    NSString *strNote = @"请求超时";
    [self performSelector:@selector(showNoteView:) withObject:strNote afterDelay:1.5];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [textView resignFirstResponder];
}

// 字数统计
- (int)calcStrWordCount:(NSString *)str {
	int nResult = 0;
	NSString *strSourceCpy = [str copy];
	NSMutableString *strCopy =[[NSMutableString alloc] initWithString: strSourceCpy];
    NSArray *array = [strCopy componentsMatchedByRegex:@"((news|telnet|nttp|file|http|ftp|https)://){1}(([-A-Za-z0-9]+(\\.[-A-Za-z0-9]+)*(\\.[-A-Za-z]{2,5}))|([0-9]{1,3}(\\.[0-9]{1,3}){3}))(:[0-9]*)?(/[-A-Za-z0-9_\\$\\.\\+\\!\\*\\(\\),;:@&=\\?/~\\#\\%]*)*"];
	if ([array count] > 0) {
		for (NSString *itemInfo in array) {
			NSRange searchRange = {0};
			searchRange.location = 0;
			searchRange.length = [strCopy length];
			[strCopy replaceOccurrencesOfString:itemInfo withString:@"aaaaaaaaaaaa" options:NSCaseInsensitiveSearch range:searchRange];
		}
	}
    
	char *pchSource = (char *)[strCopy cStringUsingEncoding:NSUTF8StringEncoding];
	int sourcelen = strlen(pchSource);
	
	int nCurNum = 0;		// 当前已经统计的字数
	for (int n = 0; n < sourcelen; ) {
		if( *pchSource & 0x80 ) {
			pchSource += 3;		// NSUTF8StringEncoding编码汉字占３字节
			n += 3;
			nCurNum += 2;
		}
		else {
			pchSource++;
			n += 1;
			nCurNum += 1;
		}
	}
	// 字数统计规则，不足一个字(比如一个英文字符)，按一个字算
	nResult = nCurNum / 2 + nCurNum % 2;	 
	
	return nResult;
}

#pragma mark TextVeiwDelegate

// 往textView输入文字时触发
- (void)textViewDidChange:(UITextView *)tView {
        int textUTF8StrLength = [self calcStrWordCount:textView.text];
		if (textUTF8StrLength > MaxInputWords + 200) {
			tView.text = [tView.text substringToIndex:MaxInputWords + 200];
		} 
		NSInteger charLeft = MaxInputWords - textUTF8StrLength ; 
        wordNum = charLeft;
        // 修正字个数
        [viewWordNum setWordsNum:charLeft];
}

// textView中不直接输入字而改变内容的时候触发
//- (void)textViewDidBeginEditing:(UITextView *)textV {
//		int textUTF8StrLength = [self calcStrWordCount:textView.text];
//		if (textUTF8StrLength > MaxInputWords + 200) {
//			textV.text = [textView.text substringToIndex:MaxInputWords + 200];
//		}
//            NSInteger charLeft = MaxInputWords - textUTF8StrLength ; 
//            wordNum = charLeft;
//            // 修正字个数
//            [viewWordNum setWordsNum:charLeft];
//}

// textView 内容将要改变时触发
- (BOOL)textView:(UITextView *)textV shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (wordNum == 0 ) {
        if (range.length != 0) {    // 当字数等于0的时候，不可以输入，但是可以删除
            return YES;
        }
        return NO;
    }
	return YES;
}

// 显示错误提示
- (void)showNoteView:(NSString *)strText {
    UINoteView *noteview = (UINoteView *)[self.view viewWithTag:NOTEVIEWTAG];
    [noteview setNoteText:strText];
    [noteview showNoteView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int currentPage = scroViewPic.contentOffset.x / scroViewPic.frame.size.width;
    pageControl.currentPage = currentPage;
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
