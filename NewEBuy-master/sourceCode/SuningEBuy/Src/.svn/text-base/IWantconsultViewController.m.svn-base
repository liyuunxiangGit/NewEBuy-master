//
//  IWantconsultViewController.m
//  SuningEBuy
//
//  Created by sn－wahaha on 14-6-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "IWantconsultViewController.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>

@interface IWantconsultViewController ()
{
    UIImageView *arrowbtn;
    BOOL        istableshow;
    UIImageView  *imgview;
    NSArray     *zixuntypearr;
}
@property (nonatomic,strong)UIButton *backBtn;
@end

@implementation IWantconsultViewController


- (void)dealloc
{
    _httpsend.delegate = nil;
    SERVICE_RELEASE_SAFELY(_httpsend);
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)init{
    self = [super init];
    if (self) {
      
    }
    return self;
}

- (ConsultationService *)httpsend
{
    if (!_httpsend) {
        _httpsend = [[ConsultationService alloc] init];
        _httpsend.delegate = self;
    }
    return _httpsend;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    istableshow = NO;
    SNUIBarButtonItem *rightButton = [SNUIBarButtonItem itemWithTitle:L(@"BTCommit")
                                                                Style:SNNavItemStyleDone
                                                               target:self
                                                               action:@selector(submit)];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.title=L(@"PageTitleIWantConsultation");
    self.navigationItem.rightBarButtonItem.enabled = NO;
   
    self.tableView.frame = CGRectMake(1, 0, 158, 240);
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.tableView setScrollEnabled:NO];
    imgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pop.png"]];
    imgview.frame=CGRectMake(160, 41, 160, 9);
    imgview.hidden = YES;
    self.storyname.text =_store;
    _modelarray = [[NSArray alloc] initWithObjects:L(@"ProductConsult"),L(@"StoreDelivery"),L(@"InvoiceWarranty"),L(@"PayMessage"),L(@"PromotionPrivilege"),L(@"Others"),nil];
    zixuntypearr = [[NSArray alloc] initWithObjects:@"5",@"6",@"7",@"8",@"9",@"10", nil];

    [self.view addSubview:self.storyname];
    [self.view addSubview:self.consulttype];
    [self.view addSubview:self.textview];
    [self.view addSubview:imgview];
    [self.tablebackview addSubview:self.tableView];
    self.tableView.hidden = NO;
    // Do any additional setup after loading the view.
}

-(UIView *)tablebackview{
    if (!_tablebackview) {
        _tablebackview = [[UIView alloc] initWithFrame:CGRectMake(160, 50, 160, 240)];
        _tablebackview.backgroundColor = [UIColor whiteColor];
        _tablebackview.hidden = YES;
        _tablebackview.backgroundColor = [UIColor light_Gray_Color];
        [self.view addSubview:self.backBtn];
        [self.view addSubview:_tablebackview];
    }
    return _tablebackview;
}
-(void)submit{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121503"], nil]];
    if (_textview.text.length>150) {
        [self presentSheet:L(@"YouEnterCharactersDontExceed150") posY:50];
        return;
    }
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self displayOverFlowActivityView];
    [self.textview resignFirstResponder];
    SendPublishConsultDTO *dto = [[SendPublishConsultDTO alloc] init];
    dto.content = _textview.text;
    dto.cflag = _iscflag;
    dto.subcodeflag = _senddto;
    [self.httpsend SendpublishHttpRequest:dto];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UILabel *)storyname{
    if (!_storyname) {
        _storyname = [[UILabel alloc] initWithFrame:CGRectMake(5, 20, 200, 30)];
        _storyname.font = [UIFont systemFontOfSize:15];
        UIView *backview = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 320, 50)];
        backview.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:backview];
        arrowbtn = [[UIImageView   alloc] initWithFrame:CGRectMake(300, 33, 11, 6)];
        arrowbtn.image = [UIImage imageNamed:@"arrow_bottom_gray.png"];
        [self.view addSubview:arrowbtn];

        [backview addSubview:_storyname];
    }
    return _storyname;
}

-(UIButton *)consulttype{
    if (!_consulttype) {
        _consulttype = [[UIButton alloc] initWithFrame:CGRectMake(200, 20, 100, 30)];
        _consulttype.backgroundColor = [UIColor clearColor];
        [_consulttype setTitle:L(@"ProductConsult") forState:UIControlStateNormal];
        _consulttype.titleLabel.font = [UIFont systemFontOfSize:15];
        [_consulttype setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        [_consulttype addTarget:self action:@selector(typetableclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _consulttype;
}

-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] initWithFrame:self.view.bounds];
        _backBtn.backgroundColor = [UIColor clearColor];
        _backBtn.hidden = YES;
        [_backBtn addTarget:self action:@selector(typetableclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

-(PlaceholderTextView *)textview{
    if (!_textview) {
        
        UIView  *backtextview = [[UIView alloc] initWithFrame:CGRectMake(0, 65, 320, 160)];
        backtextview.backgroundColor = [UIColor whiteColor];
        _textview = [[PlaceholderTextView alloc] init];
        _textview.layer.borderWidth = 0.4;
        _textview.delegate = self;
        _textview.layer.borderColor = RGBCOLOR(232, 232, 232).CGColor;
        _textview.layer.masksToBounds = YES;
        
        _textview.textColor = [UIColor blackColor];
        _textview.font = [UIFont systemFontOfSize:15.0];
        _textview.backgroundColor = [UIColor clearColor];
        _textview.autocorrectionType = UITextAutocorrectionTypeNo;
        
        _textview.keyboardType = UIKeyboardTypeDefault;
        
        _textview.returnKeyType = UIReturnKeyDone;
        
        _textview.delegate = self;

        _textview.frame = CGRectMake(10, 80, 300, 140);
        _textview.backgroundColor = [UIColor clearColor];
        _textview.placeholder = L(@"YouEnterCharactersDontExceed150");
        [self.view addSubview:backtextview];
    }
    
    return _textview;
}


-(void)typetableclick{
    [_textview resignFirstResponder];
    [UIView beginAnimations:Nil context:nil];
    [UIView setAnimationDuration:0.3];
    arrowbtn.transform=CGAffineTransformMakeRotation(!istableshow?-M_PI:0);
    _tablebackview.hidden = istableshow;
    imgview.hidden = istableshow;
    [UIView commitAnimations];
    [self.backBtn setHidden:istableshow];
    istableshow=!istableshow;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
       return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *MoreResultIdentify = @"currentcell";
    
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:MoreResultIdentify];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MoreResultIdentify];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.contentView.backgroundColor = [UIColor whiteColor];
        
        }
        cell.textLabel.text = [_modelarray objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;

        return cell;
        
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _senddto.modeltype = [zixuntypearr objectAtIndex:indexPath.row];
    [_consulttype setTitle:[_modelarray objectAtIndex:indexPath.row] forState:UIControlStateNormal];

    [self typetableclick];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if (istableshow) {
        [self typetableclick];
    }
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    if (range.location>149 && ![text isEqualToString:@""])
    {
        [self presentSheet:L(@"YouEnterCharactersDontExceed150") posY:50];
        return  NO;
    }
    else
    {
        return YES;
    }
}
- (void)textViewDidChange:(UITextView *)textView{
    if (istableshow) {
        [self typetableclick];
    }
    if (_textview.text.length>0) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
//    if(_textview.text.length>150){
//        
//        [self presentSheet:@"您输入的字数不要超过150个字" posY:50];
//        
//    }
    else{
        self.navigationItem.rightBarButtonItem.enabled = NO;

    }
}

- (void)PublishConsultDelegate:(BOOL)issuccess error:(NSString *)error{
    [self removeOverFlowActivityView];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    if (issuccess) {
        BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
                                                        message:L(@"CommitConsultationSuccessWaitAdministratorToDeal")
                                                       delegate:nil
                                              cancelButtonTitle:L(@"Ok")
                                              otherButtonTitles:nil];
        [alert setCancelBlock:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alert show];
 
    }
    else{
        if (error == nil) {
            error =kNetUnreachErrorMsg;
        }
        [self presentSheet:error posY:50];
    }
}
@end
