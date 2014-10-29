//
//  LinearRing.m
//  OfflineGeoLocator
//
//  Created by caisenchuan on 14/10/24.
//

#import "LinearRing.h"
#import "GeoPoint.h"

@import UIKit;

@interface LinearRing ()
{
    UIBezierPath *mPath;
}

@end

@implementation LinearRing 

-(id)initWithPointString:(NSString *)str
{
    self = [super init];
    if (self) {
        NSArray *arr = [self coverStringIntoPointArray:str];
        mPath = [self bezierPathForGeographicalPolygon:arr];
    }
    return self;
}

-(id)initWithPointArray:(NSArray *)arr
{
    self = [super init];
    if (self) {
        mPath = [self bezierPathForGeographicalPolygon:arr];
    }
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"mPath : %@", mPath];
}

//Cover the string into point list, string format: lat lon, lat lon, lat lon...
- (NSArray *)coverStringIntoPointArray:(NSString *)str
{
    NSMutableArray *ret = [NSMutableArray arrayWithCapacity:1];
    
    @autoreleasepool {
        if (str) {
            //divide the string into array, sep with comma(,)
            NSArray *list = [str componentsSeparatedByString:@","];
            for (NSString *ele in list) {
                NSArray *ll = [ele componentsSeparatedByString:@" "];
                if (ll.count >= 2) {
                    GeoPoint *p = [[GeoPoint alloc]init];
                    p.longitude = [[ll objectAtIndex:0] doubleValue];
                    p.latitude = [[ll objectAtIndex:1] doubleValue];
                    
                    [ret addObject:p];
                }
            }
        }
    }
    
    return ret;
}

//Build path from the point list
- (UIBezierPath*)bezierPathForGeographicalPolygon:(NSArray*)polygonPoints{
    
    if (!polygonPoints) {
        return nil;
    }
    
    if ([polygonPoints count] < 3) {
        return nil;
    }
    
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    
    BOOL firstPoint = YES;
    
    for (GeoPoint *thisPoint in polygonPoints) {
        CGPoint locationCGPoint = CGPointMake(thisPoint.latitude, thisPoint.longitude);
        if (firstPoint) {
            [bezierPath moveToPoint:locationCGPoint];
            firstPoint = NO;
        } else {
            [bezierPath addLineToPoint:locationCGPoint];
        }
    }
    
    [bezierPath closePath];
    
    return bezierPath;
}

-(BOOL)containsLatitude:(double)lat andLongitude:(double)lon
{
    if (mPath) {
        CGPoint locationCGPoint = CGPointMake(lat, lon);
        return [mPath containsPoint:locationCGPoint];
    } else {
        return NO;
    }
}

@end
