//
//  loginViewModel.m
//  RACDemo
//
//  Created by Mrlee on 2017/8/28.
//  Copyright © 2017年 Mrlee. All rights reserved.
//

#import "loginViewModel.h"

@implementation loginViewModel
-(instancetype)init{
    
    if (self = [super init]) {
        [self setUp];
    }
    return self;
}
-(void)setUp{
    _loginSignal = [RACSignal combineLatest:@[RACObserve(self, userName),RACObserve(self, pwd)] reduce:^id _Nullable(NSString *userName,NSString *pwd){
        return @(userName.length&&pwd.length);
    }];
    
    _logincommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        //        密码加密
        //        发送请求
        NSLog(@"准备发送请求");
        return  [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"请求登录的数据"];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    [_logincommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [[_logincommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {
            NSLog(@"显示正在等待");
        }else{
            NSLog(@"菊花没有了");
        }
    }];

}
@end
