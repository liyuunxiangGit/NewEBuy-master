//
//  NBDaShangView.m
//  suningNearby
//
//  Created by suning on 14-8-4.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import "NBDaShangView.h"
#import "UIImageView+WebCache.h"


@interface NBDaShangTableCell : UITableViewCell
@property (nonatomic,strong) UILabel     *label1;
@property (nonatomic,strong) UIImageView *iconView2;
@property (nonatomic,strong) UILabel     *label2;

@property (nonatomic,strong) NSDictionary *item;

@end

@implementation NBDaShangTableCell

// cell height 64.0f

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGSize sz = self.frame.size;
        
        self.label1 = [[UILabel alloc] initWithFrame:CGRectMake(.0f,20.0f,70.0f,44.0f)];
        _label1.backgroundColor = [UIColor colorWithRed:238.0f/255.0f
                                                  green:238.0f/255.0f
                                                   blue:238.0f/255.0f
                                                  alpha:1.0f];
        _label1.textAlignment = NSTextAlignmentCenter;
        _label1.textColor = [UIColor grayColor];
        _label1.backgroundColor = [UIColor clearColor];
        _label1.font = [UIFont systemFontOfSize:17.0f];
        [_label1 setText:L(@"FiveCloudDiamond")];
        [self.contentView addSubview:_label1];
        
        self.iconView2 = [[UIImageView alloc] initWithFrame:CGRectMake(86.0f,26.0f,32.0f,32.0f)];
        //_iconView2.image = [UIImage imageNamed:@"havenosign"];
        [self.contentView addSubview:_iconView2];
        
        self.label2 = [[UILabel alloc] initWithFrame:CGRectMake(118.0f+2.0f,20.0f,sz.width-120.0f-80.0f,44.0f)];
        _label2.backgroundColor = [UIColor colorWithRed:238.0f/255.0f
                                                  green:238.0f/255.0f
                                                   blue:238.0f/255.0f
                                                  alpha:1.0f];
        _label2.backgroundColor = [UIColor clearColor];
        _label2.highlightedTextColor = [UIColor whiteColor];
        _label2.textColor = [UIColor grayColor];
        _label2.font = [UIFont systemFontOfSize:14.0f];
        _label2.numberOfLines = 2;
        [_label2 setText:L(@"LCThankSeeMe")];
        [self.contentView addSubview:_label2];
        
        UIImageView *norlView = [[UIImageView alloc] init];
        norlView.image = [UIImage imageNamed:@"nb_dashang_nl"];
        self.backgroundView = norlView;
        
        UIImageView *selView = [[UIImageView alloc] init];
        selView.image = [UIImage imageNamed:@"nb_dashang_select"];
        self.selectedBackgroundView = selView;
    }
    return self;
}

- (void)setItem:(NSDictionary *)item {
    _item = item;
    
    if (nil != _item) {
        
        NSDictionary *one = EncodeDicFromDic(_item, @"value");
        
        NSString *name = EncodeStringFromDic(one, @"name");
        
        // 名字
        if (nil == name
            || name.length == 0) {
            // name = EncodeStringFromDic(u, @"id");
            name = L(@"LCUser");
        }
        _label1.text = name;
        
        _label2.text = EncodeStringFromDic(one, @"remark");
        
        _iconView2.image = [UIImage imageNamed:EncodeStringFromDic(_item,@"url")];
    
//        [_iconView2 sd_setImageWithURL:[NSURL URLWithString:EncodeStringFromDic(_item,@"faceUrl")]
//                     placeholderImage:nil];
    }
}

@end

#import "NBYSHttpService.h"
#import "NBCCSharedData.h"

@interface NBDaShangView () <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,NBYSHttpServiceDelegate>
@property (nonatomic,strong) UIScrollView *iScrollView;
@property (nonatomic,strong) UIButton     *closeButton;
@property (nonatomic,strong) UIButton     *confirmButton;
@property (nonatomic,strong) UITextField  *textField0;

@property (nonatomic,strong) UITableView    *tableView0;
@property (nonatomic,strong) NSArray        *sourceArray;

@property (nonatomic,strong) NBYSHttpService *httpService;

@property (nonatomic,strong) NSDictionary    *selectedItem; //default nil

@end

@implementation NBDaShangView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithWhite:.3f alpha:.3f];
        self.iScrollView     = [[UIScrollView alloc] initWithFrame:CGRectMake(30.0f,
                                                                              .0f,
                                                                              frame.size.width-60.0f,
                                                                              300.0f)];
        _iScrollView.center = self.center;
        _iScrollView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_iScrollView];
        
        
        CGRect f = _iScrollView.frame;
        self.closeButton = [[UIButton alloc] initWithFrame:CGRectMake(f.origin.x+f.size.width-30.0f,
                                                                      f.origin.y-14.0f,
                                                                      28.0f,
                                                                      28.0f)];
        [_closeButton addTarget:self action:@selector(on_closeButton_clicked) forControlEvents:UIControlEventTouchUpInside];
        [_closeButton setImage:[UIImage imageNamed:@"nb_close"] forState:UIControlStateNormal];
        [self addSubview:_closeButton];
        
        self.confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(30.0f,
                                                                        _iScrollView.frame.origin.y+_iScrollView.frame.size.height,
                                                                        _iScrollView.frame.size.width,
                                                                        40.0f)];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmButton setTitle:L(@"BTAward") forState:UIControlStateNormal];
        [_confirmButton setBackgroundImage:[UIImage imageNamed:@"nb_fixedColor2x36_green.png"]
                                  forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(on_confirmButton_clicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_confirmButton];
        
        self.textField0 = [[UITextField alloc] initWithFrame:CGRectMake(9.0f,f.size.height-44.0f,f.size.width-18.0f,30.0f)];
        _textField0.borderStyle = UITextBorderStyleNone;
        _textField0.backgroundColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f  blue:238.0f/255.0f  alpha:1.0f];
        _textField0.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField0.font = [UIFont systemFontOfSize:15.0f];
        _textField0.returnKeyType = UIReturnKeyDone;
        _textField0.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [_textField0 setPlaceholder:L(@"IInsertSpeak")];
        _textField0.delegate = self;
        [_iScrollView addSubview:_textField0];
        
        self.tableView0 = [[UITableView alloc] initWithFrame:CGRectMake(9.0f,
                                                                        20.0f,
                                                                        f.size.width-18.0f,
                                                                        f.size.height-59.0f-14.0f) style:UITableViewStylePlain];
        _tableView0.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView0.delegate   = self;
        _tableView0.dataSource = self;
        _tableView0.showsVerticalScrollIndicator = NO;
        [_iScrollView addSubview:_tableView0];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardFrameChanged:)
                                                     name:UIKeyboardWillChangeFrameNotification
                                                   object:nil];
        
        if (nil == [NBCCSharedData shared].rewardsConfig) {
            [self.httpService requestGetRewardScoreConfList];
        }else {
            self.sourceArray = [NBCCSharedData shared].rewardsConfig;
        }
    }
    return self;
}

+ (NBDaShangView *)showDaShangViewAtWindow {
    
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
    CGSize    sz  = win.bounds.size;
    
    NBDaShangView *v = [[NBDaShangView alloc] initWithFrame:CGRectMake(.0f,.0f,sz.width,sz.height)];
    [win addSubview:v];
    
    return v;
}

- (void)on_closeButton_clicked {
    [self removeFromSuperview];
}


- (void)on_confirmButton_clicked {
    
    if (nil != _selectedBlock
        && nil != _selectedItem) {
        _selectedBlock(_selectedItem[@"value"],_textField0.text);
    }
    [self removeFromSuperview];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    UITouch *th = touches.anyObject;
    if (!_textField0.isFirstResponder
        && [th.view isEqual:self]) {
        [self removeFromSuperview];
    }
}

#pragma mark - UITextFieldDelegate

- (void)keyboardFrameChanged:(NSNotification *)notif
{
    if (_textField0.isFirstResponder) {
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    [_iScrollView setContentOffset:CGPointMake(.0f,abs((self.frame.size.height-300.0f)/2-keyboardSize.height)) animated:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [_iScrollView setContentOffset:CGPointZero animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _sourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identify = @"NBDaShangTableCell_identify";
    NBDaShangTableCell *cell = (NBDaShangTableCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    if (nil == cell) {
        cell = [[NBDaShangTableCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:identify];
    }
    
    cell.item = _sourceArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.selectedItem = _sourceArray[indexPath.row];
}

#pragma mark - http 

//requestGetRewardScoreList

#pragma mark - http service

- (NBYSHttpService *)httpService {
    
    if (nil == _httpService) {
        _httpService = [[NBYSHttpService alloc] init];
        _httpService.delegate = self;
    }
    return _httpService;
}

- (void)delegate_nbys_httpService_result:(NSDictionary *)result
                                 usrInfo:(id)userInfo
                                   error:(NSError *)error
                                     cmd:(E_CMDCODE)cmd {
    if (nil == error) {
        
        if (CC_NBYGetScoreConfList == cmd) {
          
            //self.sourceArray = EncodeArrayFromDic(result,@"data");
            NSMutableArray *compArr = [NSMutableArray array];
            NSArray *arr = EncodeArrayFromDic(result,@"data");
            for (int i = 0; i < arr.count && i < 4; ++i) {
                NSDictionary *one = arr[i];
                [compArr addObject:@{@"value":one,@"url":[NSString stringWithFormat:@"nby_reward0%d",(i+1)]}];
            }
            self.sourceArray = compArr;
            
            [NBCCSharedData shared].rewardsConfig = _sourceArray;
            [self.tableView0 reloadData];
        }
        
    }else {
        [self.parentCtrler removeOverFlowActivityView];
        [self.parentCtrler presentSheet:error.localizedDescription];
    }
}

@end