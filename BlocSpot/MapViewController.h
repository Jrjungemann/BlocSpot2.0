//
//  MapViewController.h
//  BlocSpot
//
//  Created by Jonathan Jungemann on 12/2/14.
//  Copyright (c) 2014 Jon Jungemann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate>

-(void)searchMapWith:(NSString *) searchInfo;
-(void)cancelSearch;

@end
