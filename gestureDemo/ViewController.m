
/***********************************************************
 
 File name: ViewController.m
 Author:    zouweifang
 Description:
 该类是测试类
 
 History:
 2017/7/3.: Created
 
 ************************************************************/
#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>
{
    CGRect redViewRect; //记录手势开始的原始frame
    
}
/** 点击测试label */
@property (weak, nonatomic) IBOutlet UILabel *tapLabel;
/** 拖拽测试label */
@property (weak, nonatomic) IBOutlet UILabel *panLabel;
/** 轻扫测试label */
@property (weak, nonatomic) IBOutlet UILabel *swipeLabel;
/** 捏合测试Imageview */
@property (weak, nonatomic) IBOutlet UIImageView *pinchImg;
/** 旋转测试label */
@property (weak, nonatomic) IBOutlet UILabel *rotationLabel;
/** 长按测试textField */
@property (weak, nonatomic) IBOutlet UITextField *longPressTF;
/** 长按测试label */
@property (weak, nonatomic) IBOutlet UILabel *longPressLabel;

@end

@implementation ViewController
#pragma mark - Life Circle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    //   七种手势:
    
    //    1.点击
    [self addTapGestureWithTarget:self.tapLabel];
    //    2.平移
    [self addPanGestureWithView:self.panLabel];
    //    3.轻扫
    [self addSwipeGestureWithView:self.swipeLabel];
    //    4.捏合
    [self addPinchGestureWithView:self.pinchImg];
    //    5.边缘滑入
    [self addScreenEdgePanGestureWithView:self.view];
    //    6.旋转
    [self addRotationGestureWithView:self.rotationLabel];
    //    7.长按
    [self addLongPressGestureWithView:self.longPressLabel];
  /*
     注意:
      代码我是写在ViewDidLoad中，而我们知道这个方法的生命周期比较早，所以我们换个地方写或者延迟一段时间再打印，两种方法都可以得到结果(由此可以推理出我们响应者树的构造过程是在ViewDidLoad周期中来完成的，这个函数会将当前实例的构成的响应者子树合并到我们整个根树中)
   */
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSLog(@"1111111%@",_tapLabel.nextResponder);
        NSLog(@"1111111%@",_tapLabel.nextResponder.nextResponder);
        NSLog(@"1111111%@",_tapLabel.nextResponder.nextResponder.nextResponder);
        NSLog(@"1111111%@",_tapLabel.nextResponder.nextResponder.nextResponder.nextResponder);
        NSLog(@"1111111%@",_tapLabel.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder);
       
    });
    
}
#pragma mark - Private Method 私有方法

#pragma mark--七种手势
#pragma mark--------------------------------1,tap(点击)------------------------------

/**
 添加点击手势
 */
- (void)addTapGestureWithTarget:(id)sender {
    
        //1,tap(点击)
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
        //手势点击次数
        tapGesture.numberOfTapsRequired = 1;// Default is 1
        //点击手指数量
//        tapGesture.numberOfTouchesRequired = 1;// Default is 1
        //将手势识别器添加到view上
        [sender addGestureRecognizer:tapGesture];

    UITapGestureRecognizer *tapGestureD = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    //手势点击次数
    tapGesture.numberOfTapsRequired = 2;// Default is 1
    //将手势识别器添加到view上
    [sender addGestureRecognizer:tapGestureD];
    // 若同时添加两个手势的情况下，需要设置优先级
    [tapGestureD requireGestureRecognizerToFail:tapGesture];

}
/**
 点击手势的响应方法
 */
-(void)tapGestureAction:(UITapGestureRecognizer*)gesture
{
    NSLog(@"%s",__FUNCTION__);
    UILabel *tempLabel = [self.view  viewWithTag:1001];
    NSInteger tapCount = gesture.numberOfTapsRequired;//点击次数
    NSInteger touchCount = gesture.numberOfTouchesRequired;//手指个数
    tempLabel.text = [NSString stringWithFormat:@"手指个数:%ld  点击次数:%ld",(long)touchCount,(long)tapCount];
    
}
#pragma mark-------------------------2,pan(平移)---------------------------------------
/**
 添加拖拽手势
 */
- (void)addPanGestureWithView:(id)sender {
    //2,pan(平移)
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureAction:)];
    panGesture.minimumNumberOfTouches = 1;//点击时最少需要几个手指
    [sender addGestureRecognizer:panGesture];
}

/**
 拖拽手势相应方法
 */
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
            NSLog(@"改变");
            //1,改变redView的frame
            UILabel *redView = (UILabel *)gesture.view;
            //2,改变的坐标-移动的距离
            CGPoint point = [gesture translationInView:redView];
            
            NSLog(@"%@",NSStringFromCGPoint(point));
            //3,根据移动的距离改变redView的frame
            //CGRectOffset - 根据偏移量改变view的x值和y值
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

/**
 添加轻扫手势
 */
- (void)addSwipeGestureWithView:(UIView *)aView {
    //3,swipe(轻扫)
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureAction:)];
    //8个方向
    //direction - 方向
    /*
     typedef NS_OPTIONS(NSUInteger, UISwipeGestureRecognizerDirection) {
     UISwipeGestureRecognizerDirectionRight = 1 << 0,
     UISwipeGestureRecognizerDirectionLeft  = 1 << 1,
     UISwipeGestureRecognizerDirectionUp    = 1 << 2,
     UISwipeGestureRecognizerDirectionDown  = 1 << 3
     };
     UISwipeGestureRecognizerDirectionLeft|UISwipeGestureRecognizerDirectionUp
     UISwipeGestureRecognizerDirectionRight|UISwipeGestureRecognizerDirectionDown
     UISwipeGestureRecognizerDirectionLeft|UISwipeGestureRecognizerDirectionDown
     UISwipeGestureRecognizerDirectionRight|UISwipeGestureRecognizerDirectionUp
     */
    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;

    [aView addGestureRecognizer:swipeGesture];
    
}
/**
 轻扫手势响应方法
 */
-(void)swipeGestureAction:(UISwipeGestureRecognizer*)gesture
{
    NSLog(@"%s",__FUNCTION__);
    int  direction = gesture.direction;
    UILabel * tempLabel = (UILabel *)gesture.view;
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
#pragma mark-----------------------4,pinch捏合-------------------------------------

/**
 添加捏合手势
 */
- (void)addPinchGestureWithView:(UIView *)aView {

    //4,pinch捏和
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchGestureAction:)];
    [self.pinchImg addGestureRecognizer:pinchGesture];
    
}
/**
 捏合手势响应方法
 */
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
            CGFloat dx = CGRectGetWidth(redViewRect)*(1-gesture.scale); //宽度变化量
            CGFloat dy = CGRectGetHeight(redViewRect)*(1-gesture.scale);//高度变化量
            //dx dy 缩放的偏移量
    
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

/**
 添加边缘滑入手势
 */
- (void)addScreenEdgePanGestureWithView:(UIView *)aView {

    //5,ScreenEdgePan边缘划入
    UIScreenEdgePanGestureRecognizer *sePanGesture = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(seGestureAction:)];
    //划入的位置-(边缘的位置)
    /*
    typedef NS_OPTIONS(NSUInteger, UIRectEdge) {
        UIRectEdgeNone   = 0,
        UIRectEdgeTop    = 1 << 0,
        UIRectEdgeLeft   = 1 << 1,
        UIRectEdgeBottom = 1 << 2,
        UIRectEdgeRight  = 1 << 3,
        UIRectEdgeAll    = UIRectEdgeTop | UIRectEdgeLeft | UIRectEdgeBottom | UIRectEdgeRight
    }*/
    sePanGesture.edges =  UIRectEdgeLeft ;
    [aView addGestureRecognizer:sePanGesture];

}
/**
 边缘划入响应方法
 */
-(void)seGestureAction:(UIScreenEdgePanGestureRecognizer*)gesture
{
    NSLog(@"%s",__FUNCTION__);
  
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"边缘滑入" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark----------------------6,rotation旋转---------------------------------------

/**
 添加旋转手势
 */
- (void)addRotationGestureWithView:(UIView *)aView {
    //6,rotation旋转
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotationGestureAction:)];
    [aView addGestureRecognizer:rotationGesture];
}
/**
 旋转手势响应方法
 */
-(void)rotationGestureAction:(UIRotationGestureRecognizer*)gesture
{
    CGFloat  rotation = gesture.rotation;//旋转的弧度
    CGFloat velocity = gesture.velocity;//旋转速度 (radians/second)
    gesture.view.transform = CGAffineTransformMakeRotation(rotation);
    UILabel *tempLabel = (UILabel *)gesture.view;
    tempLabel.text = [NSString stringWithFormat:@"旋转弧度：%f \n 旋转速度：%f",rotation,velocity];
    

}
#pragma mark ----------------7,longPress长按-----------------------

/**
 添加长按手势
 */
- (void)addLongPressGestureWithView:(UIView *)aView {

    //7,longPress长按
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
    /* numberOfTouchesRequired这个属性保存了有多少个手指点击了屏幕,因此你要确保你每次的点击手指数目是一样的,默认值是为 0. */
    longPress.numberOfTouchesRequired = 1;//手指个数
//    longPress.minimumPressDuration = 3;//按的最少时长，Default is 0.5.
    /*最大100像素的运动是手势识别所允许的  Default is 10.*/
    longPress.allowableMovement = 10; //在手势失败之前允许的以像素为单位的最大移动量。 默认值为10.
    [aView addGestureRecognizer:longPress];

}
/**
 长按相应方法
 */
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
/*
            //自定义Menu按钮
            //menu按钮
            UIMenuItem *mItem = [[UIMenuItem alloc]initWithTitle:@"自定义" action:@selector(longPressMenuAction)];
            
            UIMenuItem *mItem1 = [[UIMenuItem alloc]initWithTitle:@"删除" action:@selector(longPressMenuAction)];
            
            //将item添加到controller中
            ctr.menuItems = [NSArray  arrayWithObjects:mItem,mItem1,nil];//
            
       */
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

/**
 自定义menu  长按响应方法
 */
-(void)longPressMenuAction
{
    NSLog(@"menuItem点击");
    self.longPressLabel.text = nil;
   
}
#pragma mark - System Delegate Method 系统自带的代理方法

/**
 menu工具条,必须添加方法
 */
-(BOOL)canBecomeFirstResponder
{
    return YES;
}
/**
 可以执行的方法
 */
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
//    if (action == @selector(longPressMenuAction)) {
//        return YES;
//    }

    if (action == @selector(copy:)||action == @selector(paste:)||action == @selector(cut:)) {
        return YES;
    }
    return NO;
}
/**
 剪切
 */
- (void)cut:(nullable id)sender
{
    NSLog(@"%s",__FUNCTION__);
    // 将label的文字存储到粘贴板
    [UIPasteboard generalPasteboard].string = self.longPressLabel.text;
    // 清空文字
    self.longPressLabel.text = nil;
}

/**
 拷贝
 */
- (void)copy:(UIMenuController *)menu {
    NSLog(@"%s",__FUNCTION__);
    [[UIPasteboard generalPasteboard] setString:self.longPressLabel.text];

}

/**
 粘贴
 */
- (void)paste:(UIMenuController *)menu
{
    // 将粘贴板的文字赋值给label
    self.longPressTF.text = [UIPasteboard generalPasteboard].string;
}

/**
 点击空白处  键盘消失
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.longPressTF resignFirstResponder];
}
#pragma mark--私有方法
- (IBAction)toPinchVC:(UIButton *)sender {
    if (self.pinchImg) {
        [self.pinchImg removeFromSuperview];

    }

}
/*
 //手势优先级
- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer*)otherGestureRecognizer

{
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer*)otherGestureRecognizer

{
    
}


*/
@end
