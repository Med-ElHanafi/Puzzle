//
//  Utils.m
//  Puzzle Ojective-C
//
//  Created by Mohamed El Hanafi on 14/03/2018.
//  Copyright © 2018 Mintit. All rights reserved.
//

#import "Utils.h"
#import "UIImage+cropImage.h"
@implementation Utils
+(NSMutableArray*)cropImageIntoNine: (NSString*)image{
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    UIImage* myImage = [UIImage imageNamed:image];
    
    [imageArray addObject:[[myImage topThird] leftThird]];
    [imageArray addObject:[[myImage topThird]middleThirdHorizontal] ];
    [imageArray addObject:[[myImage topThird]rightThird]];
    
    [imageArray addObject:[[myImage middleThirdVertical]leftThird]];
    [imageArray addObject:[[myImage middleThirdVertical]middleThirdHorizontal]];
    [imageArray addObject:[[myImage middleThirdVertical]rightThird]];
    
    [imageArray addObject:[[myImage bottomThird]leftThird]];
    [imageArray addObject:[[myImage bottomThird]middleThirdHorizontal]];
    [imageArray addObject:[[myImage bottomThird]rightThird]];
    return imageArray;
}
+(NSString*)timeString: (NSInteger)time{
    NSInteger minutes = time / 60 % 60;
    NSInteger seconds = time % 60;
    return [NSString stringWithFormat:@"%02i:%02i",minutes,seconds];
}
+(NSMutableArray*) cropImageInto:(int)piecesX piecesY:(int)piecesY imageNamed:(NSString*)image{
    
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    UIImage* myImage = [UIImage imageNamed:image];
//    CGFloat width = myImage.size.width /pieces;
//    CGFloat height = myImage.size.height /pieces;
    //            CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height * 0.3);
    //            CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    //            UIImage* image = [UIImage imageWithCGImage:imageRef];
    //CGRect rect = CGRectMake(x * width, y * height, width, height);
    
    for (int y=0; y<piecesY; y++) {
        for (int x=0; x<piecesX; x++) {
            //[imageArray addObject:[myImage cropPlaceWithX:x andY:y numberOfPieces:pieces]];
            [imageArray addObject:[myImage cropPlaceWithX:x andY:y numberOfPieces:piecesX andPiecesY:piecesY]];
        }
    }
    
    return imageArray;
}
+(NSMutableArray*) cropImageInto:(int)pieces imageNamed:(NSString*)image{
    
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    UIImage* myImage = [UIImage imageNamed:image];
    
    for (int y=0; y<pieces; y++) {
        for (int x=0; x<pieces; x++) {
            [imageArray addObject:[myImage cropPlaceWithX:x andY:y numberOfPieces:pieces]];
        }
    }
    
    return imageArray;
}
@end
