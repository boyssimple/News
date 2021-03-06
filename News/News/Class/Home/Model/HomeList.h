//
//  HomeList.h
//  News
//
//  Created by zhouMR on 2017/3/17.
//  Copyright © 2017年 luowei. All rights reserved.
//

#import "ApiObject.h"
@interface HomeListImg:NSObject
@property (nonatomic, strong) NSString *url;
- (void)parseObj:(NSDictionary*)obj;
@end

@interface HomeListContent:NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *tag_id;
@property (nonatomic, strong) NSString *artcle_url;
@property (nonatomic, strong) NSString *read_count;
@property (nonatomic, strong) NSString *media_name;
@property (nonatomic, strong) NSMutableArray *image_list;
@property (nonatomic, strong) NSMutableArray *url_list;
@property (nonatomic, assign) NSInteger like_count;
@property (nonatomic, strong) NSString *detail_video_large_image;
@property (nonatomic, assign) BOOL has_video;

- (void)parseObj:(NSDictionary*)obj;
@end

@interface HomeListData:NSObject
@property (nonatomic, strong) HomeListContent *content;
@property (nonatomic, strong) NSString *code;
- (void)parseObj:(NSDictionary*)obj;
@end

@interface HomeList : ApiObject
@property (nonatomic, strong) NSMutableArray *datas;
@end
