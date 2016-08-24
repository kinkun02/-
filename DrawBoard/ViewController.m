//
//  ViewController.m
//  DrawBoard
//
//  Created by Ibokan on 16/6/21.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "ViewController.h"
#import "DrawBoardView.h"
@interface ViewController ()
{
    DrawBoardView *drawBoardView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    drawBoardView = [[DrawBoardView alloc]initWithFrame:self.view.frame];
    
    [self.view insertSubview:drawBoardView atIndex:0];
}
- (IBAction)xuxian:(UIButton *)sender {
    sender.selected = !sender.selected;
    drawBoardView.isXuxian = sender.selected;
}
- (IBAction)colorAction:(UIButton *)sender {
    drawBoardView.strokeColor = sender.backgroundColor;
    for (id view in self.view.subviews) {
        if ([view isMemberOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            btn.layer.borderWidth = 0;
        }
    }
    sender.layer.borderWidth = 3;
    sender.layer.borderColor = [UIColor blackColor].CGColor;
}
- (IBAction)sliderAction:(UISlider *)sender {
    drawBoardView.lineWidth = sender.value;
}
- (IBAction)redoAction:(id)sender {
    [drawBoardView.lineArray removeLastObject];
    [drawBoardView setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
