//
//  ShareContentViewController.m
//  SuningEBuy
//
//  Created by lanfeng on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ShareContentViewController.h"
 

@implementation ShareContentViewController



@synthesize navigationBar = _navigationBar;
@synthesize nicknameView = _nicknameView;
@synthesize shareContent = _shareContent;
@synthesize nicknamelabel = _nicknamelabel;
@synthesize shareContentViewControllerDelegate = _shareContentViewControllerDelegate;
@synthesize shareContentString = _shareContentString;
@synthesize nickName = _nickName;
@synthesize image = _image;
@synthesize shareType = _shareType;
@synthesize imageURL = _imageURL;


- (id)initWithContent:(NSString *)text image:(UIImage *)image  shareType:(SNShareType) shareType {
    
    self = [super init];
    
    if (self) {
        
        self.isNeedBackItem = NO;
        self.shareType = shareType;
        
        if (self.shareType == SNShareTCWeiBo) {
            self.title = L(@"Share_To_TC_WeiBo");
        }if (self.shareType == SNShareSinaWeibo) {
            self.title = L(@"Share_To_Sina_WeiBo");
        }
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"show_productDetail"),self.title];
        self.shareContentString = text;
        
        self.image = image;
        
        self.nickName = @"";

        UIBarButtonItem *cancelButton = [UIBarButtonItem initWithImage:@"right_item_btn.png" withName:L(@"Cancel")];// wihtSel:nil];
        if (cancelButton.customView) {
            UIButton *btn = (UIButton *)cancelButton.customView;
            [btn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        }
        self.navigationItem.leftBarButtonItem = cancelButton;
//        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:L(@"Cancel") style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
//		self.navigationItem.leftBarButtonItem = cancelButton;
//        TT_RELEASE_SAFELY(cancelButton);
        
//        UIBarButtonItem *okButton = [[UIBarButtonItem alloc]initWithTitle:L(@"SNS_Release") style:UIBarButtonItemStylePlain target:self action:@selector(submit)];
//		self.navigationItem.rightBarButtonItem = okButton;
//        TT_RELEASE_SAFELY(okButton);
        self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"SNS_Release")];

    }
    
    return self;
}

- (void)righBarClick
{
    [self submit];
}

- (void)dealloc{
    
    TT_RELEASE_SAFELY(_tableView);
    
    TT_RELEASE_SAFELY(_navigationBar);
    
    TT_RELEASE_SAFELY(_nicknameView);
    
    TT_RELEASE_SAFELY(_shareContent);
    
    TT_RELEASE_SAFELY(_nicknamelabel);
    
    TT_RELEASE_SAFELY(_nickName);
    
    TT_RELEASE_SAFELY(_shareContentString);
    
    TT_RELEASE_SAFELY(_imageURL);
    
    TT_RELEASE_SAFELY(_image);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}


- (void)loadView
{
    [super loadView];
    
    UIView *contentView = self.view;
	
	CGRect frame = contentView.frame;
	
	frame.origin.x = 0;
	
	frame.origin.y = 44;
	
	frame.size.height = contentView.bounds.size.height -44;
	
	self.tpTableView.frame = frame;
    
    self.tpTableView.scrollEnabled = YES;
    
	[self.view addSubview:self.tpTableView];
    
    [self.view addSubview:self.nicknameView];
        
}

- (UIView *)nicknameView{
    if (_nicknameView == nil) {
        _nicknameView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
        _nicknameView.backgroundColor = [UIColor blackColor];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
        if (self.shareType == SNShareSinaWeibo) {
            imageView.image = [UIImage imageNamed:@"LOGO_24x24.png"];
        }
        if (self.shareType == SNShareTCWeiBo) {
            imageView.image = [UIImage imageNamed:@"TCweiboicon24.png"];
        }
        [_nicknameView addSubview:imageView];
        [_nicknameView addSubview:self.nicknamelabel];
        _nicknameView.alpha = 0.7;
        TT_RELEASE_SAFELY(imageView);
        
    }
    return _nicknameView;
}

- (UILabel *)nicknamelabel{
    if (_nicknamelabel == nil) {
        _nicknamelabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 250, 40)];
        _nicknamelabel.backgroundColor = [UIColor clearColor];
        _nicknamelabel.textColor = [UIColor whiteColor];
        _nicknamelabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _nicknamelabel;
}


- (UITextView *)shareContent{
    
    if (_shareContent == nil) {
        
        _shareContent = [[UITextView alloc]initWithFrame:CGRectMake(10, 0, 300, 160)];
        
        _shareContent.text = @"";
        
        _shareContent.backgroundColor = [UIColor clearColor];
        
        _shareContent.font = [UIFont systemFontOfSize:14.0];
        
        _shareContent.delegate = self;
        
    }
    return _shareContent;
}





- (void)setNickName:(NSString *)nickName{
    
    if (_nickname != nickName) {
        _nickname = [nickName copy];
        
        self.nicknamelabel.text = 
        [NSString stringWithFormat:@"%@ %@", L(@"Using_WeiBo_Account:"), _nickname] ;
    }
}

#pragma action

- (void)submit{
    
    [self.shareContent resignFirstResponder];
    
    if ([self.shareContent.text isEmptyOrWhitespace]) {
        
        [self presentSheet:L(@"Input_Share_Content") posY:100];
        
        return;
    }
    
    //add by xiewei z 字符不能超过140个
    if (self.shareContent.text.length > 140) {
        
        [self presentSheet:L(@"Input_Share_TooLong") posY:100];
        
        return;
    }
    
    [self displayOverFlowActivityView:L(@"loading...") maxShowTime:30];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    if ([_shareContentViewControllerDelegate respondsToSelector:@selector(shareContentToSNS:)])
    {
        [self.shareContentViewControllerDelegate shareContentToSNS:self.shareContentString];
    }
    
}


- (void)cancel{
        
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Table View DataSource And Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_image)
    {
        return 2;
    }
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //图片
    if (indexPath.section ==1) {
        
        static NSString *imageCellIdentifier = @"imageCellIdentifier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:imageCellIdentifier];
        
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:imageCellIdentifier];
            
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        CGFloat widthP = _image.size.width/300;
//        CGFloat heightP = _image.size.height/160;
//        CGFloat width = _image.size.width;
//        CGFloat height = _image.size.height;
//        if (widthP > 1 || heightP > 1) {
//            if (widthP > heightP) {
//                width = _image.size.width/widthP;
//                height = _image.size.height/widthP;
//            }else{
//                width = _image.size.width/heightP;
//                height = _image.size.height/heightP;
//            }
//        }
        
        EGOImageViewEx *imageView = [[EGOImageViewEx alloc]initWithFrame:CGRectMake((300-80)/2.0,
                                                                              (160-100)/2.0,
                                                                              100,
                                                                              100)];
        imageView.delegate = self;
        imageView.exDelegate = self;
        imageView.backgroundColor =[UIColor clearColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.userInteractionEnabled = YES;
        imageView.placeholderImage = [UIImage imageNamed:@"ebuy_default_image_placeholder.png"];
        imageView.imageURL = self.imageURL;
        [cell addSubview:imageView];
        TT_RELEASE_SAFELY(imageView);
        
        return cell;
    }
    //分享的文本内容
    static NSString *tableViewCellIdentifier = @"tableViewCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellIdentifier];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.shareContent.text = _shareContentString;
    
    [cell addSubview:self.shareContent];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 160;
    
}


#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView{
    
    self.shareContentString = textView.text;

}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
//    NSRange rang =textView.selectedRange;
    
    return YES;
}

@end
