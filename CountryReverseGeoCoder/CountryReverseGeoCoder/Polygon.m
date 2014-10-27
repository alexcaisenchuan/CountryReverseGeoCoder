//
//  Polygon.m
//  OfflineGeoLocator
//
//  Created by caisenchuan on 14/10/24.
//

#import "Polygon.h"
#import "LinearRing.h"

@interface Polygon ()
{
    //A polygon contains one boundary and 0 or more holes,
    //the country's area is between the boundary and the holes
    LinearRing *mBoundary;
    NSMutableArray *mHoleList;
}

@end

@implementation Polygon

//Init a polygon with input string, string format:((xxxx, xxxx),(xxxx, xxxx))
-(id)initWithString:(NSString *)str
{
    self = [super init];
    if (self) {
        [self getDataFromString:str];
    }
    return self;
}

-(void)getDataFromString:(NSString *)str
{
    NSMutableArray *subArr = [NSMutableArray arrayWithArray:[str componentsSeparatedByString:@"),("]];
    if ([subArr count] >= 1) {
        //Remove all brackets, in fact, only the first & the last element has bracket
        //The first element looks like : ((xxx
        NSString *first = [subArr firstObject];
        NSRange removeR;
        removeR.location = 2;
        removeR.length = [first length] - 2;
        [subArr setObject:[first substringWithRange:removeR] atIndexedSubscript:0];
        
        //The last element looks like: xxx))
        NSString *last = [subArr lastObject];
        removeR.location = 0;
        removeR.length = [last length] - 2;
        [subArr setObject:[last substringWithRange:removeR] atIndexedSubscript:(subArr.count - 1)];
        
        //Now we got a list of string, every string has a format like: lat lon, lat lon, lat lon...
        mHoleList = [NSMutableArray arrayWithCapacity:1];
        for (int i = 0; i < subArr.count; i++) {
            NSString *s = [subArr objectAtIndex:i];
            LinearRing *ring = [[LinearRing alloc]initWithPointString:s];
            if (i == 0) {
                //The first element of list is the boudary
                //NSLog(@"Add boundary : %@", ring);
                mBoundary = ring;
            } else {
                //The other element is holes
                //NSLog(@"Add hole : %@", ring);
                [mHoleList addObject:ring];
            }
        }
    }
}

-(BOOL)containsLatitude:(double)lat andLongitude:(double)lon
{
    //If the point in the boundary and not int the hole, then the point is int the area
    if ([mBoundary containsLatitude:lat andLongitude:lon] && ![self inHole:lat andLongitude:lon]) {
        return YES;
    } else {
        return NO;
    }
}

-(BOOL)inHole:(double)lat andLongitude:(double)lon
{
    for (LinearRing *ring in mHoleList) {
        if ([ring containsLatitude:lat andLongitude:lon]) {
            return YES;
        }
    }
    
    return NO;
}

@end
