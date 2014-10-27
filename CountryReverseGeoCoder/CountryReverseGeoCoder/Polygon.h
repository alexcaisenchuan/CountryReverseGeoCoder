//
//  Polygon.h
//  OfflineGeoLocator
//
//  Created by caisenchuan on 14/10/24.
//

#import <Foundation/Foundation.h>
#import "Geometry.h"

@interface Polygon : NSObject <Geometry>

-(id)initWithString:(NSString *)str;

@end
