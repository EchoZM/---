//
//  TakeDeliveryAddressManage.h
//  京东商城
//
//  Created by TY on 14-1-13.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TakeDeliveryAddressManage : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_infoviewArray;
    UITableView *_tableView;
}

@end
