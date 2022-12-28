//
//  CoordinateModel.m
//  WeatherApp
//
//  Created by Mutlu Çalkan on 28.12.2022.
//

#import "CoordinateModel.h"

@implementation CoordinateModel

- (instancetype)initWithLongitude:(NSNumber *)longitude andLatitude:(NSNumber *)latitude{
    if (self = [super init]) {
        self.longitude = longitude;
        self.latitude = latitude;
    }
    
    return self;
}
@end
