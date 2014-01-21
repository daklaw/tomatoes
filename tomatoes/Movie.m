//
//  Movie.m
//  tomatoes
//
//  Created by David Law on 1/20/14.
//  Copyright (c) 2014 David Law. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.cast = [NSMutableArray new];
        self.title = dictionary[@"title"];
        self.synopsis = dictionary[@"synopsis"];
        self.image_url = [NSURL URLWithString:dictionary[@"posters"][@"profile"]];
        NSArray *abridged_cast = dictionary[@"abridged_cast"];
        for (id member in abridged_cast) {
            [self.cast addObject:member[@"name"]];
        }
    }
    return self;
}

- (NSString *)getCast {
    return [self.cast componentsJoinedByString:@", "];
}
@end
