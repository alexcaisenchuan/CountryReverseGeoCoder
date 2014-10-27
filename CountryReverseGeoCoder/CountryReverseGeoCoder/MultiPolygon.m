//
//  MultiPolygon.m
//  OfflineGeoLocator
//
//  Created by caisenchuan on 14/10/24.
//

#import "MultiPolygon.h"
#import "Polygon.h"

@interface MultiPolygon ()
{
    NSMutableArray *mPolygonList;
}

@end

@implementation MultiPolygon

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
    mPolygonList = [NSMutableArray arrayWithCapacity:1];
    
    //Remove brackets of head and tail
    //((xxx),(xxx)),((xxx),(xxx)),((xxx),(xxx))
    NSRange r_middle;
    r_middle.location = 1;
    r_middle.length = str.length - 2;
    str = [str substringWithRange:r_middle];
    //Divide the string into substring by )),((
    NSMutableArray *subArr = [NSMutableArray arrayWithArray:[str componentsSeparatedByString:@")),(("]];
    if (subArr.count >= 1) {
        //First element: ((xxx),(xxx
        //Middle element: xxx),(xxx
        //Last element: xxx),(xxx))
        for (int i = 0; i < subArr.count; i++) {
            NSMutableString *s = [NSMutableString stringWithString:[subArr objectAtIndex:i]];
            
            //Add brackets
            if (i != 0) {
                [s insertString:@"((" atIndex:0];
            }
            if (i < (subArr.count - 1)) {
                [s appendString:@"))"];
            }
            
            //Build polygon
            Polygon *poly = [[Polygon alloc]initWithString:s];
            [mPolygonList addObject:poly];
        }
    }
}

-(BOOL)containsLatitude:(double)lat andLongitude:(double)lon
{
    for (Polygon *p in mPolygonList) {
        if ([p containsLatitude:lat andLongitude:lon]) {
            return YES;
        }
    }
    
    return NO;
}

@end
