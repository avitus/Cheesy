//
//  CheeseTasting.h
//  Cheesy
//
//  Created by Andy Vitus on 4/4/13.
//  Copyright (c) 2013 Andy Vitus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface CheeseTasting : PFObject<PFSubclassing>

+ (NSString *)parseClassName;

@property (retain) NSString *cheeseName;
@property (retain) NSString *storeName;
@property (retain) NSNumber *qualityRating;
@property (retain) NSNumber *pricePerLb;

@end