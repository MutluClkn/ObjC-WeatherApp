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
@class QTMainClass;
@class QTRain;
@class QTSys;
@class QTPod;
@class QTWeather;
@class QTIcon;
@class QTMainEnum;
@class QTDescription;
@class QTWind;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTPod : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTPod *)d;
+ (QTPod *)n;
@end

@interface QTIcon : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTIcon *)the04D;
+ (QTIcon *)the04N;
+ (QTIcon *)the10D;
+ (QTIcon *)the10N;
@end

@interface QTMainEnum : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTMainEnum *)clouds;
+ (QTMainEnum *)rain;
@end

@interface QTDescription : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTDescription *)brokenClouds;
+ (QTDescription *)lightRain;
+ (QTDescription *)overcastClouds;
@end

#pragma mark - Object interfaces

@interface QTWeatherData : NSObject
@property (nonatomic, copy)   NSString *cod;
@property (nonatomic, assign) NSInteger message;
@property (nonatomic, assign) NSInteger cnt;
@property (nonatomic, copy)   NSArray<QTList *> *list;
@property (nonatomic, strong) QTCity *city;
@end

@interface QTCity : NSObject
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, strong) QTCoord *coord;
@property (nonatomic, copy)   NSString *country;
@property (nonatomic, assign) NSInteger population;
@property (nonatomic, assign) NSInteger timezone;
@property (nonatomic, assign) NSInteger sunrise;
@property (nonatomic, assign) NSInteger sunset;
@end

@interface QTCoord : NSObject
@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double lon;
@end

@interface QTList : NSObject
@property (nonatomic, assign)           NSInteger dt;
@property (nonatomic, strong)           QTMainClass *main;
@property (nonatomic, copy)             NSArray<QTWeather *> *weather;
@property (nonatomic, strong)           QTClouds *clouds;
@property (nonatomic, strong)           QTWind *wind;
@property (nonatomic, assign)           NSInteger visibility;
@property (nonatomic, assign)           double pop;
@property (nonatomic, strong)           QTSys *sys;
@property (nonatomic, copy)             NSString *dtTxt;
@property (nonatomic, nullable, strong) QTRain *rain;
@end

@interface QTClouds : NSObject
@property (nonatomic, assign) NSInteger all;
@end

@interface QTMainClass : NSObject
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

@interface QTRain : NSObject
@property (nonatomic, assign) double the3H;
@end

@interface QTSys : NSObject
@property (nonatomic, assign) QTPod *pod;
@end

@interface QTWeather : NSObject
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) QTMainEnum *main;
@property (nonatomic, assign) QTDescription *theDescription;
@property (nonatomic, assign) QTIcon *icon;
@end

@interface QTWind : NSObject
@property (nonatomic, assign) double speed;
@property (nonatomic, assign) NSInteger deg;
@property (nonatomic, assign) double gust;
@end

NS_ASSUME_NONNULL_END
