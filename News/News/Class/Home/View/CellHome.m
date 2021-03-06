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
@property (nonatomic, strong) UILabel *lbAuthor;
@property (nonatomic, strong) UIView *vLine;
@end

@implementation CellHome

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _lbTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbTitle.font = FONT(17);
        _lbTitle.numberOfLines = 0;
        _lbTitle.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_lbTitle];
        
        _imageVG = [[UIView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:_imageVG];
         
        _lbAuthor = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbAuthor.font = FONT(12);
        _lbAuthor.textColor = [UIColor grayColor];
        _lbAuthor.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_lbAuthor];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(232);
        [self.contentView addSubview:_vLine];
    }
    return self;
}

- (void)loadData:(HomeListData*)data{
    _data = data;
    self.lbTitle.text = data.content.title;
    if (data.content.image_list.count == 3) {
        self.imageVG.hidden = NO;
        CGFloat w = (DEVICEWIDTH - 30 - 10)/3.0;
        self.imageVG.height = w / 1.5;
        NSInteger i = 0;
        for (HomeListImg *img in data.content.image_list) {
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(i * w +i*5, 0, w, w/1.5)];
            [image downloadImage:img.url];
            [self.imageVG addSubview:image];
            i++;
        }
    }else{
        self.imageVG.hidden = YES;
    }
    self.lbAuthor.text = data.content.media_name;
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
    
    CGFloat y = self.lbTitle.bottom;
    if (self.data.content.image_list.count == 3) {
        y += 5;
        r = self.imageVG.frame;
        r.size.width = self.lbTitle.width;
        r.origin.x = self.lbTitle.left;
        r.origin.y = y;
        self.imageVG.frame = r;
        y += r.size.height;
    }
    
    
    size = [self.lbAuthor sizeThatFits:CGSizeMake(MAXFLOAT, 12)];
    r = self.lbAuthor.frame;
    r.size.width = size.width;
    r.size.height = size.height;
    r.origin.x = self.lbTitle.left;
    r.origin.y = y + 10;
    self.lbAuthor.frame = r;
    
    
    r = self.vLine.frame;
    r.size.width = DEVICEWIDTH - 30;
    r.size.height = 0.5;
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
        CGFloat w = (DEVICEWIDTH - 30 - 10)/3.0;
        height += w / 1.5 + 5;
    }
    if (data.content.media_name && ![@"" isEqualToString:data.content.media_name]) {
        lb.font = FONT(12);
        lb.numberOfLines = 1;
        lb.text = data.content.media_name;
        height += [lb sizeThatFits:CGSizeMake(MAXFLOAT, 12)].height+10;
    }
    
    return 15+height+10.5;
}
@end
