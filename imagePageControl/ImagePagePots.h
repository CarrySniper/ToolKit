//
//  ImagePagePots.h
//  ToolKit
//
//  Created by CK_chan on 15/5/29.
//  Copyright (c) 2015年 CK_chan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ImagePagePots : UIView{
    UIImage *_activeImage;
    UIImage *_unActiveImage;
    
    NSInteger _numberOfPages;
}


- (void)setNumberOfPages:(NSInteger)numberOfPages;

- (void)setCurrentPage:(NSInteger)currentPage;

- (void)setPointScale:(float)scale;

@end
