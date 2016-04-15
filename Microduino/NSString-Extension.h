//
//  NSString-Extension.h
//  Microduino
//
//  Created by harvey on 16/4/6.
//  Copyright © 2016年 harvey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString_Extension : NSObject

- (NSString *)stringByDecodingHTMLEntitiesInString:(NSString *)input;

-(NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim;
@end
