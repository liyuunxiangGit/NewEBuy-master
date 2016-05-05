//
//  NewManualInputViewController.h
//  SuningEBuy
//
//  Created by xingxianping on 13-8-3.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"

@protocol ManualInputDelegate <NSObject>

- (void)shouldBeginSearchIsbnWithISBN:(NSString *)isbn;

@end

@interface NewManualInputViewController : CommonViewController
<UITextFieldDelegate>
{
    id<ManualInputDelegate>     __weak delegate_;
}

@property (nonatomic, weak) id<ManualInputDelegate> delegate;

@property (nonatomic, strong) UITextField *seachFied;

@property (nonatomic, strong) UIImageView *searchBg;

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UIViewController *contentViewController;

- (id)initWithContentController:(UIViewController *)contentController;

@end
