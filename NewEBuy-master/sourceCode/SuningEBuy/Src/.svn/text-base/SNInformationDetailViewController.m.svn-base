//
//  SNInformationDetailViewController.m
//  SuningEBuy
//
//  Created by xingxianping on 13-7-15.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "SNInformationDetailViewController.h"
#import "SNWebViewController.h"

@interface SNInformationDetailViewController ()
{
    NSString *infoId;
    NSString *imageSize;
}
@property (nonatomic,strong) InformationDetailDto *detail;
@property (nonatomic,strong) UIImageView *line;
@property (nonatomic,strong) UIImageView *line1;
@property (nonatomic,strong) UIImageView *rightArrow;
@end

@implementation SNInformationDetailViewController

@synthesize contentView=_contentView;
@synthesize titleLabel=_titleLabel;
@synthesize timeLabel=_timeLabel;
@synthesize image=_image;
@synthesize textLabel=_textLabel;
@synthesize activityBtn=_activityBtn;
@synthesize detail=_detail;
@synthesize sourceLbl=_sourceLbl;
@synthesize line=_line;
@synthesize line1=_line1;
@synthesize rightArrow =_rightArrow;

@synthesize informationService=_informationService;

- (id)initWithInfoId:(NSString *)theInfoId andsize:(NSString *)size
{
    self=[super init];
    if (self) {
        infoId=theInfoId;
        imageSize=size;
        
        self.title=L(@"Imformation_NewsDetail");
        
        self.pageTitle = L(@"PageTitleDisplayImformationDetails");
        
    }
    return self;
}


- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(_informationService);
    TT_RELEASE_SAFELY(_image);
    TT_RELEASE_SAFELY(_titleLabel);
    TT_RELEASE_SAFELY(_timeLabel);
    TT_RELEASE_SAFELY(_textLabel);
    TT_RELEASE_SAFELY(_detail);
    TT_RELEASE_SAFELY(_sourceLbl);
    TT_RELEASE_SAFELY(_line);
    TT_RELEASE_SAFELY(_line1);
    TT_RELEASE_SAFELY(_rightArrow);
}

- (void)loadView
{
    [super loadView];
    
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.textLabel];
    [self.contentView addSubview:self.sourceLbl];
    [self.contentView addSubview:self.activityBtn];
    [self.contentView addSubview:self.image];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.line1];
    [self.contentView addSubview:self.rightArrow];
    
    [self displayOverFlowActivityView];
    [self.informationService beginInformationDetailHttpRequest:infoId];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.line.hidden =YES;
    self.line1.hidden =YES;
    self.rightArrow.hidden =YES;
	// Do any additional setup after loading the view.
}

- (SNInformationService *)informationService
{
    if (!_informationService) {
        _informationService=[[SNInformationService alloc]init];
        _informationService.delegate=self;
    }
    return _informationService;
}

- (UIScrollView *)contentView
{
    if (!_contentView) {
        _contentView=[[UIScrollView alloc]init];

        _contentView.frame =[self visibleBoundsShowNav:YES showTabBar:NO];
        
        _contentView.backgroundColor=[UIColor clearColor];
        _contentView.showsVerticalScrollIndicator=NO;
        
    }
    return _contentView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 10, 260, 20)];
        _titleLabel.font=[UIFont boldSystemFontOfSize:13];
        _titleLabel.numberOfLines=0;
        _titleLabel.textAlignment=UITextAlignmentLeft;
        _titleLabel.contentMode=UIViewContentModeLeft;
        _titleLabel.lineBreakMode=UILineBreakModeWordWrap;
        _titleLabel.adjustsFontSizeToFitWidth=YES;
        _titleLabel.backgroundColor=[UIColor clearColor];
        _titleLabel.textColor=[UIColor light_Black_Color];
    }
    return _titleLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 40, 150, 20)];
        _timeLabel.font=[UIFont systemFontOfSize:12];
        _timeLabel.textAlignment=UITextAlignmentLeft;
        _timeLabel.contentMode=UIViewContentModeLeft;
        _timeLabel.lineBreakMode=UILineBreakModeWordWrap;
        _timeLabel.backgroundColor=[UIColor clearColor];
        _timeLabel.textColor=[UIColor dark_Gray_Color];
    }
    return _timeLabel;
}

- (EGOImageViewEx *)image
{
    if (!_image) {
        _image=[[EGOImageViewEx alloc]init];
        if ([imageSize isEqualToString:@"big"]) {
            _image.frame=CGRectMake(30, 70, 260, 140);
        }
        else
            _image.frame=CGRectMake(90, 70, 140, 140);
        
    }
    return _image;
}

- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 220, 260, 80)];
        _textLabel.font=[UIFont systemFontOfSize:12];
        _textLabel.textAlignment=UITextAlignmentLeft;
        _textLabel.contentMode=UIViewContentModeLeft;
        _textLabel.numberOfLines=0;
        _textLabel.lineBreakMode=UILineBreakModeWordWrap;
        _textLabel.backgroundColor=[UIColor clearColor];
        _textLabel.textColor=[UIColor dark_Gray_Color];
    }
    return _textLabel;
}

- (UIImageView *)line
{
    if (!_line) {
        _line =[[UIImageView alloc]initWithFrame:CGRectMake(0, self.sourceLbl.top, 320, 1)];
        _line.image =[UIImage streImageNamed:@"line"];
        _line.backgroundColor =[UIColor clearColor];
    }
    return _line;
}

- (UIImageView *)line1
{
    if (!_line1) {
        _line1 =[[UIImageView alloc]initWithFrame:CGRectMake(0, self.sourceLbl.bottom, 320, 1)];
        _line1.image =[UIImage streImageNamed:@"line"];
        _line1.backgroundColor =[UIColor clearColor];
    }
    return _line1;
}

- (UIImageView *)rightArrow
{
    if (!_rightArrow) {
        _rightArrow =[[UIImageView alloc]initWithFrame:CGRectMake(280, self.sourceLbl.top +12, 8, 12)];
        _rightArrow.image =[UIImage imageNamed:@"arrow_right_gray"];
        _rightArrow.backgroundColor =[UIColor clearColor];
    }
    return _rightArrow;
}
- (UILabel *)sourceLbl
{
    if (!_sourceLbl) {
        _sourceLbl=[[UILabel alloc]initWithFrame:CGRectMake(30, 305, 260, 40)];
        _sourceLbl.font=[UIFont systemFontOfSize:13];
        _sourceLbl.textAlignment=UITextAlignmentLeft;
        _sourceLbl.contentMode=UIViewContentModeLeft;
        _sourceLbl.numberOfLines=1;
        _sourceLbl.lineBreakMode=UILineBreakModeTailTruncation;
        _sourceLbl.backgroundColor=[UIColor clearColor];
        _sourceLbl.textColor=[UIColor orange_Light_Color];
        _sourceLbl.userInteractionEnabled=YES;
    }
    return _sourceLbl;
}

- (UIButton *)activityBtn
{
    if (!_activityBtn) {
        _activityBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [_activityBtn setFrame:CGRectMake(0, 305, 320, 40)];
        [_activityBtn addTarget:self action:@selector(goToMoreActivity) forControlEvents:UIControlEventTouchUpInside];
        _activityBtn.backgroundColor=[UIColor clearColor];
    }
    return _activityBtn;
}

- (void )goToMoreActivity
{
    if (IsStrEmpty(self.detail.url)) {
        return ;
    }
    else
    {
        NSString *url = self.detail.url.trim;
        if (url.length)
        {
            SNWebViewController *vc = [[SNWebViewController alloc] initWithType:SNWebViewTypeAdModel attributes:@{@"url": url, @"activeName": self.detail.infoSource?self.detail.infoSource:@""}];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (CGFloat )LabelHeight:(NSString *)string withFont:(CGFloat )theFont
{
    UIFont *font=[UIFont systemFontOfSize:theFont];
    CGSize size=[string sizeWithFont:font constrainedToSize:CGSizeMake(260, 300000.f) lineBreakMode:NSLineBreakByWordWrapping];
    
    return size.height+10;
}

- (void)loadData
{
    self.titleLabel.text=self.detail.title;
    self.timeLabel.text=self.detail.publishTime;
    self.textLabel.text=self.detail.content;
    self.image.imageURL=[NSURL URLWithString:self.detail.imgUrl];
    if (self.detail.infoSource && !IsStrEmpty(self.detail.url)) {
        self.sourceLbl.text=self.detail.infoSource;
        self.line.hidden =NO;
        self.line1.hidden =NO;
        self.rightArrow.hidden =NO;
    }
    else
    {
        self.sourceLbl.hidden=YES;
        self.activityBtn.hidden=YES;
        self.line.hidden =YES;
        self.line1.hidden =YES;
        self.rightArrow.hidden =YES;
    }
    
    CGFloat high=[self LabelHeight:self.detail.title withFont:13];
    [self.titleLabel setHeight:high];
    
    [self.timeLabel setOrigin:CGPointMake(30, self.titleLabel.bottom)];
    if ([imageSize isEqualToString:@"big"]) {
        [self.image setFrame:CGRectMake(30, self.timeLabel.bottom+5, 260, 140)];
    }
    else
        [self.image setFrame:CGRectMake(90, self.timeLabel.bottom+5, 140, 140)];
    
    CGFloat height=[self LabelHeight:self.detail.content withFont:12];
    [self.textLabel setFrame:CGRectMake(30, self.image.bottom+5, 260, height)];
    
    [self.activityBtn setFrame:CGRectMake(0, self.textLabel.bottom, 320, 40)];
    [self.sourceLbl setOrigin:CGPointMake(30, self.textLabel.bottom+1)];
    
    self.line.origin=CGPointMake(0, self.textLabel.bottom);
    self.line1.origin =CGPointMake(0, self.sourceLbl.bottom);
    self.rightArrow.origin =CGPointMake(280, self.line.bottom+15);
    
    CGFloat totalheight=self.line1.bottom;
    CGFloat viewHeihet =[self visibleBoundsShowNav:YES showTabBar:YES].size.height;
    
    if (totalheight<=viewHeihet) {
        viewHeihet=totalheight;
    }
    self.contentView.contentSize=CGSizeMake(320,totalheight);
}
#pragma mark-serviceDelegate
- (void)informationServiceComplete:(SNInformationService *)service isSuccess:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        self.detail = self.informationService.detailDto;
        
        [self loadData];
    }
    else
    {
        NSString *errorMsg = service.errorMsg.trim.length?service.errorMsg:L(@"Imformation_NetworlLinkFailed");
        [self presentSheet:errorMsg];
    }
}
@end
