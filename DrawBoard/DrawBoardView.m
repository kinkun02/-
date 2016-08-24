//
//  DrawBoardView.m
//  DrawBoard
//
//  Created by Ibokan on 16/6/21.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import "DrawBoardView.h"

@implementation DrawBoardView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _pointArray = [NSMutableArray array];
        _strokeColor = [UIColor blackColor];
        _isXuxian = NO;
        _lineWidth = 1;
        _lineDic = [NSMutableDictionary dictionary];
        _lineArray = [NSMutableArray array];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef palette = UIGraphicsGetCurrentContext();
    
    //绘制旧的线条
    for (NSMutableDictionary *dic in _lineArray) {
        NSArray *points = dic[@"pointArray"];
        UIColor *color = dic[@"strokeColor"];
        BOOL Xuxian = [dic[@"Xuxian"]  boolValue];
        CGFloat width =[dic[@"lineWidth"]floatValue];
        CGContextSetStrokeColorWithColor(palette, color.CGColor);
        CGContextSetLineWidth(palette, width);
        if (Xuxian) {
            CGFloat length[] = {10,10};
            CGContextSetLineDash(palette, 0, length, 2);
        }else{
            CGContextSetLineDash(palette, 0, NULL, 0);
        }
        if (points.count > 0) {
            CGContextMoveToPoint(palette, [points[0] CGPointValue].x, [points[0]CGPointValue].y);
        }
        for (int i=0; i<points.count; i++) {
            CGPoint point = [points[i] CGPointValue];
            CGContextAddLineToPoint(palette, point.x, point.y);
        }
        CGContextStrokePath(palette);
    }
    
    //绘制新的线条
    CGContextSetStrokeColorWithColor(palette, _strokeColor.CGColor);
    CGContextSetLineWidth(palette, _lineWidth);
    if (_isXuxian) {
        CGFloat lengths[] = {10,10};
        CGContextSetLineDash(palette, 0, lengths, 2);
    }else{
        CGContextSetLineDash(palette, 0, NULL, 0);
    }
    if (_pointArray.count > 0) {
        CGContextMoveToPoint(palette, [_pointArray[0]CGPointValue].x, [_pointArray[0]CGPointValue].y);
    }
    for (int i=0; i<_pointArray.count; i++) {
        CGContextAddLineToPoint(palette, [_pointArray[i]CGPointValue].x, [_pointArray[i]CGPointValue].y);
    }
    CGContextStrokePath(palette);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject]locationInView:self];
    //将点装进点数组内,因为点事一个结构体,无法直接装入NSArray类型,所以需要使用NSValue来封装
    [_pointArray addObject:[NSValue valueWithCGPoint:point]];
    //将点数组装进字典
    [_lineDic setObject:_pointArray forKey:@"pointArray"];
    //开始是已可确定虚实线,线条颜色,线条宽度,然后装进字典
    [_lineDic setObject:[NSNumber numberWithBool:_isXuxian] forKey:@"Xuxian"];
    [_lineDic setObject:_strokeColor forKey:@"strokeColor"];
    [_lineDic setObject:[NSNumber numberWithFloat:_lineWidth] forKey:@"lineWidth"];
    
    [self setNeedsDisplay];
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject]locationInView:self];
    [_pointArray addObject:[NSValue valueWithCGPoint:point]];
    [self  setNeedsDisplay];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject]locationInView:self];
    [_pointArray addObject:[NSValue valueWithCGPoint:point]];
    [self setNeedsDisplay];
    
    [_lineArray addObject:_lineDic];
    //将之前的数据初始化
    _pointArray = [NSMutableArray array];
    _lineDic = [NSMutableDictionary dictionary];
}

@end
