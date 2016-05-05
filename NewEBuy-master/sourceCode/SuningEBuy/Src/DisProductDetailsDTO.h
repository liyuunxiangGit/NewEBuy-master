//
//  DisProductDetailsDTO.h
//  SuningEBuy
//
//  Created by xy ma on 12-2-22.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHttpDTO.h"
#import "AppConstant.h"
@interface DisProductDetailsDTO : BaseHttpDTO{
    
    NSNumber *articleId_;
	NSNumber *authorId_;
	NSNumber *answerType_;
    NSString *title_;
	NSString *createTime_;
	NSString *content_;    
    NSNumber *qaType_;
	NSString *nickName_;
    
}
//"content": "高低杠",
//"createTime": "2012-02-15 09:48:03",
//"title": "",
//"nickName": null,
//"qaType": 1,
//"answerType": 0,
//"articleId": 23164,
//"authorId": 33012344785

@property (nonatomic, copy) NSNumber *articleId;
@property (nonatomic, copy) NSNumber *authorId;
@property (nonatomic, copy) NSNumber *answerType;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSNumber *qaType;
@property (nonatomic, copy) NSString *nickName;


@end
