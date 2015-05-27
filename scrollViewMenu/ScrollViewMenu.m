//
//  ScrollViewMenu.m
//  两个scrollView制作菜单页
//
//  Created by CK_chan on 15/5/26.
//  Copyright (c) 2015年 CK_chan. All rights reserved.
//

#import "ScrollViewMenu.h"

#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height

#define Bar_SPACEWIDTH 100.0f
#define Bar_HEIGHT 49.0f

@implementation ScrollViewMenu

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _titleSV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, Bar_HEIGHT)];
        _titleSV.backgroundColor = self.backgroundColor;
        _titleSV.showsHorizontalScrollIndicator = NO;
        _titleSV.showsVerticalScrollIndicator = NO;
        _titleSV.userInteractionEnabled = YES;
        [self addSubview:_titleSV];
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, Bar_HEIGHT, WIDTH, HEIGHT - Bar_HEIGHT)];
        _scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        //添加模糊层
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        _effectview.frame = CGRectMake(0, Bar_HEIGHT, WIDTH, HEIGHT - Bar_HEIGHT);
        [self addSubview:_effectview];
        _effectview.alpha = 0;
    }
    return self;
}

- (void)setViewArray:(NSArray *)viewArray{
    [self setViewArray:viewArray andTitleArray:nil];
}

- (void)setTitleArray:(NSArray *)titleArray{
    [self setViewArray:nil andTitleArray:titleArray];
}

//设置视图和标题数组
- (void)setViewArray:(NSArray *)viewArray andTitleArray:(NSArray *)titleArray{
    
    if (viewArray != nil && viewArray.count > 0) {
        _viewArray = viewArray;
        for (int i = 0; i < _viewArray.count; i++) {
            UIView *view = _viewArray[i];
            view.frame = CGRectMake(i * WIDTH, 0, WIDTH, HEIGHT - Bar_HEIGHT);
            [_scrollView addSubview:view];
        }
        
        _scrollView.contentSize = CGSizeMake(WIDTH * viewArray.count, 0);

    }
    
    if (titleArray != nil && titleArray.count > 0) {
        _titleArray = titleArray;
        for (int i = 0; i < _titleArray.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i * Bar_SPACEWIDTH, 0, Bar_SPACEWIDTH, Bar_HEIGHT);
//            btn.backgroundColor = [UIColor clearColor];
            [btn setTitle:_titleArray[i] forState:UIControlStateNormal];
            
            //设置按钮字体大小 颜色 状态
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[_titleArray objectAtIndex:i]];
            [str addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20], NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, [str  length])];
            [btn setAttributedTitle:str forState:UIControlStateNormal];
            
            NSMutableAttributedString *selStr = [[NSMutableAttributedString alloc]initWithString:[_titleArray objectAtIndex:i]];
            [selStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20], NSForegroundColorAttributeName:[UIColor orangeColor]} range:NSMakeRange(0, [str  length])];
            [btn setAttributedTitle:selStr forState:UIControlStateDisabled];
            
            [btn setTag:i];
            if (btn.tag == 0) {
                btn.enabled = NO;
            }
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_titleSV addSubview:btn];
            
            //分割线
            if (i > 0 && HEIGHT>16) {
                UIView *line = [[UIView alloc]initWithFrame:CGRectMake(Bar_SPACEWIDTH*i, 8, 1, Bar_HEIGHT-16)];
                line.backgroundColor = [UIColor grayColor];
                [_titleSV addSubview:line];
            }
        }
        _titleSV.contentSize = CGSizeMake(Bar_SPACEWIDTH * titleArray.count, 0);
    }
    
}

//按钮点击事件
- (void)btnClick:(UIButton *)sender{
    for (UIView *subView in _titleSV.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *subBtn = (UIButton *)subView;
            if (subBtn.tag == sender.tag) {
                [subBtn setEnabled:NO];
            }else {
                [subBtn setEnabled:YES];
            }
        }
    }

    [_scrollView setContentOffset:CGPointMake(WIDTH * sender.tag, 0)];
    
    
    [UIView animateWithDuration:0.5 animations:^{
        _effectview.alpha = 0.6;
    }];
    [UIView animateWithDuration:0.5 animations:^{
        _effectview.alpha = 0;
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    /*
        _titleSV可移动范围：_titleSV.contentSize的width - 控件我宽WIDTH
        _titleSV.contentOffset.x 不能超过 _titleSV.contentSize的width - 控件宽WIDTH
        如果控件宽 WIDTH > _titleSV.contentSize的width 则跳出
     */

    if (WIDTH > Bar_SPACEWIDTH * _titleArray.count) {
        return;
    }
    
    int x = scrollView.contentOffset.x;
    float scale = x / ((_viewArray.count - 1) * WIDTH);
    [_titleSV setContentOffset:CGPointMake((Bar_SPACEWIDTH * _titleArray.count - WIDTH) * scale, 0) animated:NO];
    
    
    //按钮的处理
    NSInteger index = fabs(scrollView.contentOffset.x + WIDTH/2) / scrollView.frame.size.width;   //当前是第几个视图
    for (UIView *subView in _titleSV.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *subBtn = (UIButton *)subView;
            if (subBtn.tag == index) {
                [subBtn setEnabled:NO];
            }else {
                [subBtn setEnabled:YES];
            }
        }
    }
    
    //模糊化处理
    double scrollWidth = CGRectGetWidth(_scrollView.frame);
    double contentOffSetX = _scrollView.contentOffset.x;
    double coff = (contentOffSetX - (((int)(contentOffSetX / scrollWidth)) * scrollWidth))/scrollWidth;
    NSInteger page = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    for (int i = 0; i < _viewArray.count; i++) {
        UIView *view = [_viewArray objectAtIndex:i];
        if (i == page) {
            view.alpha = 1 - coff;
        }else{
            view.alpha = coff;
        }
        
    }
}

- (void)dealloc{
    _titleSV = nil;
    _scrollView = nil;
    
    _effectview = nil;
    
    _viewArray = nil;
    _titleArray = nil;
}

@end
