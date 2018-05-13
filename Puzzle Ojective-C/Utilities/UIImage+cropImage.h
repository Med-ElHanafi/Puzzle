//
//  UIImage+cropImage.h
//  Puzzle Ojective-C
//
//  Created by Mohamed El Hanafi on 14/03/2018.
//  Copyright © 2018 Mintit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (cropImage)
-(UIImage*)topThird;
-(UIImage*)middleThirdVertical;
-(UIImage*)bottomThird;
-(UIImage*)leftThird;
-(UIImage*)middleThirdHorizontal;
-(UIImage*)rightThird;
-(UIImage*)cropPlaceWithX:(int) x andY:(int) y numberOfPieces:(int)piecesX andPiecesY:(int)piecesY;
-(UIImage*)cropPlaceWithX:(int) x andY:(int) y numberOfPieces:(int)pieces;
@end
