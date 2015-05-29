//
//  ViewController4.m
//  ToolKit
//
//  Created by CK_chan on 15/5/28.
//  Copyright (c) 2015年 CK_chan. All rights reserved.
//

#import "ViewController4.h"
#import "ImagePagePots.h"


@interface ViewController4 (){
    ImagePagePots *imagePots;
}

@end

@implementation ViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"ImagePagePots自定义图片Pots";
    
    //导航条背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];//不能放init处
    //导航条title字体颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:20], NSFontAttributeName, nil]];//iOS6之后
    
    //修复偏移现象
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 80, self.view.frame.size.width -20, self.view.frame.size.height -90)];
    scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    scrollView.showsHorizontalScrollIndicator = NO;
//    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.userInteractionEnabled = YES;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(5 * scrollView.frame.size.width, 0);
    
    imagePots = [[ImagePagePots alloc]initWithFrame:CGRectMake(0 , 100, self.view.frame.size.width, 30)];
    [self.view addSubview:imagePots];
    
    imagePots.numberOfPages = 5;
//    imagePots.currentPage = 1;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int x = scrollView.contentOffset.x;
    float scale = x / ((5 - 1) * scrollView.frame.size.width);
    
    [imagePots setPointScale:scale];
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
