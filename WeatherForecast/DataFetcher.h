//
//  DataFetcher.h
//  WeatherForecast
//
//  Created by Ye Lu on 10/23/15.
//  Copyright (c) 2015 Raye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherData.h"


@interface DataFetcher : NSObject


+(void)fetchDataWithLocationLatitude:(float)latitude longitude:(float)longitude completionHandler:(void(^)(NSData *data, NSURLResponse *response, NSError *error))complete;

+(void)fetchDataWithCityName:(NSString*)city completionHandler:(void(^)(NSData *data, NSURLResponse *response, NSError *error))complete;


@end
