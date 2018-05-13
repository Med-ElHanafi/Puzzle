//
//  UIImage+cropImage.m
//  Puzzle Ojective-C
//
//  Created by Mohamed El Hanafi on 14/03/2018.
//  Copyright © 2018 Mintit. All rights reserved.
//

#import "UIImage+cropImage.h"

@implementation UIImage (cropImage)
-(UIImage*)topThird{
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height * 0.3);
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage* image = [UIImage imageWithCGImage:imageRef];
    return image;
}
-(UIImage*)middleThirdVertical{
    CGRect rect = CGRectMake(0, self.size.height * 0.3, self.size.width, self.size.height * 0.3);
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage* image = [UIImage imageWithCGImage:imageRef];
    return image;
}
-(UIImage*)bottomThird{
    CGRect rect = CGRectMake(0, self.size.height * 0.6, self.size.width, self.size.height * 0.3);
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage* image = [UIImage imageWithCGImage:imageRef];
    return image;
}
-(UIImage*)leftThird{
    CGRect rect = CGRectMake(0, 0, self.size.width * 0.3, self.size.height);
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage* image = [UIImage imageWithCGImage:imageRef];
    return image;
}
-(UIImage*)middleThirdHorizontal{
    CGRect rect = CGRectMake(self.size.width * 0.3, 0, self.size.width * 0.3, self.size.height);
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage* image = [UIImage imageWithCGImage:imageRef];
    return image;
}
-(UIImage*)rightThird{
    CGRect rect = CGRectMake(self.size.width * 0.6, 0, self.size.width * 0.3, self.size.height);
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage* image = [UIImage imageWithCGImage:imageRef];
    return image;
}
-(UIImage*)cropPlaceWithX:(int) x andY:(int) y numberOfPieces:(int)piecesX andPiecesY:(int)piecesY{
    CGFloat width = self.size.width / piecesX;
    CGFloat height = self.size.height / piecesY;
    
    CGRect rect = CGRectMake(width * x, height * y, width, height);
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage* image = [UIImage imageWithCGImage:imageRef];
    return image;
}
-(UIImage*)cropPlaceWithX:(int) x andY:(int) y numberOfPieces:(int)pieces{
    CGFloat width = self.size.width / pieces;
    CGFloat height = self.size.height / pieces;
    
    CGRect rect = CGRectMake(width * x, height * y, width, height);
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage* image = [UIImage imageWithCGImage:imageRef];
    return image;
}
@end
