//
//  QTWeatherData.h
//  WeatherApp
//
//  Created by Mutlu Çalkan on 27.12.2022.
//

#import <Foundation/Foundation.h>

@class QTWeatherData;
@class QTCity;
@class QTCoord;
@class QTList;
@class QTClouds;
@class QTMain;
@class QTWeather;
@class QTWind;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface QTWeatherData : NSObject
@property (nonatomic, copy)   NSArray<QTList *> *list;
@property (nonatomic, strong) QTCity *city;
@end

@interface QTCity : NSObject
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, strong) QTCoord *coord;
@end

@interface QTCoord : NSObject
@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double lon;
@end

@interface QTList : NSObject
@property (nonatomic, strong) QTMain *main;
@property (nonatomic, copy)   NSArray<QTWeather *> *weather;
@property (nonatomic, strong) QTClouds *clouds;
@property (nonatomic, strong) QTWind *wind;
@property (nonatomic, copy)   NSString *dtTxt;
@end

@interface QTClouds : NSObject
@property (nonatomic, assign) NSInteger all;
@end

@interface QTMain : NSObject
@property (nonatomic, assign) double temp;
@property (nonatomic, assign) double feelsLike;
@property (nonatomic, assign) double tempMin;
@property (nonatomic, assign) double tempMax;
@property (nonatomic, assign) NSInteger pressure;
@property (nonatomic, assign) NSInteger seaLevel;
@property (nonatomic, assign) NSInteger grndLevel;
@property (nonatomic, assign) NSInteger humidity;
@property (nonatomic, assign) double tempKf;
@end

@interface QTWeather : NSObject
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, copy)   NSString *main;
@property (nonatomic, copy)   NSString *theDescription;
@end

@interface QTWind : NSObject
@property (nonatomic, assign) double speed;
@property (nonatomic, assign) NSInteger deg;
@property (nonatomic, assign) double gust;
@end

NS_ASSUME_NONNULL_END
