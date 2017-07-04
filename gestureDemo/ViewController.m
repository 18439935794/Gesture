//
//  ViewController.m
//  gestureDemo
//
//  Created by weifangzou on 2017/7/3.
//  Copyright © 2017年 Ttpai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CGRect redViewRect;
    UILabel *redLabel;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //添加一个红色的view
    redLabel = [[UILabel alloc]init];
    redLabel.frame = CGRectMake(100, 150, 200, 200);
    redLabel.backgroundColor = [UIColor redColor];
    redLabel.tag = 1001;
    redLabel.userInteractionEnabled = YES;
    redLabel.numberOfLines = 0;
    [self.view addSubview:redLabel];
    
   
    // 1.点击

    [self addTapGestureWithTarget:redLabel];
    // 2.平移
    [self addPanGestureWithView:redLabel];
//    // 3.轻扫
//    [self addSwipeGestureWithView:redLabel];
//    // 4.捏合
//    [self addPinchGestureWithView:redLabel];
//    // 5.边缘滑入
//    [self addScreenEdgePanGestureWithView:redLabel];
//    // 6.旋转
//    [self addRotationGestureWithView:redLabel];
//    // 7.长按
    [self addLongPressGestureWithView:redLabel];
    
   
    
    
    
}
#pragma mark--七种手势
#pragma mark--------------------------------1,tap(点击)------------------------------
- (void)addTapGestureWithTarget:(id)sender {
//    for (int i = 1; i < 6; i++) {
    
        //1,tap(点击)
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
        //手势点击次数
        tapGesture.numberOfTapsRequired = 1;
        //点击手指数量
        tapGesture.numberOfTouchesRequired = 1;
        //将手势识别器添加到view上
        [sender addGestureRecognizer:tapGesture];
//    }


}
//点击
-(void)tapGestureAction:(UITapGestureRecognizer*)gesture
{
    NSLog(@"%s",__FUNCTION__);
    UILabel *tempLabel = [self.view  viewWithTag:1001];
    NSInteger tapCount = gesture.numberOfTapsRequired;//点击次数
    NSInteger touchCount = gesture.numberOfTouchesRequired;//手指个数
    tempLabel.text = [NSString stringWithFormat:@"手指个数:%ld  点击次数:%ld",(long)touchCount,(long)tapCount];
    
}
#pragma mark-------------------------2,pan(平移)---------------------------------------
- (void)addPanGestureWithView:(id)sender {
    //2,pan(平移)
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureAction:)];
    panGesture.minimumNumberOfTouches = 1;//最少点击次数---
    [redLabel addGestureRecognizer:panGesture];
}
//平移
-(void)panGestureAction:(UIPanGestureRecognizer*)gesture
{
    switch (gesture.state)
    {
            //开始
        case UIGestureRecognizerStateBegan:
        {
            NSLog(@"开始");
        }
            break;
            //改变
        case UIGestureRecognizerStateChanged:
        {
            //1,改变redView的frame
            UILabel *redView = (UILabel *)gesture.view;
            //2,改变的坐标-移动的距离
            CGPoint point = [gesture translationInView:redView];
            
            NSLog(@"%@",NSStringFromCGPoint(point));
            //3,根据移动的距离改变redView的frame
            //CGRectOffset - 根据偏移量改变view的x值和y值
            //dx dy,每次偏移量
            //x = x+dx
            //y = y+dy
            
            redView.frame = CGRectOffset(redView.frame, point.x, point.y);
            
            //清空偏移量的累加值
            [gesture setTranslation:CGPointZero inView:redView];
        }
            break;
            //结束
        case UIGestureRecognizerStateEnded:
        {
            NSLog(@"结束");
        }
            break;
            
        default:
            break;
    }
    NSLog(@"%s",__FUNCTION__);
    
}
#pragma mark-----------------------3,swipe(轻扫)---------------------------------
- (void)addSwipeGestureWithView:(UIView *)aView {
    //3,swipe(轻扫)
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureAction:)];
    swipeGesture.numberOfTouchesRequired = 1;
    //8个方向
    //direction - 方向
    /*
     typedef NS_OPTIONS(NSUInteger, UISwipeGestureRecognizerDirection) {
     UISwipeGestureRecognizerDirectionRight = 1 << 0,
     UISwipeGestureRecognizerDirectionLeft  = 1 << 1,
     UISwipeGestureRecognizerDirectionUp    = 1 << 2,
     UISwipeGestureRecognizerDirectionDown  = 1 << 3
     };
     UISwipeGestureRecognizerDirectionLeft|UISwipeGestureRecognizerDirectionUp = 6
     UISwipeGestureRecognizerDirectionRight|UISwipeGestureRecognizerDirectionDown = 9
     UISwipeGestureRecognizerDirectionLeft|UISwipeGestureRecognizerDirectionDown = 10
     UISwipeGestureRecognizerDirectionRight|UISwipeGestureRecognizerDirectionUp = 5
     */
//    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight|UISwipeGestureRecognizerDirectionDown;
    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight|UISwipeGestureRecognizerDirectionUp;

    [self.view addGestureRecognizer:swipeGesture];
    
}
//轻扫
-(void)swipeGestureAction:(UISwipeGestureRecognizer*)gesture
{
    NSLog(@"%s",__FUNCTION__);
    int  direction = gesture.direction;
    UILabel * tempLabel = [self.view viewWithTag:1001];
    if (direction == 1) {
        tempLabel.text = [NSString stringWithFormat:@"滑动方向：右"];
    }else if (direction == 2){
        tempLabel.text = [NSString stringWithFormat:@"滑动方向：左"];
    
    }else if (direction == 3){
        tempLabel.text = [NSString stringWithFormat:@"滑动方向：上"];
        
    }else if (direction == 4){
        tempLabel.text = [NSString stringWithFormat:@"滑动方向：下"];
        
    }
}
#pragma mark-----------------------4,pinch捏和-------------------------------------
- (void)addPinchGestureWithView:(UIView *)aView {

    //4,pinch捏和
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchGestureAction:)];
    [redLabel addGestureRecognizer:pinchGesture];
    
}
//捏合
-(void)pinchGestureAction:(UIPinchGestureRecognizer*)gesture
{
    switch (gesture.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            //手势开始
            //记录,当前view的frame,作为原始frame
            redViewRect = gesture.view.frame;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            //1,拿到view
            UIView *redView = gesture.view;
            //2,改变view的frame
            
            //scale 缩放后的比例,跟1(原来的frame)
            CGFloat dx = CGRectGetWidth(redViewRect)*(1-gesture.scale);
            CGFloat dy = CGRectGetHeight(redViewRect)*(1-gesture.scale);
            
            //dx dy 缩放的偏移量
            //x = x+dx
            //y = y+dy
            //w = w + 2dx
            //h = h + 2dy
            redView.frame = CGRectInset(redViewRect, dx, dy);
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    
}
#pragma mark---------------------5,ScreenEdgePan边缘划入--------------------------------
- (void)addScreenEdgePanGestureWithView:(UIView *)aView {

    //5,ScreenEdgePan边缘划入
    UIScreenEdgePanGestureRecognizer *sePanGesture = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(seGestureAction:)];
    //划入的位置-(边缘的位置)
    sePanGesture.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:sePanGesture];

}

//边缘划入
-(void)seGestureAction:(UIScreenEdgePanGestureRecognizer*)gesture
{
    NSLog(@"%s",__FUNCTION__);
}
#pragma mark----------------------6,rotation旋转---------------------------------------
- (void)addRotationGestureWithView:(UIView *)aView {
    //6,rotation旋转
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotationGestureAction:)];
    [redLabel addGestureRecognizer:rotationGesture];
}
//旋转
-(void)rotationGestureAction:(UIRotationGestureRecognizer*)gesture
{
    CGFloat  rotation = gesture.rotation;//旋转的弧度
    CGFloat velocity = gesture.velocity;//旋转速度 (radians/second)
    gesture.view.transform = CGAffineTransformMakeRotation(rotation);
    UILabel *tempLabel = [self.view  viewWithTag:1001];
    tempLabel.text = [NSString stringWithFormat:@"旋转弧度：%f  旋转速度：%f",rotation,velocity];
    
//    switch (gesture.state)
//    {
//        case UIGestureRecognizerStateBegan:
//        {
//            
//        }
//            break;
//        case UIGestureRecognizerStateChanged:
//        {
//            //旋转-根据旋转角度
//            gesture.view.transform = CGAffineTransformMakeRotation(gesture.rotation);
//        }
//            break;
//        case UIGestureRecognizerStateEnded:
//        {
//            //恢复-默认状态
//            //CGAffineTransformIdentity 默认
//            gesture.view.transform = CGAffineTransformIdentity;
//        }
//            break;
//            
//        default:
//            break;
//    }
}
#pragma mark ----------------7,longPress长按-----------------------
- (void)addLongPressGestureWithView:(UIView *)aView {

    //7,longPress长按
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
    longPress.numberOfTouchesRequired = 1;//手指个数
    longPress.minimumPressDuration = 2;//按的最少时长
//    longPress.allowableMovement = 1; //两个手指之间的距离
    [redLabel addGestureRecognizer:longPress];

}
//UIGestureRecognizer 所有手势抽象父类

-(void)longPressAction:(UILongPressGestureRecognizer *)gesture
{
    NSLog(@"%s",__FUNCTION__);
    //弹出menu
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            //UIMenuController menu控制器
            //系统的粘贴复制的小弹框
            //menuController  单例
            UIMenuController *ctr = [UIMenuController sharedMenuController];
            //menu按钮
            UIMenuItem *mItem = [[UIMenuItem alloc]initWithTitle:@"长按自定义" action:@selector(longPressMenuAction)];
            
            
            UIMenuItem *mItem1 = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(copy:)];
            UIMenuItem *mItem2 = [[UIMenuItem alloc]initWithTitle:@"粘贴" action:@selector(paste:)];
            //将item添加到controller中
            ctr.menuItems = [NSArray  arrayWithObjects:mItem,mItem1,mItem2,nil];//@[mItem,mItem1,mItem2];
            
            //获得手指点击的位置
            CGPoint point = [gesture locationInView:gesture.view];
            //设置显示的位置
            [ctr setTargetRect:CGRectMake(point.x, point.y, 0, 0) inView:gesture.view];
            //显示menu工具条
            [ctr setMenuVisible:YES animated:YES];
            
        }
            break;
        default:
            break;
    }
}

-(void)longPressMenuAction
{
    NSLog(@"menuItem点击");
    //获取粘贴板单例并把Cell中的文本值赋入
    [[UIPasteboard generalPasteboard] setString:redLabel.text];
}

//menu工具条,必须添加方法
-(BOOL)canBecomeFirstResponder
{
    return YES;
}

//可以执行的方法
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(longPressMenuAction)||action == @selector(copy:)||action == @selector(paste:)) {
        return YES;
    }
    return NO;
}


//摇晃
/*

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"摇一摇开始");
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"摇一摇结束");
}
 
*/
//编辑
- (void)cut:(nullable id)sender
{
    NSLog(@"%s",__FUNCTION__);

}
- (void)copy:(UIMenuController *)menu {
    NSLog(@"%s",__FUNCTION__);
    [[UIPasteboard generalPasteboard] setString:redLabel.text];

}
//- (void)copy:(nullable id)sender {
//    NSLog(@"%s",__FUNCTION__);
//
//}
- (void)paste:(UIMenuController *)menu
{
    // 将粘贴板的文字赋值给label
    redLabel.text = [UIPasteboard generalPasteboard].string;
}
//- (void)paste:(nullable id)sender {
//    NSLog(@"%s",__FUNCTION__);
//
//}

- (void)select:(nullable id)sender
{
    NSLog(@"%s",__FUNCTION__);

}

- (void)selectAll:(nullable id)sender {
    NSLog(@"%s",__FUNCTION__);

}

- (void)delete:(nullable id)sender {
    NSLog(@"%s",__FUNCTION__);

}


@end
