//
//  VCHome.m
//  News
//
//  Created by zhouMR on 2017/3/17.
//  Copyright © 2017年 luowei. All rights reserved.
//

#import "VCHome.h"
#import "CellHome.h"
#import "HomeList.h"
#import "VCArticleDetail.h"

@interface VCHome ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) HomeList *homeList;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation VCHome

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    _dataSource = [NSMutableArray array];
    [self.view addSubview:self.table];
    [self loadData];
}

#pragma mark - Event
- (void)loadData{
    __weak typeof(self) safeSelf = self;
    [[NetRequestTool shared]requestPost:self.homeList withSuccess:^(ApiObject *m) {
        [_table.mj_header endRefreshing];
        HomeList *t = (HomeList*)m;
        [safeSelf.dataSource removeAllObjects];
        [safeSelf.dataSource addObjectsFromArray:t.datas];
        [safeSelf.table reloadData];
    } withFailure:^(ApiObject *m) {
        [_table.mj_header endRefreshing];
    }];
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeListData *data  = [self.dataSource objectAtIndex:indexPath.row];
    return [CellHome calHeight:data];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CellHome";
    CellHome *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellHome alloc]init];
    }
    HomeListData *data  = [self.dataSource objectAtIndex:indexPath.row];
    [cell loadData:data];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeListData *data  = [self.dataSource objectAtIndex:indexPath.row];
    VCArticleDetail *vc = [[VCArticleDetail alloc]init];
    vc.url = data.content.artcle_url;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Getter Setter
- (UITableView*)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT- NAV_STATUS_HEIGHT) style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self loadData];
        }];
        [_table.mj_header beginRefreshing];
    }
    return _table;
}

- (HomeList*)homeList{
    if (!_homeList) {
        _homeList = [[HomeList alloc]init];
        _homeList.isCache = YES;
    }
    return _homeList;
}
@end
