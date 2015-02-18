//
//  ViewController.m
//  BlocSpot
//
//  Created by Jonathan Jungemann on 11/23/14.
//  Copyright (c) 2014 Jon Jungemann. All rights reserved.
//

#import "ViewController.h"
#import "MapViewController.h"
#import "ListView.h"
#import "CategoryViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UILabel *appTitle;

@property (strong, nonatomic) UIView *childView;

// Search Controller Properties
@property (strong, nonatomic) UITextField *searchField;
@property (strong, nonatomic) UIButton *goSearch;
@property (strong, nonatomic) UIButton *cancelSearch;
@property (strong, nonatomic) NSMutableArray *searchList;

// Navigation Buttons
@property (strong, nonatomic) UIButton *mapButton;
@property (strong, nonatomic) UIButton *searchButton;
@property (strong, nonatomic) UIButton *listButton;
@property (strong, nonatomic) UIButton *categoryButton;

//Sizing Properties
@property (nonatomic) CGRect screenBounds;
@property (nonatomic) NSInteger viewWidth;
@property (nonatomic) NSInteger viewHeight;

// Category Properties
@property (strong, nonatomic) UILabel *categoriesLabel;
@property (strong, nonatomic) UIButton *addCategory;

// View Controllers
@property (nonatomic, strong) UIViewController *currentlyVisibleController;
@property (nonatomic, strong) MapViewController *mapViewController;
@property (nonatomic, strong) ListView *listViewController;
@property (nonatomic, strong) CategoryViewController *categoryViewController;

@end

@implementation ViewController

- (id)init {
    self = [super init];
    if (self) {
        self.currentlyVisibleController = self.listViewController;
        self.mapViewController = [MapViewController new];
        self.listViewController = [ListView new];
        self.categoryViewController = [CategoryViewController new];
    }
    return self;
}

- (void)loadView {
    
    self.screenBounds = [[UIScreen mainScreen] bounds];
    
    self.viewWidth = self.screenBounds.size.width;
    
    self.viewHeight = self.screenBounds.size.height;
    
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.viewWidth, self.viewHeight)];
    
    [self.listViewController.view setFrame:CGRectMake(0, 0, self.viewWidth, self.viewHeight - 64)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.appTitle = [[UILabel alloc] init];
    self.appTitle.font = [UIFont systemFontOfSize:18];
    
    self.searchField = [[UITextField alloc] init];
    [self.searchField setReturnKeyType:UIReturnKeySearch];
    self.searchList = [[NSMutableArray alloc] init];
    
    self.childView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.viewWidth, self.viewHeight - 64)];
    
    //Create Map Button
    UIButton *mapButtons = [UIButton buttonWithType:UIButtonTypeSystem];
    UIImage *mapImage = [UIImage imageNamed:@"map_marker-50"];
    [mapButtons setImage:mapImage forState:UIControlStateNormal];
    
    //Create Search Related Buttons
    UIButton *searchButtons = [UIButton buttonWithType:UIButtonTypeSystem];
    UIImage *searchImage = [UIImage imageNamed:@"search-50"];
    [searchButtons setImage:searchImage forState:UIControlStateNormal];
    
    UIButton *goSearchs = [UIButton buttonWithType:UIButtonTypeSystem];
    goSearchs.titleLabel.text = @"Search";
    goSearchs.titleLabel.font = [UIFont systemFontOfSize:18];
    
    UIButton *cancelSearchs = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelSearchs.titleLabel.text = @"Cancel";
    cancelSearchs.titleLabel.font = [UIFont systemFontOfSize:18];
    
    //Create List Button
    UIButton *listButtons = [UIButton buttonWithType:UIButtonTypeSystem];
    UIImage *listImage = [UIImage imageNamed:@"content-50"];
    [listButtons setImage:listImage forState:UIControlStateNormal];
    
    //Create Category Related Items
    UIButton *categoryButtons = [UIButton buttonWithType:UIButtonTypeSystem];
    UIImage *categoryImage = [UIImage imageNamed:@"filter-50"];
    [categoryButtons setImage:categoryImage forState:UIControlStateNormal];
    
    UIButton *addCategory = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    self.categoriesLabel = [UILabel new];
    self.categoriesLabel.text = @"Categories";

    //Add Subviews
    [self.view addSubview:self.childView];
    [self.view addSubview:mapButtons];
    [self.view addSubview:listButtons];
    [self.view addSubview:searchButtons];
    [self.view addSubview:categoryButtons];
    [self.view addSubview:self.appTitle];
    
    self.mapButton = mapButtons;
    self.searchButton = searchButtons;
    self.listButton = listButtons;
    self.cancelSearch = cancelSearchs;
    self.goSearch = goSearchs;
    self.categoryButton = categoryButtons;
    self.addCategory = addCategory;
    
    [self addChildViewController:self.listViewController];
    [self.listViewController.view setFrame:CGRectMake(0, 0, self.viewWidth, self.viewHeight - 64)];
    [self.childView addSubview:self.listViewController.view];
    [self.listViewController didMoveToParentViewController:self];
}

- (void) viewDidLayoutSubviews {
    
    self.listButton.frame = CGRectMake(20, 30, 25, 25);
    self.mapButton.frame = CGRectMake(60, 30, 25, 25);
    self.appTitle.frame = CGRectMake((self.viewWidth / 2) - 40, 20, 80, 44);
    
    self.categoryButton.frame = CGRectMake(self.viewWidth - 40, 30, 25, 25);
    self.searchButton.frame = CGRectMake(self.viewWidth - 80, 30, 25, 25);
    
    self.searchButton.backgroundColor = [UIColor whiteColor];
    
    self.categoriesLabel.frame = CGRectMake((self.viewWidth / 2) - 45, 55, 100, 44);
    self.addCategory.frame = CGRectMake(self.viewWidth - 80, 30, 25, 25);
    
    self.cancelSearch.frame = CGRectMake(self.viewWidth * .75, 64, 60, 40);
    self.goSearch.frame = CGRectMake(self.viewWidth * .75, 64, 60, 40);
    self.searchField.frame = CGRectMake(20, 64, self.viewWidth * 0.5, 40);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.mapButton addTarget:self action:@selector(mapPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.searchButton addTarget:self action:@selector(searchOpened:) forControlEvents:UIControlEventTouchUpInside];
    [self.listButton addTarget:self action:@selector(listPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.goSearch addTarget:self action:@selector(searchPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelSearch addTarget:self action:@selector(cancelPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.categoryButton addTarget:self action:@selector(categoryPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.addCategory addTarget:self action:@selector(addCategoryPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.appTitle setText:@"BlocSpot"];
    
    [self.goSearch setTitle:NSLocalizedString(@"Search", @"Search Button") forState:UIControlStateNormal];
    [self.cancelSearch setTitle:NSLocalizedString(@"Cancel", @"Cancel Button") forState:UIControlStateNormal];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) listPressed:(UIButton *) sender {
    
    if (self.currentlyVisibleController == self.listViewController) {
        return;
    }

    [self.searchField removeFromSuperview];
    [self.goSearch removeFromSuperview];
    [self.cancelSearch removeFromSuperview];
    [self.categoriesLabel removeFromSuperview];
    [self.addCategory removeFromSuperview];
    
    [self addChildViewController:self.listViewController];
    [self.listViewController.view setFrame:CGRectMake(0, 0, self.viewWidth, self.viewHeight - 64)];
    [self.childView addSubview:self.listViewController.view];
    [self.listViewController didMoveToParentViewController:self];
    [self.view addSubview:self.searchButton];
    
    self.currentlyVisibleController = self.listViewController;
    
}

- (void)mapPressed:(UIButton *)sender {
    
    if (self.currentlyVisibleController == self.mapViewController) {
        return;
    }
    
    [self.searchField removeFromSuperview];
    [self.goSearch removeFromSuperview];
    [self.cancelSearch removeFromSuperview];
    [self.categoriesLabel removeFromSuperview];
    [self.addCategory removeFromSuperview];
    
    [self.mapViewController.view setFrame:CGRectMake(0, 0, self.viewWidth, self.viewHeight - 64)];
    [self addChildViewController:self.mapViewController];
    [self.childView addSubview:self.mapViewController.view];
    [self.mapViewController didMoveToParentViewController:self];
    [self.view addSubview:self.searchButton];
    
    self.currentlyVisibleController = self.mapViewController;

}

- (void)searchOpened:(id)sender {
    [self.searchField removeFromSuperview];
    [self.goSearch removeFromSuperview];
    [self.cancelSearch removeFromSuperview];
    
    [self.mapViewController.view setFrame:CGRectMake(0, 50, self.viewWidth, self.viewHeight - 114)];
    [self.listViewController.view setFrame:CGRectMake(0, 50, self.viewWidth, self.viewHeight - 114)];
    
    [self.view addSubview:self.goSearch];
    [self.view addSubview:self.searchField];
}

- (void)searchPressed:(id)sender {
    
    if ([self.searchField.text  isEqual: @""]) {
        return;
    }
    
    [self.goSearch removeFromSuperview];
    
    if (self.currentlyVisibleController == self.mapViewController) {
        [self.mapViewController searchMapWith:self.searchField.text];
    } //else if (self.currentlyVisibleController == self.listViewController)
    
    [self.view addSubview:self.cancelSearch];
}

- (void) cancelPressed:(id)sender {
    
    [self.cancelSearch removeFromSuperview];
    
    self.searchField.text = @"";
    
//    TODO call into MapViewController
    if (self.currentlyVisibleController == self.mapViewController) {
        [self.mapViewController cancelSearch];
    }
    
    [self.view addSubview:self.goSearch];
}

- (void) categoryPressed:(id)sender {
    
    if (self.currentlyVisibleController == self.categoryViewController) {
        return;
    }
    
    [self.goSearch removeFromSuperview];
    [self.searchButton removeFromSuperview];
    [self.searchField removeFromSuperview];
    
    [self.categoryViewController.view setFrame:CGRectMake(0, 0, self.viewWidth, self.viewHeight)];
    [self addChildViewController:self.categoryViewController];
    [self.childView addSubview:self.categoryViewController.view];
    [self.categoryViewController didMoveToParentViewController:self];
    
    [self.view addSubview:self.categoriesLabel];
    [self.view addSubview:self.addCategory];

    self.currentlyVisibleController = self.categoryViewController;
}

- (void) addCategoryPressed:(id)sender {
    
}

@end
