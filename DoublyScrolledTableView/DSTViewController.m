//
//  DSTViewController.m
//  DoublyScrolledTableView
//
//  Created by John Newman on 11/19/13.
//  Copyright (c) 2013 John Newman. All rights reserved.
//

#import "DSTViewController.h"

static NSString * const HeaderCellIdentifier = @"HeaderCell";
static NSString * const DetailCellIdentifier = @"DetailCell";

@interface DSTViewController ()

@end

@implementation DSTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    detailContentSize = CGSizeMake(1000, 80.0f * 40);
    
    CGRect frame = CGRectMake(30, 30, self.view.frame.size.width - 60, self.view.frame.size.height - 60);
    dstv = [[DoublyScrolledTableView alloc] initWithFrame:frame columnHeaderHeightRatio:0.1f rowHeaderWidthRatio:0.3f detailContentSize:detailContentSize];
    dstv.delegate = self;
    dstv.detailTableView.delegate = self;
    dstv.detailTableView.dataSource = self;
    dstv.rowHeaderTableView.delegate = self;
    dstv.rowHeaderTableView.dataSource = self;
    [self.view addSubview:dstv];
    
    UILabel *cornerLabel = [[UILabel alloc] initWithFrame:dstv.cornerView.frame];
    cornerLabel.textAlignment = NSTextAlignmentCenter;
    cornerLabel.text = @"corn lbl";
    [dstv.cornerView addSubview:cornerLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)doublyScrolledTableView:(DoublyScrolledTableView *)dsTableView layoutColumnHeaderScrollView:(UIScrollView *)scrollView
{
    for (NSInteger i = 0; i < 10; i++)
    {
        UIView *columnView = [[UIView alloc] initWithFrame:CGRectMake(100 * i, 0, 99, scrollView.frame.size.height)];
        columnView.backgroundColor = [UIColor magentaColor];
        UILabel *textLabel = [[UILabel alloc] initWithFrame:columnView.bounds];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.text = [NSString stringWithFormat:@"col head %d", i];
        [columnView addSubview:textLabel];
        [scrollView addSubview:columnView];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (tableView == dstv.rowHeaderTableView)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:HeaderCellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeaderCellIdentifier];
            CGRect cellFrame = cell.frame;
            cellFrame.size.width = dstv.frame.size.width * (1.0f - dstv.rowHeaderWidthRatio);
            cellFrame.size.height = 80.0f;
            cell.frame = cellFrame;
            
            cell.contentView.frame = cell.bounds;
        }
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        UILabel *textLabel = [[UILabel alloc] initWithFrame:cell.contentView.frame];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.text = [NSString stringWithFormat:@"r head %d", indexPath.row];
        [cell.contentView addSubview:textLabel];
        textLabel.backgroundColor = [UIColor lightGrayColor];
    }
    else if (tableView == dstv.detailTableView)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:DetailCellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DetailCellIdentifier];
            CGRect cellFrame = cell.frame;
            cellFrame.size.width = detailContentSize.width;
            cellFrame.size.height = 80.0f;
            cell.frame = cellFrame;
            
            cell.contentView.frame = cell.bounds;
        }
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
 
        for (NSInteger i = 0; i < 10; i++)
        {
            UIView *columnView = [[UIView alloc] initWithFrame:CGRectMake(100 * i, 0, 99, cell.frame.size.height)];
            columnView.backgroundColor = [UIColor orangeColor];
            UILabel *textLabel = [[UILabel alloc] initWithFrame:columnView.bounds];
            textLabel.textAlignment = NSTextAlignmentCenter;
            textLabel.text = [NSString stringWithFormat:@"detail %d, %d", indexPath.row, i];
            [columnView addSubview:textLabel];
            [cell.contentView addSubview:columnView];
        }
    }
    return cell;
}

@end
