//
//  Photos.m
//  InstaKilo
//
//  Created by Steele on 2015-11-04.
//  Copyright © 2015 Steele. All rights reserved.
//

#import "Photos.h"

@implementation Photos


- (instancetype)initWithImage: (UIImage*)image location:(NSString*)location andGroup:(NSString*)group
{
    self = [super init];
    if (self) {
        _image = image;
        _location = location;
        _group = group;
    }
    return self;
}

@end
