//
//  InterestPoint.h
//  BlocSpot
//
//  Created by antonio.carella@me.com on 2/8/15.
//  Copyright (c) 2015 Jon Jungemann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@class Comment, InterestPointCategory;

@interface InterestPoint : NSManagedObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * xCoordinate;
@property (nonatomic, retain) NSNumber * yCoordinate;
@property (nonatomic, retain) InterestPointCategory *category;
@property (nonatomic, retain) NSSet *comments;
@property (nonatomic, copy) NSString* title;

@end

@interface Coordinate : NSValueTransformer

@end

@interface InterestPoint (CoreDataGeneratedAccessors)

- (void)addCommentsObject:(Comment *)value;
- (void)removeCommentsObject:(Comment *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

@end
