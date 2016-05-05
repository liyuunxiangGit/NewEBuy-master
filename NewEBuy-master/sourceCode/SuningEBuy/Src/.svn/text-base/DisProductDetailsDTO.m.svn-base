//
//  DisProductDetailsDTO.m
//  SuningEBuy
//
//  Created by xy ma on 12-2-22.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "DisProductDetailsDTO.h"

@implementation DisProductDetailsDTO

@synthesize articleId = articleId_;
@synthesize authorId = authorId_;
@synthesize answerType = answerType_;
@synthesize title = title_;
@synthesize createTime = createTime_;
@synthesize content = content_;
@synthesize qaType = qaType_;
@synthesize nickName = nickName_;
//
////晒单id，作者id，回复类型，标题，发布时间，晒单正文，是否管理员回，作者昵称
//#define kHttpArticleId                              @"articleId"
//#define kHttpAuthorId                               @"authorId"
//#define kHttpAnswerType                             @"answerType"
//#define kHttpTitle                                  @"title"
//#define kHttpCreateTime                             @"createTime"
//#define kHttpContent                                @"content"
//#define kHttpQaType                                 @"qaType"
//#define kHttpNickName                               @"nickName"


-(void)encodeFromDictionary:(NSDictionary *)dic{
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
	
//	self.articleId              = [dic objectForKey:kHttpArticleId];	
//	self.authorId               = [dic objectForKey:kHttpAuthorId];
//	self.answerType             = [dic objectForKey:kHttpAnswerType];
//	self.title                  = [dic objectForKey:kHttpTitle];
//	self.createTime             = [dic objectForKey:kHttpCreateTime];
//	self.content                = [dic objectForKey:kHttpContent];
//	self.qaType                 = [dic objectForKey:kHttpQaType];
//	self.nickName               = [dic objectForKey:kHttpNickName];
    if(NotNilAndNull([dic objectForKey:kHttpArticleId])){
        self.articleId=[dic objectForKey:kHttpArticleId];
    }
    if(NotNilAndNull([dic objectForKey:kHttpAuthorId])){
        self.authorId=[dic objectForKey:kHttpAuthorId];
    }
    if(NotNilAndNull([dic objectForKey:kHttpAnswerType])){
        self.answerType=[dic objectForKey:kHttpAnswerType];
    }
    if(NotNilAndNull([dic objectForKey:kHttpTitle])){
        self.title=[dic objectForKey:kHttpTitle];
    }
    if(NotNilAndNull([dic objectForKey:kHttpCreateTime])){
        self.createTime=[dic objectForKey:kHttpCreateTime];
    }
    if(NotNilAndNull([dic objectForKey:kHttpContent])){
        self.content=[dic objectForKey:kHttpContent];
    }
    if(NotNilAndNull([dic objectForKey:kHttpQaType])){
        self.qaType=[dic objectForKey:kHttpQaType];
    }
    if(NotNilAndNull([dic objectForKey:kHttpNickName])){
        
        if ([[dic objectForKey:kHttpNickName] eq:@"佚名"]) {
            self.nickName = L(@"Display Order No name");
        }else{
            self.nickName=[dic objectForKey:kHttpNickName];
        }
        
    }
}


@end
