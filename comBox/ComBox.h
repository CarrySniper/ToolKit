//
//  ComBox.h
//  ToolKit
//
//  Created by CK_chan on 15/5/21.
//  Copyright (c) 2015年 CK_chan. All rights reserved.
//

#import <UIKit/UIKit.h>
//------------------协议委托--------------------
@protocol ComBoxProtocol <NSObject>

- (void)getItemsIndex:(NSInteger)index andTitle:(NSString *)string;

@end

@interface ComBox : UIView{
    UIButton *_controlBtn;
    UIImageView *_iconImg;
    UIScrollView *_listSV;
    NSArray *_dataSource;
    BOOL _isShow;
    
    CGFloat _listHigh;
    CGFloat _currentHigh;
}

@property (assign)  id<ComBoxProtocol> myDelegate;

@property (nonatomic,assign) NSInteger numberOfItems;

- (void)setOptionalItems:(NSArray *)array;

@end
