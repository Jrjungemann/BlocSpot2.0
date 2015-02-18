//
//  Category.h
//  BlocSpot
//
//  Created by Jonathan Jungemann on 2/4/15.
//  Copyright (c) 2015 Jon Jungemann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class InterestPoint;

@interface InterestPointCategory : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) id color;
@property (nonatomic, retain) NSSet *pointsOfInterest;
@end

@interface InterestPointCategory (CoreDataGeneratedAccessors)

- (void)addPointsOfInterestObject:(InterestPoint *)value;
- (void)removePointsOfInterestObject:(InterestPoint *)value;
- (void)addPointsOfInterest:(NSSet *)values;
- (void)removePointsOfInterest:(NSSet *)values;

@end
