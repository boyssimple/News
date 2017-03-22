//
//  CellHomeLeftVideo.h
//  News
//
//  Created by zhouMR on 2017/3/22.
//  Copyright © 2017年 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeList.h"

@interface CellHomeLeftVideo : UITableViewCell
- (void)loadData:(HomeListData*)data;
+ (CGFloat)calHeight:(HomeListData*)data;

@end
