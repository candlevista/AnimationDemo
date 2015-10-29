//
//  BasicAnimationController.m
//  homeWork_08_30
//
//  Created by ClariS on 15/8/30.
//  Copyright (c) 2015年 ClariS. All rights reserved.
//

#import "BasicAnimationController.h"
#import "KeyframeAnimationController.h"

@interface BasicAnimationController ()
{
    UIView *animationView;
}
@end

@implementation BasicAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(nextAction:)];
    self.navigationItem.rightBarButtonItem = next;
    self.navigationController.toolbarHidden = NO;
    
    UIBarButtonItem *playXButton = [[UIBarButtonItem alloc] initWithTitle:@"X轴旋转" style:UIBarButtonItemStylePlain target:self action:@selector(playAction:)];
    playXButton.tag = 101;
    UIBarButtonItem *playYButton = [[UIBarButtonItem alloc] initWithTitle:@"Y轴旋转" style:UIBarButtonItemStylePlain target:self action:@selector(playAction:)];
    playYButton.tag = 102;
    UIBarButtonItem *playZButton = [[UIBarButtonItem alloc] initWithTitle:@"Z轴旋转" style:UIBarButtonItemStylePlain target:self action:@selector(playAction:)];
    playZButton.tag = 103;
    UIBarButtonItem *translationButton = [[UIBarButtonItem alloc] initWithTitle:@"位移" style:UIBarButtonItemStylePlain target:self action:@selector(translationAction:)];
    UIBarButtonItem *rotationButton = [[UIBarButtonItem alloc] initWithTitle:@"旋转" style:UIBarButtonItemStylePlain target:self action:@selector(rotationAction:)];
    UIBarButtonItem *scaleButton = [[UIBarButtonItem alloc] initWithTitle:@"缩放" style:UIBarButtonItemStylePlain target:self action:@selector(scaleAction:)];
    self.toolbarItems = @[playXButton,playYButton,playZButton,translationButton,rotationButton,scaleButton];
    
    animationView = [UIView new];
    animationView.translatesAutoresizingMaskIntoConstraints = NO;
    animationView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:animationView];
    NSArray *contraints;
    contraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-120-[animationView(==120)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(animationView)];
    [self.view addConstraints:contraints];
    
    contraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-180-[animationView(==120)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(animationView)];
    [self.view addConstraints:contraints];

    self.navigationItem.title = @"CABasicAnimation制作动画";
}

-(void)playAction:(UIButton *)sender{
    /*
     动画方式的键路径
     transform                      3D旋转
     transform.rotation             旋转
     transform.translation(x,y,z)   位移
     transform.scale(x,y,z)         放大缩小
     
     position(x,y)                  位移     
     */
    CABasicAnimation *xRotation = [CABasicAnimation animationWithKeyPath:@"transform"];
    xRotation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    if (sender.tag == 101) {
        xRotation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1, 0, 0)];
    }
    if (sender.tag == 102) {
        xRotation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 1, 0)];
    }
    if (sender.tag == 103) {
        xRotation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1)];
    }
    xRotation.duration = 1.f;
    xRotation.repeatCount = FLT_MAX;
    xRotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [animationView.layer addAnimation:xRotation forKey:@"Rocket"];
}

-(void)translationAction:(UIBarButtonItem *)sender{
    CABasicAnimation *translation = [CABasicAnimation animationWithKeyPath:@"transform.translation"];
    //起点按将要加入的view的layer层的（0，0）起计算，并非按self.view的原点开始计算
    translation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    translation.toValue = [NSValue valueWithCGPoint:CGPointMake(120, 180)];
    //返回动画
    translation.autoreverses = YES;
    translation.duration = 1.0;
    translation.repeatCount = 2;
    translation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [animationView.layer addAnimation:translation forKey:@"Rocket"];
}

-(void)rotationAction:(UIBarButtonItem *)sender{
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.fromValue = @(M_PI/2);
    rotation.toValue = @(0);
    rotation.duration = 1.0;
    rotation.repeatCount = 2;
    [animationView.layer addAnimation:rotation forKey:@"Rocket"];
}

-(void)scaleAction:(UIBarButtonItem *)sender{
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.fromValue = @(1);
    scale.toValue = @(0);
    scale.duration = 1.0;
    scale.repeatCount = 2;
    scale.autoreverses = YES;
    [animationView.layer addAnimation:scale forKey:@"Rocket"];
}

-(void)nextAction:(UIButton *)sender{
    [self.navigationController pushViewController:[KeyframeAnimationController new] animated:YES];
    
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
