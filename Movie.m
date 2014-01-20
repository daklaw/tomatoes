//
//  Movie.m
//  tomatoes
//
//  Created by David Law on 1/19/14.
//  Copyright (c) 2014 David Law. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.title = dictionary[@"title"];
        self.synopsis = dictionary[@"synopsis"];
    }
    return self;
}

@end
