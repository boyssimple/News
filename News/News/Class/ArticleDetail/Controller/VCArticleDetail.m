//
//  VCArticleDetail.m
//  News
//
//  Created by zhouMR on 2017/3/17.
//  Copyright © 2017年 luowei. All rights reserved.
//

#import "VCArticleDetail.h"

@interface VCArticleDetail ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation VCArticleDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.url isNotBlank]) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT)];
        [self.view addSubview:_webView];
        NSURL *ur = [[NSURL alloc]initWithString:self.url];
        [_webView loadRequest:[[NSURLRequest alloc]initWithURL:ur]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
