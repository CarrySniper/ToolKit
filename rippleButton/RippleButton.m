//
//  RippleButton.m
//  ToolKit
//
//  Created by CK_chan on 15/5/22.
//  Copyright (c) 2015年 CK_chan. All rights reserved.
//

#import "RippleButton.h"
#import <QuartzCore/QuartzCore.h>


#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height

#define PI 3.14159265358979323846
#define Diameter 80 //直径



@implementation RippleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *circleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        circleBtn.frame = CGRectMake((WIDTH-Diameter)/2, (HEIGHT-Diameter)/2, Diameter, Diameter);
        circleBtn.backgroundColor = [UIColor purpleColor];
        circleBtn.layer.cornerRadius = Diameter/2;
        circleBtn.layer.masksToBounds = YES;
        //设置按钮字体大小 颜色 状态
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:@"click"];
        [str addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20], NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, [str  length])];
        [circleBtn setAttributedTitle:str forState:UIControlStateNormal];
        
        [circleBtn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:circleBtn];
        
        _centerPoint = circleBtn.center;
        /*
            定时器
         */
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.015f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop  currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
        [_timer setFireDate:[NSDate distantFuture]];//关闭定时器
        
        
        _stop =[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countTime) userInfo:nil repeats:YES];
        [[NSRunLoop  currentRunLoop] addTimer:_stop forMode:NSDefaultRunLoopMode];
        [_stop setFireDate:[NSDate distantFuture]];//关闭定时器
    }
    return self;
}

-(void)timerAction{
    for (int i = 0; i<sizeof(ary)/sizeof(int); i++) {
        if (ary[i] > 0) {
            ary[i] +=2.50;
        }
    }
    [self setNeedsDisplay];//会调用自动调用drawRect方法,方便绘图
}

- (void)clickAction{

    for (int i = 0; i<sizeof(ary)/sizeof(int); i++) {
        if (ary[i] == 0) {
            ary[i] = Diameter/2;
            break;
        }
    }
    
    [self setNeedsDisplay];//会调用自动调用drawRect方法,方便绘图
    
    if (_count == 0) {
        [_timer setFireDate:[NSDate distantPast]];//开启定时器
        [_stop setFireDate:[NSDate distantPast]];//开启定时器
    }
    _count = 5;
}

- (void)countTime{
    _count--;
    if (_count == 0) {
        [_timer setFireDate:[NSDate distantFuture]];//关闭定时器
        [_stop setFireDate:[NSDate distantFuture]];//关闭定时器
    }
}

//static int red;
//static int green;
//static int blue;
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
//    int red = rand() % 255;
//    int green = rand() % 255;
//    int blue = rand() % 255;
    
    for (int i = 0; i<sizeof(ary)/sizeof(int); i++) {
        /*
         边框圆
         CG_EXTERN void CGContextSetRGBStrokeColor(CGContextRef context, CGFloat red,
         CGFloat green, CGFloat blue, CGFloat alpha)
         
         CG_EXTERN void CGContextAddArc(CGContextRef c, CGFloat x, CGFloat y,
         CGFloat radius, CGFloat startAngle, CGFloat endAngle, int clockwise)
         */
        
        
        if (ary[i] > 0 && ary[i] < 300) {
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetRGBStrokeColor(context, 168/255.0, 88/255.0, 168/255.0, 1);
//            CGContextSetRGBStrokeColor(context, red/255.0, green/255.0, blue/255.0, 1);
            CGContextSetLineWidth(context, 2.50);
            
            CGContextAddArc(context, _centerPoint.x, _centerPoint.y, ary[i], 0, 2*M_PI, 0);
            CGContextDrawPath(context, kCGPathStroke);
        }else if (ary[i] > 300) {
            ary[i] = 0;
        }
    }
}

- (void)dealloc{
    [_timer setFireDate:[NSDate distantFuture]];//关闭定时器
    [_stop setFireDate:[NSDate distantFuture]];//关闭定时器
    
    _timer = nil;    //定时器
    
    _centerPoint = CGPointZero;
    
    _stop = nil;    //定时器
    _count = 0;
}

@end
