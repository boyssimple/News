//
//  ArticleDetail.m
//  News
//
//  Created by zhouMR on 2017/3/22.
//  Copyright © 2017年 luowei. All rights reserved.
//

#import "ArticleDetail.h"

@implementation ArticleDetailDataImg
- (void)parseObj:(NSDictionary*)obj{
    self.url = [obj stringValueForKey:@"url" default:@""];
    self.width = [obj integerValueForKey:@"width" default:0];
    self.url_list = [obj objectForKey:@"url_list"];
    self.uri = [obj stringValueForKey:@"uri" default:@""];
    self.height = [obj integerValueForKey:@"height" default:0];
}
@end

@implementation ArticleDetailData

- (instancetype)init{
    self = [super init];
    if (self) {
        _imglist = [NSMutableArray array];
    }
    return self;
}

- (void)parseObj:(NSDictionary*)obj{
    [self.imglist removeAllObjects];
    self.media_user_id = [obj stringValueForKey:@"media_user_id" default:@""];
    self.content = [obj stringValueForKey:@"content" default:@""];
    NSArray *imgs = [obj objectForKey:@"image_detail"];
    for (NSDictionary *dic in imgs) {
        ArticleDetailDataImg *img = [[ArticleDetailDataImg alloc]init];
        [img parseObj:dic];
        [self.imglist addObject:img];
    }
}
@end

@implementation ArticleDetail

- (instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSString*)netRequstUrl{
    return self.url;
}

- (void)setUrl:(NSString *)url{
    _url = url;
}

- (NSString*)cacheItemIdentifier{
    return [NSString stringWithFormat:@"page"];
}

- (void)parseObj:(NSDictionary*)obj{
    [super parseObj:obj];
    ArticleDetailData *data = [[ArticleDetailData alloc]init];
    [data parseObj:[obj objectForKey:@"data"]];
    self.data = data;
}

@end
