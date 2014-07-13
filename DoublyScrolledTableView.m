//
//  DoublyScrolledTableView.m
//  DoublyScrolledTableView
//
//  Created by John Newman on 11/19/13.
//  Copyright (c) 2013 John Newman. All rights reserved.
//

#import "DoublyScrolledTableView.h"


@implementation DoublyScrolledTableView

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame columnHeaderHeightRatio:0.2f rowHeaderWidthRatio:0.2f detailContentSize:CGSizeMake(200.0f, 200.0f)];
}

- (id)initWithFrame:(CGRect)frame columnHeaderHeightRatio:(CGFloat)columnHeaderHeight rowHeaderWidthRatio:(CGFloat)rowHeaderWidth detailContentSize:(CGSize)detailContentSize
{
    if (self = [super initWithFrame:frame])
    {
        self.clipsToBounds = YES;
        _columnHeaderHeightRatio = columnHeaderHeight;
        _rowHeaderWidthRatio = rowHeaderWidth;
        _detailContentSize = detailContentSize;
        [self setupFrames];
    }
    return self;
}

- (void)setupFrames
{
    CGRect frame = self.bounds;
    
    frame.origin.x = frame.size.width * _rowHeaderWidthRatio;
    frame.size.width *= (1.0f - _rowHeaderWidthRatio);
    frame.size.height *= _columnHeaderHeightRatio;
    self.columnHeaderScrollView = [[UIScrollView alloc] initWithFrame:frame];
    _columnHeaderScrollView.contentSize = CGSizeMake(_detailContentSize.width, frame.size.height);
    _columnHeaderScrollView.backgroundColor = [UIColor yellowColor];
    _columnHeaderScrollView.delegate = self;
    _columnHeaderScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_columnHeaderScrollView];
    
    
    frame = self.bounds;
    frame.origin.y = frame.size.height * _columnHeaderHeightRatio;
    frame.size.width *= _rowHeaderWidthRatio;
    frame.size.height *= (1.0f - _columnHeaderHeightRatio);
    self.rowHeaderTableView = [[UITableView alloc] initWithFrame:frame];
    _rowHeaderTableView.backgroundColor = [UIColor purpleColor];
    [self addSubview:_rowHeaderTableView];
    
    
    headerOverlayScrollView = [[UIScrollView alloc] initWithFrame:frame];
    headerOverlayScrollView.contentSize = CGSizeMake(frame.size.width, _detailContentSize.height);
    headerOverlayScrollView.delegate = self;
    headerOverlayScrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:headerOverlayScrollView];
    
    
    frame = self.bounds;
    frame.origin.x = frame.size.width * _rowHeaderWidthRatio;
    frame.origin.y = frame.size.height * _columnHeaderHeightRatio;
    frame.size.width = _detailContentSize.width;
    frame.size.height *= (1.0f - _columnHeaderHeightRatio);
    self.detailTableView = [[UITableView alloc] initWithFrame:frame];
    _detailTableView.backgroundColor = [UIColor greenColor];
    [self addSubview:_detailTableView];
    
    
    frame = self.frame;
    frame.origin.x = frame.size.width * _rowHeaderWidthRatio;
    frame.origin.y = frame.size.height * _columnHeaderHeightRatio;
    frame.size.width *= (1.0f - _rowHeaderWidthRatio);
    frame.size.height *= (1.0f - _columnHeaderHeightRatio);
    detailOverlayScrollView = [[UIScrollView alloc] initWithFrame:frame];
    detailOverlayScrollView.contentSize = _detailContentSize;
    detailOverlayScrollView.delegate = self;
    detailOverlayScrollView.showsHorizontalScrollIndicator = NO;
    detailOverlayScrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:detailOverlayScrollView];
    
    
    frame = self.bounds;
    frame.size.width *= _rowHeaderWidthRatio;
    frame.size.height *= _columnHeaderHeightRatio;
    self.cornerView = [[UIView alloc] initWithFrame:frame];
    _cornerView.backgroundColor = [UIColor redColor];
    [self addSubview:_cornerView];
}

- (void)setDelegate:(id<DoublyScrolledTableViewDelegate>)delegate
{
    _delegate = delegate;
    if ([_delegate respondsToSelector:@selector(doublyScrolledTableView:layoutColumnHeaderScrollView:)])
        [_delegate doublyScrolledTableView:self layoutColumnHeaderScrollView:_columnHeaderScrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == detailOverlayScrollView)
    {
        _detailTableView.contentOffset = detailOverlayScrollView.contentOffset;
        _rowHeaderTableView.contentOffset = CGPointMake(0, detailOverlayScrollView.contentOffset.y);
        _columnHeaderScrollView.contentOffset = CGPointMake(detailOverlayScrollView.contentOffset.x, 0);
    }
    else if (scrollView == headerOverlayScrollView)
    {
        //Only set the Y offset, keep the X the way it was.  Setting this on the overlay scroll view recall this method and update the data table view.
        detailOverlayScrollView.contentOffset = CGPointMake(detailOverlayScrollView.contentOffset.x, headerOverlayScrollView.contentOffset.y);
    }
    else if (scrollView == _columnHeaderScrollView)
    {
        //Only set the X offset, keep the Y the way it was.  Setting this on the overlay scroll view recall this method and update the data table view.
        detailOverlayScrollView.contentOffset = CGPointMake(_columnHeaderScrollView.contentOffset.x, detailOverlayScrollView.contentOffset.y);
    }
}

@end
