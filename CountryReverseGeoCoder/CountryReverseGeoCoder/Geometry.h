//
//  Geometry.h
//  Geo elements common basic define
//
//  Created by caisenchuan on 14/10/24.
//

#import <Foundation/Foundation.h>

@protocol Geometry <NSObject>

-(BOOL)containsLatitude:(double)lat andLongitude:(double)lon;

@end
