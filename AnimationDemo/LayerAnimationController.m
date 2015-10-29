//
//  LayerAnimationController.m
//  homeWork_08_30
//
//  Created by ClariS on 15/8/30.
//  Copyright (c) 2015年 ClariS. All rights reserved.
//

#import "LayerAnimationController.h"

@interface LayerAnimationController ()
{
    CALayer *CATransactionLayer;
}
@end

@implementation LayerAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.toolbarHidden = NO;
    
    UIBarButtonItem *playButton = [[UIBarButtonItem alloc] initWithTitle:@"做动画" style:UIBarButtonItemStylePlain target:self action:@selector(playAction:)];
    self.toolbarItems = @[playButton];
    
    CATransactionLayer = [CALayer layer];
    CATransactionLayer.frame = CGRectMake(100, 100, 50, 50);
    CATransactionLayer.backgroundColor = [UIColor yellowColor].CGColor;
    [self.view.layer addSublayer:CATransactionLayer];
    self.navigationItem.title = @"让layer本身制作动画";
}

-(void)playAction:(UIBarButtonItem *)sender{
    [CATransaction begin];
    //设置动画时间
    [CATransaction setValue:@1.0f forKey:kCATransactionAnimationDuration];
    //改变layer位置
    CGFloat pointY = CATransactionLayer.position.y> 250 ? 125:425;
    CATransactionLayer.position = CGPointMake(CATransactionLayer.position.x, pointY);
    
    [CATransaction commit];
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
