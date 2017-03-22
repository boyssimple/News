//
//  CellHomeLeftVideo.m
//  News
//
//  Created by zhouMR on 2017/3/22.
//  Copyright © 2017年 luowei. All rights reserved.
//

#import "CellHomeLeftVideo.h"

@interface CellHomeLeftVideo()
@property (nonatomic, strong) UILabel *lbTitle;
@property (nonatomic, strong) UIImageView *ivImg;
@property (nonatomic, strong) UILabel *lbAuthor;
@property (nonatomic, strong) UIView *vLine;
@end

@implementation CellHomeLeftVideo

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _lbTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbTitle.font = FONT(17);
        _lbTitle.numberOfLines = 3;
        _lbTitle.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_lbTitle];
        
        _ivImg = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:_ivImg];
        
        
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
    self.lbTitle.text = data.content.title;
    [self.ivImg downloadImage:data.content.detail_video_large_image];
    self.lbAuthor.text = data.content.media_name;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.lbTitle.frame;
    CGSize size = [self.lbTitle sizeThatFits:CGSizeMake(DEVICEWIDTH-30, MAXFLOAT)];
    r.size.width = DEVICEWIDTH - 45 - 80;
    r.size.height = size.height;
    r.origin.x = 15;
    r.origin.y = 15;
    self.lbTitle.frame = r;

    r = self.ivImg.frame;
    r.size.width = 80;
    r.size.height = 60;
    r.origin.x = DEVICEWIDTH - 80 - 15;
    r.origin.y = self.lbTitle.top;
    self.ivImg.frame = r;
    
    size = [self.lbAuthor sizeThatFits:CGSizeMake(MAXFLOAT, 12)];
    r = self.lbAuthor.frame;
    r.size.width = size.width;
    r.size.height = size.height;
    r.origin.x = self.lbTitle.left;
    r.origin.y = self.ivImg.bottom + 10;
    self.lbAuthor.frame = r;
    
    r = self.vLine.frame;
    r.size.width = DEVICEWIDTH - 30;
    r.size.height = 0.5;
    r.origin.x = 15;
    r.origin.y = self.height - r.size.height;
    self.vLine.frame = r;
}

+ (CGFloat)calHeight:(HomeListData*)data{
    CGFloat height = 15+60+10.5;
    if (data.content.media_name && ![@"" isEqualToString:data.content.media_name]) {
        UILabel *lb = [[UILabel alloc]init];
        lb.font = FONT(12);
        lb.numberOfLines = 1;
        lb.text = data.content.media_name;
        height += [lb sizeThatFits:CGSizeMake(MAXFLOAT, 12)].height+10;
    }
    
    return height;
}

@end
