//
//  OSEmoticonView.m
//  SuningEBuy
//
//  Created by  liukun on 13-12-2.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "OSEmoticonView.h"
#import "OSMessageLabel.h"

@implementation OSEmoticonView

@synthesize delegate = _delegate;

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 320, 216);
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark ----------------------------- public method

- (void)showEmoticonView
{
    _isShowEmoticon = YES;
    self.emoticonScrollView.hidden = NO;
//    self.sendButton.hidden = NO;
    self.pageControl.hidden = NO;
    _quickAskView.hidden = YES;
}

- (void)showQuickAskView
{
    _isShowEmoticon = NO;
    self.quickAskView.hidden = NO;
//    _sendButton.hidden = YES;
    _emoticonScrollView.hidden = YES;
    _pageControl.hidden = YES;
}

- (BOOL)isShowEmoticon
{
    return _isShowEmoticon;
}

- (void)setQuickAskArray:(NSArray *)quickAskArray
{
    if (_quickAskArray != quickAskArray)
    {
        _quickAskArray = quickAskArray;
        [_quickAskView reloadData];
    }
}

#pragma mark ----------------------------- subviews

- (UITableView *)quickAskView
{
	if(!_quickAskView){
		_quickAskView = [[UITableView alloc] initWithFrame:self.bounds
                                                     style:UITableViewStylePlain];
		[_quickAskView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
		[_quickAskView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		_quickAskView.scrollEnabled = YES;
		_quickAskView.userInteractionEnabled = YES;
		_quickAskView.delegate = self;
		_quickAskView.dataSource = self;
		_quickAskView.backgroundColor = [UIColor clearColor];
        _quickAskView.backgroundView = nil;
        [self addSubview:_quickAskView];
	}
	return _quickAskView;
}

- (UIScrollView *)emoticonScrollView
{
    if (!_emoticonScrollView)
    {
        _emoticonScrollView = [[UIScrollView alloc] init];
        _emoticonScrollView.backgroundColor = [UIColor clearColor];
        _emoticonScrollView.delegate = self;
        _emoticonScrollView.frame = self.bounds;
        _emoticonScrollView.pagingEnabled = YES;
        _emoticonScrollView.showsHorizontalScrollIndicator = NO;
        
        NSArray *emoticonArray = getEmoticonList();
        
        int line = 0, row = 0, page = 0;
        float w = 80, h = 65, pageWidth = 320;
        for (int i = 0; i < [emoticonArray count]; i++)
        {
            NSString *value = [emoticonArray objectAtIndex:i];
            if (line > 3)
            {
                row++;
                line = 0;
            }
            
            if (row > 2)
            {
                page++;
                line=0;
                row=0;
            }
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            //            button.backgroundColor = RGBCOLOR(238, 238, 238);
            //            button.layer.borderColor = RGBCOLOR(222, 222, 222).CGColor;
            //            button.layer.borderWidth = 0.5;
            button.frame = CGRectMake(line*w + page*pageWidth, h*row, w, h);
            line++;
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"emoticon.bundle/%@_png.png", value]];
            [button setImage:image forState:UIControlStateNormal];
            button.tag = i;
            [button addTarget:self action:@selector(touchEmoticon:) forControlEvents:UIControlEventTouchUpInside];
            [_emoticonScrollView addSubview:button];
        }
        
        _emoticonScrollView.contentSize = CGSizeMake(pageWidth*(page+1), _emoticonScrollView.height);
        [self addSubview:_emoticonScrollView];
        
        self.pageControl.frame = CGRectMake(0, h*3, 320, 20);
        self.pageControl.numberOfPages = page+1;
        self.pageControl.currentPage = 0;
    }
    return _emoticonScrollView;
}

- (UIButton *)sendButton
{
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat width = 71, height = 35;
        _sendButton.frame = CGRectMake(self.width-width-13, self.height-height-6, width, height);
        [_sendButton setTitle:L(@"OnlineService_Send") forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendButton setBackgroundImage:[UIImage streImageNamed:@"os_keyboard_send.png"]
                               forState:UIControlStateNormal];
        [_sendButton addTarget:self
                        action:@selector(doSend:)
              forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sendButton];
    }
    return _sendButton;
}

- (MyPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[MyPageControl alloc] init];
        _pageControl.frame = CGRectMake(0, 140, 320, 20);
        _pageControl.imageNormal = [UIImage imageNamed:@"os_pagecontrol_normal.png"];
        _pageControl.imageSelected = [UIImage imageNamed:@"os_pagecontrol_select.png"];
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

#pragma mark ----------------------------- scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int currentPage = self.pageControl.currentPage;
    if (currentPage < self.pageControl.numberOfPages-1 &&
        scrollView.contentOffset.x >= 320*(currentPage+1))
    {
        self.pageControl.currentPage = currentPage+1;
    }
    else if (currentPage > 0 && scrollView.contentOffset.x <= 320*(currentPage-1))
    {
        self.pageControl.currentPage = currentPage-1;
    }
}

#pragma mark ----------------------------- actions

- (void)touchEmoticon:(UIButton *)button
{
    NSArray *emoticonArr = getEmoticonList();
    NSString *key = [emoticonArr safeObjectAtIndex:[button tag]];
    key = [key stringByAppendingString:@"_png"];
    
    if (key && [_delegate respondsToSelector:@selector(emoticonView:didChooseEmoticon:)])
    {
        [_delegate emoticonView:self didChooseEmoticon:key];
    }
}

- (void)doSend:(id)sender
{
    if ([_delegate respondsToSelector:@selector(emoticonViewSendButtonClicked:)])
    {
        [_delegate emoticonViewSendButtonClicked:self];
    }
}


#pragma mark ----------------------------- tableView dataSource and delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.quickAskArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.textColor = [UIColor darkTextColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    }
    
    cell.textLabel.text = [self.quickAskArray safeObjectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *text = [self.quickAskArray safeObjectAtIndex:indexPath.row];
    
    if ([_delegate respondsToSelector:@selector(emoticonView:didChooseQuickAskWord:)])
    {
        [_delegate emoticonView:self didChooseQuickAskWord:text];
    }
}


@end
