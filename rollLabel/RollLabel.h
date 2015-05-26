//
//  RollLabel.h
//  ToolKit
//
//  Created by CK_chan on 15/5/25.
//  Copyright (c) 2015年 CK_chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RollLabel : UIView{
    UILabel *_label;
    BOOL _isRolling;
}

@property(nonatomic,strong) NSString *text;

@end
