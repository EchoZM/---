//
//  JD_DataManager.h
//  京东商城
//
//  Created by TY on 14-1-8.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JD_DataManager : NSObject{
    NSMutableArray *UserManage;
}
@property(nonatomic,retain)NSString *goodsID;//商品的id
@property(nonatomic,assign)BOOL UserState;//用户状态
@property(nonatomic,assign)BOOL UserRegisterState;//用户注册状态
+(JD_DataManager *)shareGoodsDataManager;
-(NSMutableArray *)UserManage;
@end
