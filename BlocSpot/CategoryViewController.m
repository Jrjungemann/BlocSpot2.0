//
//  CategoryViewController.m
//  BlocSpot
//
//  Created by Jonathan Jungemann on 2/8/15.
//  Copyright (c) 2015 Jon Jungemann. All rights reserved.
//

#import "CategoryViewController.h"
#import "AppDelegate.h"
#import "CoreData+MagicalRecord.h"

@interface CategoryViewController ()

@property UITableView *categoryList;

@end

@implementation CategoryViewController

- (void)loadView {
    self.view = [UIView new];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    NSInteger viewWidth = screenBounds.size.width;
    NSInteger viewHeight = screenBounds.size.height;
    
    self.categoryList = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, viewWidth, 396)];
    self.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    
    UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    background.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:background];
    [self.view addSubview:self.categoryList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.categoryList.delegate = self;
    self.categoryList.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

@end
