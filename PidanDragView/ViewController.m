//
//  ViewController.m
//  PidanDragView
//
//  Created by jimushiguang on 16/10/26.
//  Copyright © 2016年 jimushiguang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,assign)BOOL isInView;

@end

@implementation ViewController{
    UIView *_dragView;
    CGPoint _beginPoint;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dragView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _dragView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_dragView];
    _dragView.userInteractionEnabled = YES;
    _isInView = NO;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.isInView == YES){
    }else
    {
        return;
    }
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:_dragView];
    //偏移量
    float offsetX = currentPosition.x - _beginPoint.x;
    float offsetY = currentPosition.y - _beginPoint.y;
    //移动后的中心坐标
    _dragView.center = CGPointMake(_dragView.center.x + offsetX, _dragView.center.y + offsetY);
    
    //x轴左右极限坐标
    if (_dragView.center.x > (_dragView.superview.frame.size.width-_dragView.frame.size.width/2))
    {
        CGFloat x = _dragView.superview.frame.size.width-_dragView.frame.size.width/2;
        _dragView.center = CGPointMake(x, _dragView.center.y + offsetY);
    }
    else if (_dragView.center.x < _dragView.frame.size.width/2)
    {
        CGFloat x = _dragView.frame.size.width/2;
        _dragView.center = CGPointMake(x, _dragView.center.y + offsetY);
    }
    
    //y轴上下极限坐标
    if (_dragView.center.y > (_dragView.superview.frame.size.height-_dragView.frame.size.height/2))
    {
        CGFloat x = _dragView.center.x;
        CGFloat y = _dragView.superview.frame.size.height-_dragView.frame.size.height/2;
        _dragView.center = CGPointMake(x, y);
    }
    else if (_dragView.center.y <= _dragView.frame.size.height/2)
    {
        CGFloat x = _dragView.center.x;
        CGFloat y = _dragView.frame.size.height/2;
        _dragView.center = CGPointMake(x, y);
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    UIView *view = [touch view];
    
    if ([view isEqual:_dragView]) {
        self.isInView = YES;
    }else{
        self.isInView = NO;
    }
    _beginPoint = [touch locationInView:_dragView];
    
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _isInView = NO;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _isInView = NO;
}

@end