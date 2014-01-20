//
//  Movie.h
//  tomatoes
//
//  Created by David Law on 1/20/14.
//  Copyright (c) 2014 David Law. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *synopsis;
@property (nonatomic, strong) NSMutableArray *cast;

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (NSString *)getCast;

@end
