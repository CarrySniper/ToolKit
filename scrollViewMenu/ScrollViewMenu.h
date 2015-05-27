//
//  ScrollViewMenu.h
//  两个scrollView制作菜单页
//
//  Created by CK_chan on 15/5/26.
//  Copyright (c) 2015年 CK_chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollViewMenu : UIView<UIScrollViewDelegate>{
    UIScrollView *_titleSV;
    UIScrollView *_scrollView;
    
    UIVisualEffectView *_effectview;
    
    NSArray *_viewArray;
    NSArray *_titleArray;
}

- (void)setViewArray:(NSArray *)viewArray andTitleArray:(NSArray *)titleArray;

- (void)setViewArray:(NSArray *)viewArray;

- (void)setTitleArray:(NSArray *)titleArray;

@end
