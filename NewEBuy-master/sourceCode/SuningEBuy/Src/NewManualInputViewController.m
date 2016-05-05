//
//  NewManualInputViewController.m
//  SuningEBuy
//
//  Created by xingxianping on 13-8-3.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NewManualInputViewController.h"
#import "UIColor+Helper.h"
#import "RegexKitLite.h"

@interface NewManualInputViewController ()

@end

@implementation NewManualInputViewController

@synthesize contentViewController=_contentViewController;

@synthesize seachFied=_seachFied;

@synthesize searchBg=_searchBg;

@synthesize textLabel=_textLabel;

@synthesize delegate=delegate_;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithContentController:(UIViewController *)contentController
{
    self = [super init];
    
    if (self)
    {
        self.contentViewController = contentController;
        
        self.title = L(@"Search_BarPay");
        
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"search_searchPage"),self.title];
    }
    return self;
}


- (void)loadView
{
    [super loadView];
    
    self.isNeedBackItem=NO;
    
    
    
    
    UIBarButtonItem *cancelButton = [UIBarButtonItem initWithImage:@"navbar_left_normal.png" withName:L(@"Cancel")];// wihtSel:nil];
    if (cancelButton.customView) {
        UIButton *btn = (UIButton *)cancelButton.customView;
        [btn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    }
    self.navigationItem.leftBarButtonItem = cancelButton;
    
//    UIBarButtonItem *sureButton =[UIBarButtonItem initWithImage:@"navbar_right_normal.png" withName:@"确定"];
//    if (sureButton.customView) {
//        UIButton *btn =(UIButton *)sureButton.customView;
//        [btn addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    
    CGSize size = [L(@"Ok") sizeWithFont:[UIFont boldSystemFontOfSize:15.0]];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 2.5, 0, 0)];
    [btn addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage streImageNamed:@"navbar_right_normal.png"] forState:UIControlStateNormal];
    [btn setTitle:L(@"Ok") forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 6, size.width + 20, 32);
    UIBarButtonItem *sureButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = sureButton;
    
    self.view.backgroundColor = RGBCOLOR(245, 242, 232);
    
    [self.view addSubview:self.searchBg];
    [self.view addSubview:self.seachFied];
    [self.seachFied becomeFirstResponder];
    [self.view addSubview:self.textLabel];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)sure:(id)sender
{
    NSString *isbn = self.seachFied.text;
    
    NSString *isbnRegex = @"[0-9]{6,100}";
    NSPredicate *isbnPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", isbnRegex];
    
    if (![isbnPredicate evaluateWithObject:isbn]) {
        [self presentSheet:L(@"Search_PleaseEnterTheCorrectCode")];
        return;
    }
    
    if ([self.delegate conformsToProtocol:@protocol(ManualInputDelegate)])
    {
        if ([self.delegate respondsToSelector:@selector(shouldBeginSearchIsbnWithISBN:)])
        {
            [self.delegate shouldBeginSearchIsbnWithISBN:isbn];
        }
    }

}


- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel=[[UILabel alloc]initWithFrame:CGRectMake(40, 96, 240, 20)];
        _textLabel.text=L(@"Search_PleaseEnterGoodCode");
        _textLabel.textAlignment=UITextAlignmentLeft;
        _textLabel.backgroundColor=[UIColor clearColor];
        _textLabel.textColor=RGBCOLOR(157, 138, 115);
    }
    return _textLabel;
}

- (UITextField *)seachFied
{
    if (!_seachFied) {
        _seachFied=[[UITextField alloc]init];
        _seachFied.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
        _seachFied.delegate=self;
        _seachFied.frame=CGRectMake(50, 52, 224, 26);
        _seachFied.contentMode=UIViewContentModeCenter;

    }
    return _seachFied;
}

- (UIImageView *)searchBg
{
    if (!_searchBg) {
        _searchBg=[[UIImageView alloc]initWithFrame:CGRectMake(40, 46, 240, 32)];
        _searchBg.image=[UIImage imageNamed:@"new_home_searchBar_white.png"];
    }
    return _searchBg;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-
#pragma mark texyfield delegate method
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}


@end
