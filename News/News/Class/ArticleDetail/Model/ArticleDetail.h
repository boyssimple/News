//
//  ArticleDetail.h
//  News
//
//  Created by zhouMR on 2017/3/22.
//  Copyright © 2017年 luowei. All rights reserved.
//

#import "ApiObject.h"
@interface ArticleDetailDataImg:NSObject
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, strong) NSString *uri;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, strong) NSArray *url_list;
- (void)parseObj:(NSDictionary*)obj;
@end

@interface ArticleDetailData:NSObject
@property (nonatomic, strong) NSString *media_user_id;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSMutableArray *imglist;
- (void)parseObj:(NSDictionary*)obj;
@end

@interface ArticleDetail : ApiObject
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) ArticleDetailData *data;
@end
