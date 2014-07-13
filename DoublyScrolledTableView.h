//
//  DoublyScrolledTableView.h
//  DoublyScrolledTableView
//
//  Created by John Newman on 11/19/13.
//  Copyright (c) 2013 John Newman. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DoublyScrolledTableViewDelegate;

@interface DoublyScrolledTableView : UIView <UIScrollViewDelegate>
{
    UIScrollView *detailOverlayScrollView;
    UIScrollView *headerOverlayScrollView;
}

@property (nonatomic, strong) UIScrollView *columnHeaderScrollView;
@property (nonatomic, strong) UITableView *rowHeaderTableView;
@property (nonatomic, strong) UITableView *detailTableView;
@property (nonatomic, strong) UIView *cornerView;

@property (nonatomic, assign) CGFloat columnHeaderHeightRatio;
@property (nonatomic, assign) CGFloat rowHeaderWidthRatio;

@property (nonatomic, assign) CGSize detailContentSize;

@property (nonatomic, weak) id<DoublyScrolledTableViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame columnHeaderHeightRatio:(CGFloat)columnHeaderHeight rowHeaderWidthRatio:(CGFloat)rowHeaderWidth detailContentSize:(CGSize)detailContentSize;

@end


@protocol DoublyScrolledTableViewDelegate <NSObject>

- (void)doublyScrolledTableView:(DoublyScrolledTableView *)dsTableView layoutColumnHeaderScrollView:(UIScrollView *)scrollView;

@end
