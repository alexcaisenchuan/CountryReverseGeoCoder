//
//  TestFileOP.m
//  OfflineGeoLocator
//
//  Created by caisenchuan on 14/10/24.
//

#import "CountryReverseGeoCoder.h"
#import "Polygon.h"
#import "MultiPolygon.h"
#import "Country.h"

@interface CountryReverseGeoCoder ()
{
    NSMutableArray *mCountryList;
}

@end

@implementation CountryReverseGeoCoder

-(id)init
{
    self = [super init];
    if (self) {
        [self loadCountryInfo];
    }
    return self;
}

//Load info from files on init, this will takes a long time & cost lots of memory
-(void)loadCountryInfo
{
    @autoreleasepool {
        NSString* path = [[NSBundle mainBundle] pathForResource:@"polygons" ofType:@"properties"];
        NSString* str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSArray* allLinedStrings = [str componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        
        mCountryList = [NSMutableArray arrayWithCapacity:100];
        
        for (NSString *s in allLinedStrings) {
            @autoreleasepool {
                if ([s length] > 3) {
                    NSRange r;
                    r.location = 0;
                    r.length = 2;
                    
                    Country *country = [[Country alloc]init];
                    
                    NSString *code = [s substringWithRange:r];
                    country.code = code;
                    //NSLog(@"%@", code);
                    
                    NSRange r2 = [s rangeOfString:@" "];
                    
                    NSRange r3;
                    r3.length = r2.location - 3;
                    r3.location = 3;
                    if (r3.length > 0) {
                        NSString *type = [s substringWithRange:r3];
                        //NSLog(@"%@", type);
                        
                        //Get sub string
                        NSString *subStr = [s substringFromIndex:r2.location + 1];
                        if ([type isEqualToString:@"MULTIPOLYGON"]) {
                            //MULTIPOLYGON
                            //subStr = @"(((x),(xx)),((xxx),(xxxx)),((xxxxx),(xxxxxx)))";
                            MultiPolygon *mp = [[MultiPolygon alloc]initWithString:subStr];
                            country.metry = mp;
                        } else if ([type isEqualToString:@"POLYGON"]) {
                            //POLYGON
                            //subStr = @"((x),(xx),(xxx),(xxxx))";
                            Polygon *poly = [[Polygon alloc]initWithString:subStr];
                            country.metry = poly;
                        } else {
                            //...
                        }
                    }
                    
                    [mCountryList addObject:country];
                }
            }
        }
    }
}

//Get the country code by latitude & longitude, country code is define in ISO 3166-1 two letter format
-(NSString *)getCountryCodeByLatitude:(double)lat andLongitude:(double)lon
{
    NSString *ret = nil;
    if (mCountryList) {
        for (Country *c in mCountryList) {
            if (c.metry) {
                if ([c.metry containsLatitude:lat andLongitude:lon]) {
                    ret = c.code;
                    break;
                }
            }
        }
    }
    return ret;
}

@end
