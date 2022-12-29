//
//  CoordinateModel.m
//  WeatherApp
//
//  Created by Mutlu Çalkan on 28.12.2022.
//

#import "CoordinateModel.h"

@implementation CoordinateModel

- (instancetype)initWithLongitude:(NSString *)longitude andLatitude:(NSString *)latitude{
    if (self = [super init]) {
        self.longitude = longitude;
        self.latitude = latitude;
    }
    
    return self;
}

+ (NSArray *)fetchCoord{
    return @[
        [[CoordinateModel alloc] initWithLongitude:@"" andLatitude:@""]
    ];
}
@end
