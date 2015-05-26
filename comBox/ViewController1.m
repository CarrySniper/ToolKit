//
//  ViewController1.m
//  ToolKit
//
//  Created by CK_chan on 15/5/22.
//  Copyright (c) 2015年 CK_chan. All rights reserved.
//

#import "ViewController1.h"

#import "ComBox.h"


@interface ViewController1 ()<ComBoxProtocol>{
    UILabel *label;
}

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"ComBox";
    
    //修复偏移现象
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ComBox *comBox = [[ComBox alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-80, 110, 160, 30)];
    comBox.backgroundColor = [UIColor grayColor];
    
    comBox.myDelegate = self;
    [self.view addSubview:comBox];
    comBox.numberOfItems = 0;
    [comBox setOptionalItems:@[@"我最二",@"你最二",@"他最二",@"arc",@"mrc",@"sb"]];
    
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, self.view.frame.size.width-20, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    
}

- (void)getItemsIndex:(NSInteger)index andTitle:(NSString *)string;{
    //    NSLog(@"选择:下标＝%d，标题＝%@。",index,string);
    
    label.text = [NSString stringWithFormat:@"选择:下标＝%ld，标题＝%@。",index,string];
    
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
