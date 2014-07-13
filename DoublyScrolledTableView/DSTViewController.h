//
//  DSTViewController.h
//  DoublyScrolledTableView
//
//  Created by John Newman on 11/19/13.
//  Copyright (c) 2013 John Newman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoublyScrolledTableView.h"


@interface DSTViewController : UIViewController <DoublyScrolledTableViewDelegate, UITableViewDelegate, UITableViewDataSource>
{
    DoublyScrolledTableView *dstv;
    CGSize detailContentSize;
}
@end
