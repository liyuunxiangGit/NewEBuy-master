//
//  WordsLeftView.m
//  TCWeiBoSDKDemo
//
//  Created by Cui Zhibo on 12-8-20.
//  Copyright (c) 2012年 bysft. All rights reserved.
//

#import "WordsLeftView.h"
#import <QuartzCore/QuartzCore.h>


@implementation WordsLeftView
@synthesize labelWord;
@synthesize wordsNum;

// 求取文本宽度
- (NSInteger)getTextWidth:(NSString *)textNumber {
	CGSize detailSize = [textNumber sizeWithFont:[UIFont systemFontOfSize:LabelFontSize] 
                               constrainedToSize:CGSizeMake(100, MAXFLOAT) 
                                   lineBreakMode:UILineBreakModeWordWrap];
	return detailSize.width;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
    if (self) {
        labelWord = [[UILabel alloc] init];
		labelWord.tag = WordsLeftBtnTag;
		labelWord.font= [UIFont systemFontOfSize: LabelFontSize];
		labelWord.backgroundColor = [UIColor clearColor];
		[self setWordsNum:wordsNum];
		[self addSubview:labelWord];
    }
    return self;
}




// 重载set方法
- (void)setWordsNum:(NSInteger)counts {
	wordsNum = counts;
	NSString *numString = [NSString stringWithFormat:@"%d", wordsNum];
	labelWord.font = [UIFont systemFontOfSize: LabelFontSize];
    labelWord.textColor = [UIColor redColor];
	NSInteger width = [self getTextWidth:numString];
	if (wordsNum == MaxInputWords ) {
		labelWord.frame = CGRectMake(self.frame.size.width - (width + 12) - SpatiumBetweenRightEdge, 0, width + 12, 17);
		[labelWord setText:numString];
		[labelWord setTextColor:[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0 ]];
		if (wordsNum >= 0) {
            [labelWord setTextColor:[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0 ]];
		}
		else {
            [labelWord setTextColor:[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0 ]];
		}
	}
	else {
		labelWord.frame = CGRectMake(self.frame.size.width - (width + 12) - SpatiumBetweenRightEdge - 7, 0, width + 12, 17);
		[labelWord setText:numString];
		if (wordsNum >= 0) {
            [labelWord setTextColor:[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0 ]];
		}
		else {
            [labelWord setTextColor:[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0 ]];
		}
	}
}


@end
