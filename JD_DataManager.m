//
//  JD_DataManager.m
//  京东商城
//
//  Created by TY on 14-1-8.
//  Copyright (c) 2014年 张闽. All rights reserved.
//

#import "JD_DataManager.h"
static JD_DataManager *shareGoodsDataManager = nil;
#define ip @"http://192.168.1.119/shop/"

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
        _OrderArray = [[NSMutableArray alloc]init];
    }
    return self;
    
}

-(UIImage *)getgoodsImage:(NSString *)imageString
{
    NSURL *imageURL = [NSURL URLWithString:[[ip stringByAppendingString:@"goodsimage/"] stringByAppendingString:imageString]];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *goodsImage = [UIImage imageWithData:imageData];
    return goodsImage;
}

-(NSURLRequest *)requestWithURLString:(NSString *)string
{
    NSString *urlString = [[[ip stringByAppendingString:@"html/"] stringByAppendingString:[JD_DataManager shareGoodsDataManager].goodsID] stringByAppendingString:string];
    NSURLRequest *lRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    return lRequest;
}

-(void)downloadDataWithHTTPMethod:(NSString *)method WithBodyString:(NSString *)bodystring WithURLString:(NSString *)urlstring AndSuccess:(void (^)(NSData *))success AndFailed:(void (^)(void))failed
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        NSURL *lURL = [NSURL URLWithString:[ip stringByAppendingString:urlstring]];
        NSMutableURLRequest *lRequest = [NSMutableURLRequest requestWithURL:lURL];
        [lRequest setHTTPMethod:method];
        [lRequest setHTTPBody:[bodystring dataUsingEncoding:NSUTF8StringEncoding]];
        NSData *lData = [NSURLConnection sendSynchronousRequest:lRequest returningResponse:nil error:nil];
        if (lData == nil) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                failed();
            });
            return ;
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            success(lData);
        });
    }); 
}

//用户信息
-(NSMutableArray *)UserManage{
    return UserManage;
}
@end
