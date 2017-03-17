//
//  VCMine.m
//  News
//
//  Created by zhouMR on 2017/3/17.
//  Copyright © 2017年 luowei. All rights reserved.
//

#import "VCMine.h"
#import "CellHome.h"
#import "HomeList.h"

@interface VCMine ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) HomeList *homeList;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end


@implementation VCMine


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
        HomeList *t = (HomeList*)m;
        [safeSelf.dataSource removeAllObjects];
        [safeSelf.dataSource addObjectsFromArray:t.datas];
        [safeSelf.table reloadData];
    } withFailure:^(ApiObject *m) {
        
    }];
}
/*
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
 */

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeListData *data  = [self.dataSource objectAtIndex:indexPath.row];
    return [CellHome calHeight:data];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *SimpleTableIdentifier = @"CellHome";
    CellHome *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[CellHome alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    HomeListData *data  = [self.dataSource objectAtIndex:indexPath.row];
    [cell loadData:data];
    NSLog(@"%@",data.content.title);
    return cell;
}


#pragma mark - Getter Setter
- (UITableView*)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT- NAV_STATUS_HEIGHT) style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
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
