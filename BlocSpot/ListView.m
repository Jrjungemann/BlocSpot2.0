//
//  ListView.m
//  BlocSpot
//
//  Created by Jonathan Jungemann on 2/6/15.
//  Copyright (c) 2015 Jon Jungemann. All rights reserved.
//

#import "ListView.h"
#import "AppDelegate.h"

@interface ListView ()

@property UITableView *listView;


@end

@implementation ListView

- (void)loadView {
    self.view = [UIView new];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    NSInteger viewWidth = screenBounds.size.width;
    NSInteger viewHeight = screenBounds.size.height;
    
    self.listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    
    UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    background.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:background];
    [self.view addSubview:self.listView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
