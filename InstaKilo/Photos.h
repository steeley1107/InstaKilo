//
//  Photos.h
//  InstaKilo
//
//  Created by Steele on 2015-11-04.
//  Copyright © 2015 Steele. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Photos : NSObject
@property (nonatomic) UIImage *image;
@property (nonatomic) NSString *location;
@property (nonatomic) NSString *group;

- (instancetype)initWithImage: (UIImage*)image location:(NSString*)location andGroup:(NSString*)group;

@end
