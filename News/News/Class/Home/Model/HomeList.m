//
//  HomeList.m
//  News
//
//  Created by zhouMR on 2017/3/17.
//  Copyright © 2017年 luowei. All rights reserved.
//

#import "HomeList.h"

@implementation HomeListImg

- (void)parseObj:(NSDictionary*)obj{
    self.url = [obj stringValueForKey:@"url" default:@""];
}

@end

@implementation HomeListContent
- (instancetype)init{
    self = [super init];
    if (self) {
        _image_list = [NSMutableArray array];
    }
    return self;
}

- (void)parseObj:(NSDictionary*)obj{
    if ([obj isKindOfClass:[NSString class]]) {
        NSData* xmlData = [(NSString*)obj dataUsingEncoding:NSUTF8StringEncoding];
        obj = [[NetRequestTool shared] parseJson:xmlData];
    }
    self.title = [obj stringValueForKey:@"title" default:@""];
    self.artcle_url = [obj stringValueForKey:@"url" default:@""];
    self.read_count = [obj stringValueForKey:@"read_count" default:@""];
    self.media_name = [obj stringValueForKey:@"media_name" default:@""];
    [self.image_list removeAllObjects];
    NSArray *arrays = [obj objectForKey:@"image_list"];
    for (NSDictionary *dic in arrays) {
        HomeListImg *img = [[HomeListImg alloc]init];
        [img parseObj:dic];
        [self.image_list addObject:img];
    }
}

@end

@implementation HomeListData

- (void)parseObj:(NSDictionary*)obj{
    HomeListContent *cnt = [[HomeListContent alloc]init];
    [cnt parseObj:[obj objectForKey:@"content"]];
    self.content = cnt;
    
    self.code = [obj objectForKey:@"code"];
}

@end

@implementation HomeList

- (instancetype)init{
    self = [super init];
    if (self) {
        _datas = [NSMutableArray array];
        [self.args setObject:@"WIFI" forKey:@"access"];
        [self.args setObject:@"news_article" forKey:@"app_name"];
        [self.args setObject:@"App" forKey:@"channel"];
    }
    return self;
}

- (NSString*)netRequstUrl{
    return NetURL_HomeList;
}

- (NSString*)cacheItemIdentifier{
    return [NSString stringWithFormat:@"page"];
}

- (void)parseObj:(NSDictionary*)obj{
    [super parseObj:obj];
    [self.datas removeAllObjects];
    NSArray *arrays = [obj objectForKey:@"data"];
    for (NSDictionary *dic in arrays) {
        HomeListData *data = [[HomeListData alloc]init];
        [data parseObj:dic];
        [self.datas addObject:data];
    }
}
@end
