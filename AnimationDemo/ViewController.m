//
//  ViewController.m
//  AnimationDemo
//
//  Created by Ibokan2 on 15/10/29.
//  Copyright (c) 2015年 Ibokan2. All rights reserved.
//

#import "ViewController.h"
#import "BlockAnimationController.h"

@interface ViewController ()
{
    UIView *animationView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(nextAction:)];
    self.navigationItem.rightBarButtonItem = next;
    
    self.navigationController.toolbarHidden = NO;
    UIBarButtonItem *playButton = [[UIBarButtonItem alloc] initWithTitle:@"做动画" style:UIBarButtonItemStylePlain target:self action:@selector(playAction:)];
    self.toolbarItems = @[playButton];
    
    animationView = [UIView new];
    animationView.translatesAutoresizingMaskIntoConstraints = NO;
    animationView.backgroundColor = [UIColor redColor];
    [self.view addSubview:animationView];
    NSArray *contraints;
    contraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-120-[animationView(==120)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(animationView)];
    [self.view addConstraints:contraints];
    
    contraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-180-[animationView(==120)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(animationView)];
    [self.view addConstraints:contraints];
    
    self.navigationItem.title = @"操作UIView制作动画";
}

-(void)playAction:(UIBarButtonItem *)sender{
    [UIView beginAnimations:nil context:nil];
    //动画时间
    [UIView setAnimationDuration:1];
    //动画次数
    [UIView setAnimationRepeatCount:FLT_MAX];
    //线性动画，动画的加速度
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    //返回动画
    [UIView setAnimationRepeatAutoreverses:NO];
    //过渡动画场景
    //    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:animationView cache:YES];
    
    //UIView的frame和transform以及alpha可以做动画
    //    animationView.frame = CGRectMake(Screen_Width-100, Screen_Height-100, 80, 80);
    //    animationView.transform = CGAffineTransformMakeRotation(M_PI/4);
    animationView.transform = CGAffineTransformRotate(animationView.transform, M_PI/4);
    
    [UIView commitAnimations];
    
    //使用代理来判断动画是否结束
    //    [UIView setAnimationDelegate:self];
    //    [UIView setAnimationDidStopSelector:@selector(animationsStopAction:)];
}

-(void)nextAction:(UIButton *)sender{
    [self.navigationController pushViewController:[BlockAnimationController new] animated:YES];
    
}

-(void)animationsStopAction:(id)sender{
    NSLog(@"动画结束");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
