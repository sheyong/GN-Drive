//
//  TDSAboutViewController.m
//  TwinDriveSystem
//
//  Created by 自 己 on 12-3-29.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import "TDSAboutViewController.h"

@interface TDSAboutViewController ()
- (void)setDataSource;
@end

@implementation TDSAboutViewController

@synthesize tableView = _tableView;
- (void)dealloc{
    [_aboutArray release];
    self.tableView = nil;
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"关于街拍控";
    
    [self setDataSource];

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight;    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.tableView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - Pirvate
- (void)setDataSource{
    _aboutArray = [[NSArray alloc] initWithObjects:@"版本",@"意见反馈",@"联系方式", nil];
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *message = [_aboutArray objectAtIndex:indexPath.row];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_aboutArray != nil && [_aboutArray count]>0)
        return [_aboutArray count];
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    
	if(_aboutArray != nil && [_aboutArray count]>0)
	{
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.textLabel.font = [UIFont fontWithName:@"Arial" size:17.0];
		cell.textLabel.textAlignment = UITextAlignmentLeft;
		NSString *aboutText = [_aboutArray objectAtIndex:indexPath.row];
		cell.textLabel.text = [NSString stringWithFormat:@"%@",aboutText];
	}
	return cell;
}
@end
