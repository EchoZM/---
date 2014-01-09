//
//  JD_DataManager.m
//  京东商城
//
//  Created by TY on 14-1-8.
//  Copyright (c) 2014年 张闽. All rights reserved.
//

#import "JD_DataManager.h"
static JD_DataManager *shareGoodsDataManager = nil;

@implementation JD_DataManager
+(JD_DataManager *)shareGoodsDataManager
{
    @synchronized(self){
        if (shareGoodsDataManager == nil) {
            shareGoodsDataManager = [[JD_DataManager alloc]init];
        }
    }
    return shareGoodsDataManager;
}

-(id)init
{
    if (self) {
        self=[super init];
        _goodsID = [[NSString alloc]init];
    }
    return self;
}

@end
