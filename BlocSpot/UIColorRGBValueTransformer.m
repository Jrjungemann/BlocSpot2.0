//
//  UIColorRGBValueTransformer.m
//  BlocSpot
//
//  Created by Jonathan Jungemann on 2/8/15.
//  Copyright (c) 2015 Jon Jungemann. All rights reserved.
//

#import "UIColorRGBValueTransformer.h"

@implementation UIColorRGBValueTransformer

// Here we override the method that returns the class of objects that this transformer can convert.
+ (Class)transformedValueClass {
    return [NSData class];
}

// Here we indicate that our converter supports two-way conversions.
// That is, we need  to convert UICOLOR to an instance of NSData and back from an instance of NSData to an instance of UIColor.
// Otherwise, we wouldn't be able to beth save and retrieve values from the persistent store.
+ (BOOL)allowsReversTransformation {
    return YES;
}

// Takes a UIColor, returns an NSData
- (id)transfomedValue:(id)value {
    UIColor *color = value;
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    NSString *colorAsString = [NSString stringWithFormat:@"%f,%f,%f,%f", components[0], components[1], components[2], components[3]];
    return [colorAsString dataUsingEncoding:NSUTF8StringEncoding];
}

// Takes an NSData, returns a UIColor
- (id)reverseTransformedValue:(id)value {
    NSString *colorAsString = [[NSString alloc] initWithData:value encoding:NSUTF8StringEncoding];
    NSArray *components = [colorAsString componentsSeparatedByString:@","];
    CGFloat r = [[components objectAtIndex:0] floatValue];
    CGFloat g = [[components objectAtIndex:1] floatValue];
    CGFloat b = [[components objectAtIndex:2] floatValue];
    CGFloat a = [[components objectAtIndex:3] floatValue];
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

@end
