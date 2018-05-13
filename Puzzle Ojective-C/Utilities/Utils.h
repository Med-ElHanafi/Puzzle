//
//  Utils.h
//  Puzzle Ojective-C
//
//  Created by Mohamed El Hanafi on 14/03/2018.
//  Copyright © 2018 Mintit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Utils : NSObject
+(NSMutableArray*)cropImageIntoNine:(NSString*)image;
+(NSString*)timeString: (NSInteger)time;
+(NSMutableArray*) cropImageInto:(int)piecesX piecesY:(int)piecesY imageNamed:(NSString*)image;
+(NSMutableArray*) cropImageInto:(int)pieces imageNamed:(NSString*)image;
@end

