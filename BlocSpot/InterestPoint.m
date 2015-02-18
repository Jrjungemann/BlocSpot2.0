//
//  InterestPoint.m
//  BlocSpot
//
//  Created by antonio.carella@me.com on 2/8/15.
//  Copyright (c) 2015 Jon Jungemann. All rights reserved.
//

#import "InterestPoint.h"
#import "Comment.h"
#import "InterestPointCategory.h"
#import <CoreLocation/CoreLocation.h>


@implementation InterestPoint

@dynamic name;
@dynamic xCoordinate;
@dynamic yCoordinate;
@dynamic category;
@dynamic comments;
@synthesize coordinate;
@synthesize title;

- (CLLocationCoordinate2D)coordinate {
    CLLocationCoordinate2D cor = CLLocationCoordinate2DMake([self.xCoordinate doubleValue],
                                                            [self.yCoordinate doubleValue]);
    return cor;
}

- (void)setxCoordinate:(CLLocationCoordinate2D)newCoordinate {
    NSNumber *xCoord = [NSNumber numberWithDouble: newCoordinate.latitude];
    self.xCoordinate = xCoord;
}

- (void)setyCoordinate:(CLLocationCoordinate2D)newCoordinate {
    NSNumber *yCoord = [NSNumber numberWithDouble: newCoordinate.longitude];
    self.xCoordinate = yCoord;
}


@end
