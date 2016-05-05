//
//  NBHomeMenu.m
//  suningNearby
//
//  Created by suning on 14-8-1.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import "NBHomeMenu.h"

@interface NBHomeMenu ()  <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView    *tableView0;
@end

@implementation NBHomeMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.tableView0 = [[UITableView alloc] initWithFrame:CGRectMake(frame.size.width-120.0f,
                                                                        .0f,
                                                                        120.0f,
                                                                        .0f)
                                                       style:UITableViewStylePlain];
        _tableView0.dataSource = self;
        _tableView0.delegate   = self;
        _tableView0.scrollEnabled = NO;
        if ([_tableView0 respondsToSelector:@selector(setSeparatorInset:)]) {
            _tableView0.separatorInset = UIEdgeInsetsMake(.0f,4.0f,.0f,4.0f);
        }
        [self addSubview:_tableView0];
        
        self.backgroundColor = [UIColor colorWithWhite:.1f alpha:.1f];
    }
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _channels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"NBHomeMenuTableViewCell_identify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:18.0f];
        cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:85.0f/255.0f
                                                                      green:210.0f/255.0f
                                                                       blue:204.0f/255.0f
                                                                      alpha:1.0f];
    }
    
    cell.textLabel.text = EncodeStringFromDic(_channels[indexPath.row],@"name");
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (nil != _delegate
        && [_delegate respondsToSelector:@selector(delegate_NBHomeMenu_selected:)]) {
        self.hidden = YES;
        [_delegate delegate_NBHomeMenu_selected:_channels[indexPath.row]];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesEnded:touches withEvent:event];
    
    UITouch *touch = touches.anyObject;
    if ([touch.view isEqual:self]) {
        self.hidden = YES;
    }
}

- (void)setChannels:(NSArray *)channels {
    _channels = channels;
    if (nil != _channels) {
        CGRect frame = self.frame;
        self.tableView0.frame = CGRectMake(frame.size.width-120.0f,
                                      .0f,
                                      120.0f,
                                      _channels.count * 44.0f);
    }
}

@end
