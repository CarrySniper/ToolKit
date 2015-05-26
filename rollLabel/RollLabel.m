//
//  RollLabel.m
//  ToolKit
//
//  Created by CK_chan on 15/5/25.
//  Copyright (c) 2015年 CK_chan. All rights reserved.
//

/*
    rollLabel-根据字符串长度滚动标签
    
    1.如果当前字符串长度计算得的宽度 < 控件的宽度，则字符串居中显示；
    2.如果当前字符串长度计算得的宽度 > 控件的宽度，则字符串来回滚动显示，循环2次后停止；
    
    3.在2的情况下，点击停止状态下的控件，则再次滚动。
 
 */
#import "RollLabel.h"

#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height

@implementation RollLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setClipsToBounds:YES];
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _label.backgroundColor = [UIColor clearColor];
        [self addSubview:_label];
        
        //文本属性
        //    _label.textColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.lineBreakMode = NSLineBreakByTruncatingMiddle;
        _label.font = [UIFont boldSystemFontOfSize:15.f];
        _label.backgroundColor = [UIColor clearColor];
        
        
        // 单击的 TapRecognizer
        UITapGestureRecognizer *singleTap;
        singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rollAciton)];
        singleTap.numberOfTapsRequired = 1; //点击的次数 ＝1 单击
        [self addGestureRecognizer:singleTap];//给对象添加一个手势监测；
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setText:(NSString *)text{
    if (text != nil && text.length>0) {
        self.hidden = NO;
        _label.text = text;
        
        [self rollAciton];
        
    }else{
        self.hidden = YES;
    }
}

//滚动动作
- (void)rollAciton{
    if (_isRolling == NO) {
        _isRolling = YES;
        
        CGRect frame = _label.frame;
        CGSize textSize = [_label.text sizeWithFont:_label.font];//照样用着先
        
        if (WIDTH > textSize.width) {
            return;
        }
        
        frame.size.width = textSize.width;
        frame.origin.x = WIDTH;
        _label.frame = frame;
        
        //UIView开始动画，第一个参数是动画的标识，第二个参数附加的应用程序信息用来传递给动画代理消息
        [UIView beginAnimations:@"testAnimation"context:NULL];
        //动画持续时间
        [UIView setAnimationDuration:4.0f];
        //设置动画曲线，控制动画速度
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        //设置动画的回调函数，设置后可以使用回调方法
        [UIView setAnimationDelegate:self];
        //设置动画是否重复反转
        [UIView setAnimationRepeatAutoreverses:YES];
        //设置动画重复次数
        [UIView setAnimationRepeatCount:2];
        
        frame = _label.frame;
        frame.origin.x = -frame.size.width;
        _label.frame = frame;
        
        //设置动画执行完后要调用方法
        [UIView setAnimationDidStopSelector:@selector(stopSelector)];
        //提交UIView动画
        [UIView commitAnimations];
    }
    
}

//AnimationDidStopSelector
- (void)stopSelector{
    CGRect frame = _label.frame;
    frame.size.width = WIDTH;
    frame.origin.x = 0;
    _label.frame = frame;
    
    [_label.layer removeAllAnimations];
    _isRolling = NO;
}

-(void)dealloc{
    [_label.layer removeAllAnimations];
    _label = nil;
    _text = nil;
    [self removeFromSuperview];
}

@end
