//
//  AssociationalWordDisplayController.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-22.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "AssociationalWordDisplayController.h"

@interface AssociationalWordDisplayController()
{
    UIViewController *__weak _contentController;
}

@property (nonatomic, strong) UITableView *displayTableView;
@property (nonatomic, weak) UIViewController *contentController;
@property (nonatomic, strong) NSArray *keywordList;

@end

/*********************************************************************/

@implementation AssociationalWordDisplayController

@synthesize service = _service;
@synthesize delegate = _delegate;
@synthesize displayTableView = _displayTableView;

@synthesize tableTopPosY = _tableTopPosY;
@synthesize distanceToTop = _distanceToTop;
@synthesize wordType = _wordType;
@synthesize contentController = _contentController;
@synthesize keywordList = _keywordList;

- (void)dealloc {
    SERVICE_RELEASE_SAFELY(_service);
    TT_RELEASE_SAFELY(_displayTableView);
    TT_RELEASE_SAFELY(_keywordList);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithContentController:(UIViewController *)controller
{
    self = [super init];
    if (self) {
//        _tableTopPosY = 75;
        _tableTopPosY = 191; //add by wangjiaxing 20130517
        _distanceToTop = 95-25;
        _contentController = controller;
        _wordType = AssociationalWordMixType;
        self.displayTableView.frame = CGRectMake(0, _tableTopPosY, 320, 336);
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        
#ifdef __IPHONE_5_0
        
        float version = [[[UIDevice currentDevice] systemVersion] floatValue];
        
        if (version >= 5.0)
        {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
        }
#endif
    }
    return self;
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    CGFloat height = screenHeight - _distanceToTop - keyboardRect.size.height;
    
    if (_tableTopPosY != 50) {
        self.displayTableView.frame = CGRectMake(0, _tableTopPosY, 320, height);
        
        [UIView animateWithDuration:0.5 animations:^{
            _tableTopPosY = 50;
            self.displayTableView.frame = CGRectMake(0, _tableTopPosY, 320, height);
        }];
    }
    else
    {
        self.displayTableView.frame = CGRectMake(0, _tableTopPosY, 320, height);
    }
}

- (UITableView *)displayTableView
{
    if(!_displayTableView){
		
		_displayTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                         style:UITableViewStylePlain];    
		
		[_displayTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		[_displayTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		_displayTableView.scrollEnabled = YES;
		
		_displayTableView.userInteractionEnabled = YES;
		
		_displayTableView.delegate =self;
		
		_displayTableView.dataSource =self;
		
//		_displayTableView.backgroundColor = RGBCOLOR(238, 235, 215);
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kNavControllerBackgroundImage]];
        imageView.frame = _displayTableView.frame;
        imageView.userInteractionEnabled = YES;
        _displayTableView.backgroundView = imageView;
	}
	
	return _displayTableView;
}

//- (void)displayView
//{
//    if (self.displayTableView.superview == nil) {
//        [self.contentController.view addSubview:self.displayTableView];
//        [self.contentController.view bringSubviewToFront:self.displayTableView];
//    }
//}

-(void)displayView:(NSArray *)historyKeywords
{
    self.keywordList=historyKeywords;
    if (self.displayTableView.superview == nil) {
        [UIView animateWithDuration:0.5 animations:^{
            _tableTopPosY = 191;
            [self.contentController.view addSubview:self.displayTableView];
            [self.contentController.view bringSubviewToFront:self.displayTableView];
        }];
        
    }
    [self.displayTableView reloadData];
}

- (void)removeView
{
    if (self.displayTableView.superview) {
        [self.displayTableView removeFromSuperview];
    }
}

#pragma mark -
#pragma mark table view delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.keywordList?[self.keywordList count]:0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"keywordsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.textLabel.textColor = [UIColor colorWithRGBHex:0x444444];
//        cell.detailTextLabel.font = [UIFont systemFontOfSize:16.0];
//        cell.detailTextLabel.textColor = RGBCOLOR(53, 79, 138);
        
        UIImageView *cellSep = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new_home_sep.png"]];
        cellSep.frame = CGRectMake(0, 29, 320, 1);
        [cell.contentView addSubview:cellSep];
    }
    NSString *keyword = [NSString stringWithFormat:@"    %@",[self.keywordList objectAtIndex:indexPath.row] ];
    cell.textLabel.text = keyword;
    cell.textLabel.textColor=[UIColor colorWithRGBHex:0x444444];
    
    /*需求更改不需要展示个数，因为不准*/
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"约%@个商品", dto.keyExtend];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *keyword = [self.keywordList objectAtIndex:indexPath.row];
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectAssociationalWord:)]) {
        [_delegate didSelectAssociationalWord:keyword];
    }
}

#pragma mark -
#pragma mark service and delegate

- (AssociationalWordService *)service
{
    if (!_service) {
        _service = [[AssociationalWordService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

- (void)refreshViewWithKeyword:(NSString *)keyword
{
    self.keywordList = nil;
    [self.displayTableView reloadData];
    
    if (keyword == nil || [keyword isEmptyOrWhitespace]) {
        return;
    }
    
    [self.service beginGetAssociationalWordWithKeyword:keyword associationalWordType:self.wordType];
}

- (void)getAssociationalWordsCompletedWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    if (isSuccess) {
        self.keywordList = self.service.wordList;
        [self.displayTableView reloadData];
    }
}

@end
