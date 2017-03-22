//
//  VCArticleDetail.m
//  News
//
//  Created by zhouMR on 2017/3/17.
//  Copyright © 2017年 luowei. All rights reserved.
//

#import "VCArticleDetail.h"
#import "ArticleDetail.h"

@interface VCArticleDetail ()
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) ArticleDetail *detail;
@end

@implementation VCArticleDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT-NAV_STATUS_HEIGHT)];
    _webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_webView];
//    if ([self.url isNotBlank]) {
//        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT)];
//        [self.view addSubview:_webView];
//        NSURL *ur = [[NSURL alloc]initWithString:self.url];
//        [_webView loadRequest:[[NSURLRequest alloc]initWithURL:ur]];
//    }
    [self loadData];
}

#pragma mark - Event
- (void)loadData{
    __weak typeof(self) safeSelf = self;
    [[NetRequestToolExt shared]requestPost:self.detail withSuccess:^(ApiObject *m) {
        ArticleDetail *t = (ArticleDetail*)m;
        NSMutableString *str = [safeSelf handleContent:[t.data.content mutableCopy]];
        [safeSelf.webView loadHTMLString:[self getHtmlString:str] baseURL:nil];
    } withFailure:^(ApiObject *m) {
        
    }];
}


- (NSString *)getHtmlString:(NSString *)content
{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    
//    [html appendString:@"<meta name=\"viewport\" content=\"target-densitydpi=device-dpi,width=640,user-scalable=no\"/>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"style.css" withExtension:nil]];
    [html appendFormat:@"<script type=\"text/javascript\" src=\"%@\"></script>",[[NSBundle mainBundle] URLForResource:@"content.js" withExtension:nil]];
    [html appendString:@"</head>"];
    
    [html appendString:@"<body style=\"background:#ffffff\">"];
    [html appendString:content];
    [html appendString:@"</body>"];
    [html appendString:@"</html>"];
    
    return html;
}

- (NSMutableString*)handleContent:(NSMutableString*)content{
    NSInteger i = 0;
    for(ArticleDetailDataImg *img in self.detail.data.imglist){
        NSMutableString *html = [NSMutableString string];
        [html appendString:@"bytedance://large_image?url="];
        [html appendString:img.url];
        [html appendString:[NSString stringWithFormat:@"&index=%zi",i++]];
        
        NSLog(@"要去你的的:%@",html);
        NSUInteger start = [content rangeOfString:[NSString stringWithFormat:@"<a class=\"image\"  href="] options:NSCaseInsensitiveSearch].location;
        NSRange end = [content rangeOfString:@"></a>" options:NSCaseInsensitiveSearch];
        NSUInteger length = (end.location+end.length) - start;
        
        
        CGFloat width = img.width;
        CGFloat height = img.height;
        // 判断是否超过最大宽度
        CGFloat maxWidth = DEVICEWIDTH * 0.96;
        if (width > maxWidth) {
            height = maxWidth / width * height;
            width = maxWidth;
        }
        NSString *imgcontent = [NSString stringWithFormat:@"<img width=\"%f\" height=\"%f\" src=\"%@\">",width,height,img.url];
        if(start > content.length || length > content.length){
            continue;
        }
        [content replaceCharactersInRange:NSMakeRange(start, length) withString:imgcontent];
    }
    NSLog(@"内容:%@",content);
    return content;
}

- (ArticleDetail*)detail{
    if (!_detail) {
        _detail = [[ArticleDetail alloc]init];
        _detail.url = [NSString stringWithFormat:@"16/2/%@/%@/1",self.tag_id,self.tag_id];
        _detail.isCache = YES;
    }
    return _detail;
}

@end
