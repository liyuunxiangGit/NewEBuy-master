//
//  WordsLeftView.h
//  TCWeiBoSDKDemo
//
//  Created by Cui Zhibo on 12-8-20.
//  Copyright (c) 2012年 bysft. All rights reserved.
//

#import <UIKit/UIKit.h>
// 定义撰写界面字符最大个数
#define MaxInputWords							140

// 控件标记
#define WordsLeftBtnTag				500
#define	DeleteBtnTag				(WordsLeftBtnTag + 1)
// 标签字体大小
#define LabelFontSize				18.0f
// 标签离右边间距
#define SpatiumBetweenRightEdge		5.0f


@interface WordsLeftView : UIView {
	UILabel					*labelWord;     // 字数显示标签
	NSInteger				wordsNum;		// 剩余字数
}

@property (nonatomic, strong) UILabel					*labelWord;
@property (nonatomic, assign) NSInteger					wordsNum;
@end

