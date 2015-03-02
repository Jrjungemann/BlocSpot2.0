//
//  ListView.m
//  BlocSpot
//
//  Created by Jonathan Jungemann on 2/6/15.
//  Copyright (c) 2015 Jon Jungemann. All rights reserved.
//

#import "ListView.h"
#import "AppDelegate.h"
#import "InterestPoint.h"
#import "CoreData+MagicalRecord.h"

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
    
    self.listView.delegate = self;
    self.listView.dataSource = self;
    
    [NSFetchedResultsController deleteCacheWithName:@"PooCache"];
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Fetched Results Controller Code

- (void)configureCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath {
    NSLog(@"Configure Cell has Run");
    InterestPoint *interestPoint = [self.fetchedResultsController objectAtIndexPath:indexPath];
    // Update cell with interest point details
    cell.textLabel.text = interestPoint.title;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        InterestPoint *interestPoint = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            InterestPoint *localInterestPoint = [interestPoint MR_inContext:localContext];
            [localInterestPoint MR_deleteEntity];
        }];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        InterestPoint *interestPoint = [InterestPoint MR_createEntityInContext:nil];
        interestPoint.title = @"POOP";
    }
}

#pragma mark Table View Delegate & Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; {
    return [[_fetchedResultsController sections] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"InterestPointCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

#pragma mark Fetched Results Controller Delegate

- (NSFetchedResultsController *) fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    _fetchedResultsController = [InterestPoint MR_fetchAllGroupedBy:nil withPredicate:nil sortedBy:nil ascending:NO inContext:[NSManagedObjectContext MR_defaultContext]];
    
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.listView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.listView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.listView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.listView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.listView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[self.listView cellForRowAtIndexPath:indexPath]
                    atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.listView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [self.listView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.listView endUpdates];
}

@end
