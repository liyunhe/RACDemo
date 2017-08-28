//
//  ViewController.m
//  RACDemo
//
//  Created by Mrlee on 2017/8/24.
//  Copyright © 2017年 Mrlee. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC.h>
#import "Person.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property(nonatomic,strong)Person *p;
@end

@implementation ViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.p.name = [NSString stringWithFormat:@"mrlee %05d",arc4random_uniform(200)];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self demo5];
//    [self demo3];
////    kvo
//    _p = [[Person alloc]init];
////    对P监听
//    [RACObserve(self.p, name)subscribeNext:^(id  _Nullable x) {
//        NSLog(@"x is value  %@",x);
//    }];
    
    
    
    
//    RACDynamicSignal： 动态信号
//    didSubscribe
//    nextBlock 
    
//     创建信号的时候干了2件事情 第一创建了RACDynamicSignal 2 保存一个block didSubscribe
//    创建信号前必须要 先订阅
    
//    创建冷信号
//    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        NSLog(@"创建信号");
//        [subscriber sendNext:@"发送信号已经收到"];
//        NSLog(@"发送信号");
//        return nil;
//        
//    }];
////    订阅信号 （热信号）
////    创建了订阅者
////    订阅信号的时候去执行 didSubscribe block
//    [signal subscribeNext:^(id  _Nullable x) {
////        x:信号内容
//        NSLog(@"this is %@",x);
//        NSLog(@"我订阅了信号");
//    }];
}

//1：去掉订阅代码
//结果：什么都没有
//假设的结论 我要创建信号 必须要先订阅
//2：去掉发送信号代码
//结果：创建了信号
//结论：我要订阅信号 必须先发送





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//taget
-(void)demo2{
//    信号的生成
    @weakify(self);
    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        NSLog(@"x is value %@",x);
        self.textField.text =@"你好~";
    }];
}
-(void)demo3{
    [[self.textField rac_textSignal]subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"x is value %@",x);
    }];
}
-(void)demo4{
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil]subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"ios is value %@",x);
    }];
}
-(void)demo5{
//    创建命令
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
//        input 执行命令里的内容
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"我是从命令里面发送的消息"];
            return nil;
        }];
    }];
//    执行命令
    [[command execute:@"xx"] subscribeNext:^(id  _Nullable x) {
        NSLog(@"x is value %@",x);
    }];
}
-(void)dealloc{
    NSLog(@"bay bay !");
}
@end
