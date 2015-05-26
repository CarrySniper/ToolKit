//
//  ComBox.m
//  ToolKit
//
//  Created by CK_chan on 15/5/21.
//  Copyright (c) 2015年 CK_chan. All rights reserved.
//

/*
    1.包含头文件 #import "ComBox.h"
    2.添加代理 ComBoxProtocol
    3.创建并初始化
    4.设置代理并加载到视图
    5.设置：numberOfItems 显示选项个数
        5.1.默认为显示5个选项，少于5个则根据传递数据显示
        5.2.若要不限制显示个数，则设置为0；
    6.设置数据源 setOptionalItems 传入数组
 */

#import "ComBox.h"

#define DEGREES_TO_RADIANS(angle) ((angle)/180.0 *M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians)*(180.0/M_PI))

#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height

#define BTN_COLOR [UIColor groupTableViewBackgroundColor]
#define ITEM_HIGH 28.0f


@implementation ComBox


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.clipsToBounds = YES;
    
    _controlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _controlBtn.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    _controlBtn.backgroundColor = BTN_COLOR;
    [_controlBtn setTitle:@"comBox" forState:UIControlStateNormal];
    [_controlBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    _controlBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _controlBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    _controlBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_controlBtn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_controlBtn];
    
    _iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH-20, 7.5, 15, 15)];
    _iconImg.image = [UIImage imageNamed:@"triangle.png"];
    _iconImg.transform = CGAffineTransformRotate(_iconImg.transform, DEGREES_TO_RADIANS(270));
    [self addSubview:_iconImg];
    
    _isShow = NO;
    _currentHigh = HEIGHT;
    self.numberOfItems = 5;
    [_controlBtn setTitle:_dataSource[0] forState:UIControlStateNormal];
}

/*
    设置可选项目，传入数组类型
 */
- (void)setOptionalItems:(NSArray *)array{
    _dataSource = array;
    if (_dataSource != nil && _dataSource.count > 0) {
        UIScrollView *listSV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, HEIGHT, WIDTH, 0)];
        listSV.backgroundColor = self.backgroundColor;
        listSV.userInteractionEnabled = YES;
        listSV.bounces = NO;
        listSV.tag = 404;
        [self addSubview:listSV];
        
        [_controlBtn setTitle:array[0] forState:UIControlStateNormal];
        
        for (int i = 0; i < array.count; i++) {
            UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            itemBtn.frame = CGRectMake(1, 1 + i * ITEM_HIGH, WIDTH-2, ITEM_HIGH - 1);
            itemBtn.backgroundColor = BTN_COLOR;
            
            // 使用颜色创建UIImage
            CGSize imageSize = CGSizeMake(50, 50);
            UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
            [[UIColor grayColor] set];
            UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
            UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            [itemBtn setBackgroundImage:pressedColorImg forState:UIControlStateHighlighted];
            [itemBtn setTitleColor:BTN_COLOR forState:UIControlStateHighlighted];
            
            [itemBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [itemBtn setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
            
            itemBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            itemBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
            itemBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            [itemBtn setTag:i];
            [itemBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            [listSV addSubview:itemBtn];
    
        }
        
        if (array.count < self.numberOfItems || self.numberOfItems == 0) {
            _listHigh = array.count * ITEM_HIGH + 1;
        }else{
            _listHigh = self.numberOfItems * ITEM_HIGH + 1;
        }
        
        listSV.frame = CGRectMake(0, HEIGHT, WIDTH, _listHigh);
        listSV.contentSize = CGSizeMake(WIDTH, array.count * ITEM_HIGH + 1);
    }
    
}

//实现numberOfItems的set方法
- (void)setnumberOfItems:(NSInteger)numberOfItems{
    
    UIScrollView *listSV = (UIScrollView *)[self viewWithTag:404];
    if (_listHigh > numberOfItems * ITEM_HIGH + 1 && numberOfItems != 0) {
        _listHigh = numberOfItems * ITEM_HIGH + 1;
    }else if (numberOfItems == 0) {
        _listHigh = _dataSource.count * ITEM_HIGH + 1;
    }
    
    listSV.frame = CGRectMake(0, HEIGHT, WIDTH, _listHigh);
    _numberOfItems = numberOfItems;
}

/*
    实现点击items方法，取得被点击值
 */
- (void)clickAction:(UIButton *)sender{
    [_controlBtn setTitle:sender.titleLabel.text forState:UIControlStateNormal];
    
    _isShow = NO;
    [UIView animateWithDuration:0.2 animations:^{
        _iconImg.transform = CGAffineTransformRotate(_iconImg.transform, DEGREES_TO_RADIANS(90));
        CGRect newFrame = self.frame;
        newFrame.size.height = _currentHigh;
        self.frame = newFrame;//CGRectMake(0, 0, WIDTH, HEIGHT);
    }];
    
    //协议委托，代理事件传值
    if ([self.myDelegate conformsToProtocol:@protocol(ComBoxProtocol)]) {
        if ([self.myDelegate respondsToSelector:@selector(getItemsIndex:andTitle:)]) {
            return [self.myDelegate getItemsIndex:sender.tag andTitle:sender.titleLabel.text];
        }
    }
}

/*
     实现点击展开和隐藏选项列表
 */
- (void)clickAction{
    
    if (_isShow) {
        _isShow = NO;
        
        [UIView animateWithDuration:0.2 animations:^{
            _iconImg.transform = CGAffineTransformRotate(_iconImg.transform, DEGREES_TO_RADIANS(90));
            CGRect newFrame = self.frame;
            newFrame.size.height = _currentHigh;
            self.frame = newFrame;
        }];
        if (_dataSource == nil || _dataSource.count == 0){
            UILabel *nullLabel = (UILabel *)[self viewWithTag:403];
            [nullLabel removeFromSuperview];
        }
    }else{
        _isShow = YES;
        
        [UIView animateWithDuration:0.2 animations:^{
            _iconImg.transform = CGAffineTransformRotate(_iconImg.transform, DEGREES_TO_RADIANS(-90));
            CGRect newFrame = self.frame;
            if (_dataSource != nil && _dataSource.count > 0){
                newFrame.size.height = _currentHigh + _listHigh;
            }else{
                UILabel *nullLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT, WIDTH, 25)];
                nullLabel.tag = 403;
                nullLabel.backgroundColor = BTN_COLOR;
                nullLabel.text = @"没有可选项";
                nullLabel.textColor = [UIColor grayColor];
                nullLabel.font = [UIFont systemFontOfSize:14];
                [self addSubview:nullLabel];
                newFrame.size.height = _currentHigh + ITEM_HIGH;
            }
            self.frame = newFrame;
        }];
        
    }
}

- (void)dealloc{
    _controlBtn = nil;
    _iconImg = nil;
    _listSV = nil;
    _dataSource = nil;
    _isShow = 0;
    
    _listHigh = 0;
    _currentHigh = 0;
    _myDelegate = nil;
    _numberOfItems = 0;
}


@end
