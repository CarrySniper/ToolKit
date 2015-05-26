//
//  ViewController2.m
//  ToolKit
//
//  Created by CK_chan on 15/5/25.
//  Copyright (c) 2015年 CK_chan. All rights reserved.
//

#import "ViewController2.h"

#import "RollLabel.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"rollLabel-根据字符串长度滚动标签";
    
    for (int i = 0; i<8; i++) {
        
        RollLabel *rollLabel = [[RollLabel alloc]initWithFrame:CGRectMake(10, 80 + 35 * i, 50 + 40 * i, 25)];
        rollLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.view addSubview:rollLabel];
        rollLabel.text = @"123456789987654321";
        
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
