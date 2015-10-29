//
//  BlockAnimationController.m
//  homeWork_08_30
//
//  Created by Ibokan2 on 15/9/1.
//  Copyright (c) 2015年 ClariS. All rights reserved.
//

#import "BlockAnimationController.h"
#import "BasicAnimationController.h"

@interface BlockAnimationController ()
{
    UIView *animationView;
}
@end

@implementation BlockAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(nextAction:)];
    self.navigationItem.rightBarButtonItem = next;
    
    self.navigationController.toolbarHidden = NO;
    UIBarButtonItem *playButton = [[UIBarButtonItem alloc] initWithTitle:@"做动画" style:UIBarButtonItemStylePlain target:self action:@selector(playAction:)];
    self.toolbarItems = @[playButton];
    
    animationView = [[UIView alloc] initWithFrame:CGRectMake(20, 80, 40, 40)];
    animationView.backgroundColor = [UIColor redColor];
    [self.view addSubview:animationView];
    self.navigationItem.title = @"Block语法制作动画";
}

-(void)nextAction:(UIBarButtonItem *)sender{
    [self.navigationController pushViewController:[BasicAnimationController new] animated:YES];
}

#warning 给一个控件添加约束后，将不能让他做动画

-(void)playAction:(UIBarButtonItem *)sender{
    [UIView animateWithDuration:1.0 animations:^{
        animationView.frame = CGRectMake(200, 200, 80, 80);
    } completion:^(BOOL finished) {
        
    }];

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
