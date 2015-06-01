//
//  RippleButton.h
//  ToolKit
//
//  Created by CK_chan on 15/5/22.
//  Copyright (c) 2015年 CK_chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RippleButton : UIView{
    NSTimer *_timer;    //定时器
    float ary[12];//最多显示n个圈
    
    CGPoint _centerPoint;
    
    NSTimer *_stop;    //定时器
    NSInteger _count;
}

@end
