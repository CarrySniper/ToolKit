//
//  ImagePagePots.m
//  ToolKit
//
//  Created by CK_chan on 15/5/29.
//  Copyright (c) 2015年 CK_chan. All rights reserved.
//

#import "ImagePagePots.h"

#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height

#define SPACE 10
#define WH 15

@implementation ImagePagePots

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _activeImage = [UIImage imageNamed:@"ydy_point_choose.png"];
        _unActiveImage = [UIImage imageNamed:@"ydy_point_normal.png"];
        
    }
    return self;
}

static CGFloat start;
- (void)setNumberOfPages:(NSInteger)numberOfPages{
    _numberOfPages = numberOfPages;
    for (int i = 0; i < numberOfPages; i++) {
        
        start = (WIDTH - ((numberOfPages - 1) * SPACE + numberOfPages * WH))/2;
        
        UIImageView *imgPot = [[UIImageView alloc]initWithImage:_unActiveImage];
        imgPot.frame = CGRectMake(start + i * (SPACE + WH), 2.5, WH, WH);
        imgPot.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imgPot];
        
        if (i == numberOfPages - 1) {
            UIImageView *imgView = [[UIImageView alloc]initWithImage:_activeImage];
            imgView.frame = CGRectMake(start, 2.5, WH, WH);
            imgView.tag = 10010;
            imgView.contentMode = UIViewContentModeScaleAspectFill;
            [self addSubview:imgView];
        }
    }
}

- (void)setCurrentPage:(NSInteger)currentPage{

    UIImageView *imgView = (UIImageView *)[self viewWithTag:10010];

    CGRect newFrame = imgView.frame;
    newFrame.origin.x = start + (SPACE + WH) * currentPage;
    imgView.frame = newFrame;

}


- (void)setPointScale:(float)scale{
    
    CGFloat x = scale * (WH + SPACE) * (_numberOfPages -1);
    
    UIImageView *imgView = (UIImageView *)[self viewWithTag:10010];
    
    CGRect newFrame = imgView.frame;
    newFrame.origin.x = start + x;
    imgView.frame = newFrame;
}

-(void)dealloc{
    _activeImage = nil;
    _unActiveImage = nil;
    
    _numberOfPages = 0;
}

@end
