//
//  CellHome.m
//  News
//
//  Created by zhouMR on 2017/3/17.
//  Copyright © 2017年 luowei. All rights reserved.
//

#import "CellHome.h"

@interface CellHome()
@property (nonatomic, strong) UILabel *lbTitle;
@property (nonatomic, strong) UIView *imageVG;
@property (nonatomic, strong) UIView *vLine;
@end

@implementation CellHome

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lbTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbTitle.font = FONT(17);
        _lbTitle.numberOfLines = 0;
        _lbTitle.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_lbTitle];
        
        _imageVG = [[UIView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:_imageVG];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(232);
        [self.contentView addSubview:_vLine];
    }
    return self;
}

- (void)loadData:(HomeListData*)data{
    self.lbTitle.text = data.content.title;
    if (data.content.image_list.count == 3) {
        self.imageVG.hidden = NO;
        CGFloat w = (DEVICEWIDTH - 30 - 10)/3.0;
        self.imageVG.height = w / 1.5;
        NSInteger i = 0;
        for (HomeListImg *img in data.content.image_list) {
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(i * w +i*5, 0, w, w/1.5)];
            image.backgroundColor = [UIColor blueColor];
            [image downloadImage:img.url];
            [self.imageVG addSubview:image];
            i++;
        }
    }else{
        self.imageVG.hidden = YES;
    }
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.lbTitle.frame;
    CGSize size = [self.lbTitle sizeThatFits:CGSizeMake(DEVICEWIDTH-30, MAXFLOAT)];
    r.size.width = DEVICEWIDTH - 30;
    r.size.height = size.height;
    r.origin.x = 15;
    r.origin.y = 15;
    self.lbTitle.frame = r;
    
    r = self.imageVG.frame;
    r.size.width = self.lbTitle.width;
    r.origin.x = self.lbTitle.left;
    r.origin.y = self.lbTitle.bottom + 5;
    self.imageVG.frame = r;
    
    r = self.vLine.frame;
    r.size.width = DEVICEWIDTH - 30;
    r.origin.x = 15;
    r.origin.y = self.height - r.size.height;
    self.vLine.frame = r;
}

+ (CGFloat)calHeight:(HomeListData*)data{
    UILabel *lb = [[UILabel alloc]init];
    lb.font = FONT(17);
    lb.numberOfLines = 0;
    lb.text = data.content.title;
    CGFloat height = [lb sizeThatFits:CGSizeMake(DEVICEWIDTH-30, MAXFLOAT)].height;
    
    
    if (data.content.image_list.count == 3) {
        CGFloat w = (DEVICEHEIGHT - 30 - 10)/3.0;
        height += w * 1.5;
    }
    
    return 20+height+10.5;
}
@end
