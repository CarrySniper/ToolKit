//
//  ViewController3.m
//  ToolKit
//
//  Created by CK_chan on 15/5/27.
//  Copyright (c) 2015年 CK_chan. All rights reserved.
//

#import "ViewController3.h"
#import "ScrollViewMenu.h"

@interface ViewController3 ()

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"两个scrollView制作菜单页";
    
    //导航条背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];//不能放init处
    //导航条title字体颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:20], NSFontAttributeName, nil]];//iOS6之后
    //修复偏移现象
    self.automaticallyAdjustsScrollViewInsets = NO;
    ScrollViewMenu *svMenu = [[ScrollViewMenu alloc]initWithFrame:CGRectMake(0 , 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    [self.view addSubview:svMenu];
    
    UIImageView *vc1 = [[UIImageView alloc]init];vc1.backgroundColor = [UIColor redColor];
    UIImageView *vc2 = [[UIImageView alloc]init];vc2.backgroundColor = [UIColor blueColor];
    UIImageView *vc3 = [[UIImageView alloc]init];vc3.backgroundColor = [UIColor greenColor];
    UIImageView *vc4 = [[UIImageView alloc]init];vc4.backgroundColor = [UIColor orangeColor];
    UIImageView *vc5 = [[UIImageView alloc]init];vc5.backgroundColor = [UIColor purpleColor];
    
    vc1.image = [UIImage imageNamed:@"bgImage"];
    vc2.image = [UIImage imageNamed:@"bgImage"];
    vc3.image = [UIImage imageNamed:@"bgImage"];
    vc4.image = [UIImage imageNamed:@"bgImage"];
    vc5.image = [UIImage imageNamed:@"bgImage"];
    
    vc1.contentMode = UIViewContentModeScaleAspectFit;
    vc2.contentMode = UIViewContentModeScaleAspectFit;
    vc3.contentMode = UIViewContentModeScaleAspectFit;
    vc4.contentMode = UIViewContentModeScaleAspectFit;
    vc5.contentMode = UIViewContentModeScaleAspectFit;
    
    NSArray *aryV = @[vc1,vc2,vc3,vc4,vc5];
    NSArray *aryT = @[@"vc1红",@"vc2绿",@"vc3蓝",@"vc4橙",@"vc5紫"];
    
//    [svMenu setViewArray:aryV andTitleArray:aryT];
    //或者使用2行代替
    [svMenu setViewArray:aryV];
    [svMenu setTitleArray:aryT];
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
