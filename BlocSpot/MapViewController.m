//
//  MapViewController.m
//  BlocSpot
//
//  Created by Jonathan Jungemann on 12/2/14.
//  Copyright (c) 2014 Jon Jungemann. All rights reserved.
//

#import "MapViewController.h"
#import "InterestPoint.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CoreData+MagicalRecord.h"

@class InterestPoint;

@interface MapViewController ()

@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) MKUserLocation *userLocation;
@property (strong, nonatomic) NSMutableArray *annotations;
@property InterestPoint *selectedInterestPoint;

@end

@implementation MapViewController

- (void)loadView {
    self.view = [UIView new];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    NSInteger viewWidth = screenBounds.size.width;
    NSInteger viewHeight = screenBounds.size.height;
    
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    [self.locationManager requestWhenInUseAuthorization];
    
    self.userLocation = [[MKUserLocation alloc] init];
    
    self.mapView.userTrackingMode = YES;
        
    UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    background.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:background];
    [self.view addSubview:self.mapView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mapView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) searchMapWith:(NSString *) searchInfo {
    
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = searchInfo;
    request.region = _mapView.region;
    
    self.annotations = [[NSMutableArray alloc] init];
    
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse
                                         *response, NSError *error) {
        if (response.mapItems.count == 0)
            NSLog(@"No Matches");
        else
            for (MKMapItem *item in response.mapItems) {
                // create a new InterestPoint object
                
                // add interestPoint instead of item
                [self.annotations addObject:item];
                
                InterestPoint *interestPoint = [InterestPoint MR_createEntityInContext:nil];
                interestPoint.xCoordinate = [NSNumber numberWithDouble:item.placemark.coordinate.latitude];
                interestPoint.yCoordinate = [NSNumber numberWithDouble:item.placemark.coordinate.longitude];
                interestPoint.coordinate = item.placemark.coordinate;
                interestPoint.name = item.name;
                interestPoint.title = item.name;
                [self.mapView viewForAnnotation:interestPoint];
                [self.mapView addAnnotation:interestPoint];
                
            }
    }];
}

-(void)cancelSearch {
    NSArray *existingAnnotations = self.mapView.annotations;
    [self.mapView removeAnnotations:existingAnnotations];
    self.annotations = [NSMutableArray new];
    
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    /*
     When it comes time to implement the custon callout, 
     see http://stackoverflow.com/questions/15292318/mkmapview-mkpointannotation-tap-event
     */
    
    MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"loc"];
    annotationView.canShowCallout = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    self.selectedInterestPoint = (InterestPoint *)annotationView.annotation;
    
    // don't show current user location as the same pin type as POIs 
    if ([annotation isMemberOfClass:[MKUserLocation class]]) {
        return  nil;
    }
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"This is where you should have your segue happen for the %@ annotation", view.description);
    
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext){
        
        InterestPoint *selected = [InterestPoint MR_createEntity];
        selected.name = self.selectedInterestPoint.name;
        selected.xCoordinate = self.selectedInterestPoint.xCoordinate;
        selected.yCoordinate =self.selectedInterestPoint.yCoordinate;
        selected.coordinate = self.selectedInterestPoint.coordinate;
        selected.comments = self.selectedInterestPoint.comments;
        
    } completion:^(BOOL success, NSError *error) {
        
        NSLog(@"In the completion handler");
        
    }];
    
    //[self performSegueWithIdentifier:@"DetailsIphone" sender:self];

    // be sure to send the annotation object to the next view in the prepareForSegue method.
    // then create a new Interest Point object, e.g.:
    // InterestPoint *interestPoint = [InterestPoint MR_createEntityInContext:nil];
    // assign it's properties to the created interestPoint
    // then save it in a context
    
    
}

@end
