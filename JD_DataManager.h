//
//  JD_DataManager.h
//  京东商城
//
//  Created by TY on 14-1-8.
//  Copyright (c) 2014年 张闽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JD_DataManager : NSObject
@property(nonatomic,retain)NSString *goodsID;//商品的id
+(JD_DataManager *)shareGoodsDataManager;

@end
