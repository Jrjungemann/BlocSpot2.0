//
//  Comment.h
//  BlocSpot
//
//  Created by Jonathan Jungemann on 1/26/15.
//  Copyright (c) 2015 Jon Jungemann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class InterestPoint;

@interface Comment : NSManagedObject

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) InterestPoint *interestPoint;

@end
