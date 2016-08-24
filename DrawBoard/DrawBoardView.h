//
//  DrawBoardView.h
//  DrawBoard
//
//  Created by Ibokan on 16/6/21.
//  Copyright © 2016年 king-mo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawBoardView : UIView
@property (nonatomic,strong)NSMutableArray *pointArray;
@property (nonatomic,strong)UIColor *strokeColor;
@property (nonatomic,assign)BOOL isXuxian;
@property (nonatomic,assign)CGFloat lineWidth;
@property (nonatomic,strong)NSMutableDictionary *lineDic;
@property (nonatomic,strong)NSMutableArray *lineArray;
@end
