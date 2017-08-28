//
//  loginViewModel.h
//  RACDemo
//
//  Created by Mrlee on 2017/8/28.
//  Copyright © 2017年 Mrlee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>

@interface loginViewModel : NSObject
@property(nonatomic,strong)RACSignal *loginSignal;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *pwd;

@property(nonatomic,strong)RACCommand *logincommand;
@end
