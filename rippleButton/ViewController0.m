//
//  ViewController0.m
//  ToolKit
//
//  Created by CK_chan on 15/5/22.
//  Copyright (c) 2015年 CK_chan. All rights reserved.
//

#import "ViewController0.h"
#import "RippleButton.h"

@interface ViewController0 ()

@end

@implementation ViewController0

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"RippleButton-产生波纹按钮";
    
    UIImage *image = [UIImage imageNamed:@"bgImage.png"];
    self.view.layer.contents = (id) image.CGImage;
    //添加模糊层
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *_effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    _effectview.frame = CGRectMake(20, 84, self.view.frame.size.width - 40, self.view.frame.size.height-104);
    [self.view addSubview:_effectview];
    _effectview.alpha = 0.7;
    
    RippleButton *ripBtn = [[RippleButton alloc]initWithFrame:self.view.bounds];
    ripBtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:ripBtn];
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
