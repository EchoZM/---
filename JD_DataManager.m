//
//  JD_DataManager.m
//  京东商城
//
//  Created by TY on 14-1-8.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import "JD_DataManager.h"
static JD_DataManager *shareGoodsDataManager = nil;
#define ip @"http://192.168.1.138/shop/"

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
        _userID = [[NSString alloc]init];
        _cartID = [[NSString alloc]init];
        UserManage = [[NSMutableArray alloc]init];
    }
    return self;
    
}

-(UIImage *)getgoodsImage:(NSString *)imageString
{
    NSURL *imageURL = [NSURL URLWithString:[[ip stringByAppendingString:@"goodsimage/"] stringByAppendingString:imageString]];
    NSData *lData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *goodsImage = [UIImage imageWithData:lData];
    return goodsImage;
}

-(NSData *)downloadDataWithBody:(NSString *)body URL:(NSString *)urlString
{
    NSString *bodyString = body;
    NSURL *lURL = [NSURL URLWithString:[ip stringByAppendingString:urlString]];
    NSMutableURLRequest *lRequest = [NSMutableURLRequest requestWithURL:lURL];
    [lRequest setHTTPMethod:@"post"];
    [lRequest setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    NSData *lData = [NSURLConnection sendSynchronousRequest:lRequest returningResponse:nil error:nil];
    return lData;
}

//用户信息
-(NSMutableArray *)UserManage{
    return UserManage;
}
@end
