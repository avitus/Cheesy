//
//  CheeseTasting.m
//  Cheesy
//
//  Created by Andy Vitus on 4/4/13.
//  Copyright (c) 2013 Andy Vitus. All rights reserved.
//

#import "CheeseTasting.h"

// Import this header to let CheeseTasting know that PFObject privately provides most
// of the methods for PFSubclassing.
#import <Parse/PFObject+Subclass.h>

@implementation CheeseTasting

@dynamic user;
@dynamic cheeseName;
@dynamic qualityRating;
@dynamic pricePerLb;
@dynamic storeName;

+ (NSString *)parseClassName {
    return @"CheeseTasting";
}

@end