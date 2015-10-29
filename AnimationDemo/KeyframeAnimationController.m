//
//  KeyframeAnimationController.m
//  homeWork_08_30
//
//  Created by ClariS on 15/8/30.
//  Copyright (c) 2015年 ClariS. All rights reserved.
//

#import "KeyframeAnimationController.h"
#import "LayerAnimationController.h"

@interface KeyframeAnimationController ()
{
    UIView *animationView;
    CAShapeLayer *shapeLayer;
    CAShapeLayer *shapeLayer1;
}
@end

@implementation KeyframeAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(nextAction:)];
    self.navigationItem.rightBarButtonItem = next;
    self.navigationController.toolbarHidden = NO;
    
    UIBarButtonItem *playButton = [[UIBarButtonItem alloc] initWithTitle:@"震动" style:UIBarButtonItemStylePlain target:self action:@selector(playAction:)];
    UIBarButtonItem *pathButton = [[UIBarButtonItem alloc] initWithTitle:@"路径动画" style:UIBarButtonItemStylePlain target:self action:@selector(pathAction:)];
    UIBarButtonItem *path2Button = [[UIBarButtonItem alloc] initWithTitle:@"自定义路径动画" style:UIBarButtonItemStylePlain target:self action:@selector(path2Action:)];
    self.toolbarItems = @[playButton,pathButton,path2Button];
    
    animationView = [UIView new];
    animationView.translatesAutoresizingMaskIntoConstraints = NO;
    animationView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:animationView];
    NSArray *contraints;
    contraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-120-[animationView(==120)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(animationView)];
    [self.view addConstraints:contraints];
    
    contraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-180-[animationView(==120)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(animationView)];
    [self.view addConstraints:contraints];
    
    //设置成圆
    //    animationView1.layer.cornerRadius = 20;
    //绘制图片时可以显示图片圆角效果
    animationView.layer.masksToBounds = YES;
    
    self.navigationItem.title = @"CAKeyframeAnimation制作动画";
}

-(void)playAction:(UIBarButtonItem *)sender{
    /*
     动画方式的键路径
     transform                      3D旋转
     transform.rotation             旋转
     transform.translation(x,y,z)   位移
     transform.scale(x,y,z)         放大缩小
     
     position(x,y)                  位移
     */
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    keyAnimation.values = @[@0,@-10,@10,@-10,@0];
    //    keyAnimation.path
    keyAnimation.duration = 0.4;
    //固定轴心
    keyAnimation.additive = YES;
    [animationView.layer addAnimation:keyAnimation forKey:@"shake"];
}

-(void)pathAction:(UIBarButtonItem *)sender{
    CAKeyframeAnimation *path = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //起点按将要加入的view的layer层的（0，0）起计算，并非按self.view的原点开始计算
    CGRect rect = CGRectMake(-120, 0, 250, 250);
    path.path = CFAutorelease(CGPathCreateWithEllipseInRect(rect, nil));
    path.duration = 5;
    path.repeatCount = FLT_MAX;
    path.additive = YES;
    //不停顿
    path.calculationMode = kCAAnimationLinear;
    //运行试下,方形的一面总面向圆心
    path.rotationMode = kCAAnimationRotateAuto;
    [animationView.layer addAnimation:path forKey:@"Rocket"];
}

-(void)path2Action:(UIBarButtonItem *)sender{
    shapeLayer = [CAShapeLayer layer];
//    shapeLayer.frame = [UIScreen mainScreen].applicationFrame;
//    shapeLayer.bounds = [UIScreen mainScreen].bounds;
    shapeLayer.strokeColor = [UIColor cyanColor].CGColor;
    shapeLayer.lineWidth = 10;
    //线的端点为半圆，http://blog.csdn.net/iunion/article/details/26221213
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    [self.view.layer addSublayer:shapeLayer];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 5;
    animation.values = @[@(0),@(1)];
    animation.delegate = self;
    //添加animation.additive = YES;时无法做出动画
    [shapeLayer addAnimation:animation forKey:@"Rocke"];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(30, 400)];
    [bezierPath addQuadCurveToPoint:CGPointMake(30, 200) controlPoint:CGPointMake(200, 100)];
    shapeLayer.path = bezierPath.CGPath;
    
}

// 代理实现按顺序动画（自）
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        shapeLayer1 = [CAShapeLayer layer];
//        shapeLayer1.frame = CGRectMake(35, 100, 250, 200);
//        shapeLayer1.bounds = CGRectMake(35, 100, 250, 200);

        shapeLayer1.strokeColor = [UIColor cyanColor].CGColor;
        shapeLayer1.lineWidth = 10;
        shapeLayer1.lineCap = kCALineCapRound;
        //透明填充
        shapeLayer1.fillColor = [UIColor clearColor].CGColor;
        [self.view.layer addSublayer:shapeLayer1];

        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.fromValue = @(0);
        pathAnimation.toValue = @(1.0);
        pathAnimation.duration = 5;
        [shapeLayer1 addAnimation:pathAnimation forKey:@"pathAnimation"];

        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointMake(200, 200)];
        [bezierPath addLineToPoint:CGPointMake(200, 400)];
        [bezierPath addLineToPoint:CGPointMake(35, 400)];
        shapeLayer1.path = bezierPath.CGPath;
        NSLog(@"aaa");
    }

}

-(void)nextAction:(UIButton *)sender{
    [self.navigationController pushViewController:[LayerAnimationController new] animated:YES];
    
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
