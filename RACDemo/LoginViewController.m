//
//  LoginViewController.m
//  RACDemo
//
//  Created by Mrlee on 2017/8/28.
//  Copyright © 2017年 Mrlee. All rights reserved.
//

#import "LoginViewController.h"
#import <ReactiveObjC.h>
#import "loginViewModel.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property(nonatomic,strong) loginViewModel *loginMV;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginBtn.enabled = 0;
    
    RAC(self.loginMV,userName) = self.userName.rac_textSignal;
    RAC(self.loginMV,pwd) = self.passWord.rac_textSignal;
    RAC(self.loginBtn,enabled) = self.loginMV.loginSignal;
    // button
    @weakify(self);
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        NSLog(@"按钮的点击事件");
        [self.loginMV.logincommand execute:nil];
    }];
    
//    RAC(self.loginBtn,enabled) =  [RACSignal combineLatest:@[self.userName.rac_textSignal,self.passWord.rac_textSignal] reduce:^id _Nullable(NSString *userName,NSString *pwd){
//        return @(userName.length && pwd.length);
//    }];
    //    commond
//    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
//        //        密码加密
//        //        发送请求
//        NSLog(@"准备发送请求");
//        return  [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//            [subscriber sendNext:@"请求登录的数据"];
//            [subscriber sendCompleted];
//            return nil;
//        }];
//    }];
//    
//    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
//        NSLog(@"x is valua %@",x);
//    }];
//
//    [[command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
//        if ([x boolValue]) {
//            NSLog(@"显示正在等待");
//        }else{
//            NSLog(@"菊花没有了");
//        }
//    }];
//    // button
//    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        NSLog(@"按钮的点击事件");
//        [command execute:nil];
//    }];
    
    
    

}
-(loginViewModel *)loginMV{
    if (!_loginMV) {
        _loginMV = [[loginViewModel alloc]init];
    }
    return _loginMV;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
