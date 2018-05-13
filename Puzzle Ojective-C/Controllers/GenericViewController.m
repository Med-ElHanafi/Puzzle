//
//  GenericViewController.m
//  Puzzle Ojective-C
//
//  Created by Mohamed El Hanafi on 04/04/2018.
//  Copyright © 2018 Mintit. All rights reserved.
//

#import "GenericViewController.h"
#import "UIImage+cropImage.h"
#import "Utils.h"
#import "AppDelegate.h"
@interface GenericViewController ()
{
    NSMutableArray* imagesArray;
    NSMutableArray* imagesBlocks;
    NSMutableArray* centersArray;
    NSMutableDictionary* correctIndex;
    NSMutableDictionary* currentIndex;
    
    CGPoint emptySpot;
    CGPoint tapCen;
    CGPoint left;
    CGPoint right;
    CGPoint top;
    CGPoint bottom;
    
    BOOL leftIsEmpty;
    BOOL rightIsEmpty;
    BOOL topIsEmpty;
    BOOL bottomIsEmpty;
    
    NSTimer *timer;
    BOOL timerIsRunning;
    NSInteger seconds;
    int numberOfPiecesX;
    int numberOfPiecesY;
    
    CGFloat imageWidth;
    CGFloat imageHeight;
}
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UILabel *bravoLabel;
@end

@implementation GenericViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    seconds = 0;
    numberOfPiecesX = 3;
    numberOfPiecesY = 3;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    imageWidth = (screenWidth / numberOfPiecesX);
    imageHeight = screenWidth / numberOfPiecesY;

    CGFloat xCenter = imageWidth * 0.5;
    CGFloat yCenter = imageHeight * 0.5;



    imagesArray = [[NSMutableArray alloc]init];
    imagesBlocks = [[NSMutableArray alloc]init];
    centersArray = [[NSMutableArray alloc]init];


    //imagesArray = [Utils cropImageIntoNine:@"grid"];
    imagesArray = [Utils cropImageInto:3 imageNamed:@"puppy"];
    //imagesArray = [Utils cropImageInto:numberOfPiecesX piecesY:numberOfPiecesY imageNamed:@"eye"];

    correctIndex = [[NSMutableDictionary alloc]init];
    currentIndex = [[NSMutableDictionary alloc]init];


    for (int v = 0; v<numberOfPiecesY; v++) {
        for (int h = 0; h<numberOfPiecesX; h++) {
            //Create the imageView
            UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageWidth, imageHeight)];
            CGPoint currentCenter = CGPointMake(xCenter, yCenter);

            //Assign center to imageView
            imageView.center = currentCenter;
            [centersArray addObject:[NSValue valueWithCGPoint:currentCenter]];

            //Fill the imageView with an image
            imageView.image = [imagesArray objectAtIndex:h + v * 3];
            imageView.userInteractionEnabled = YES;

            [imagesBlocks addObject:imageView];
            [self.view addSubview:imageView];
            //Increment the xCenter to the next center
            xCenter += imageWidth;

            //Fill the dictionary
            if ((h + v * 3) != 0)  {
                imageView.tag = h + v * 3;
                [correctIndex setObject:[NSValue valueWithCGPoint:currentCenter] forKey:[NSString stringWithFormat:@"%i",h + v * 3]];
            }
        }
        //After the loop reset the xCenter to initial position and increment the yCenter
        xCenter = imageWidth * 0.5;
        yCenter += imageHeight;
    }
    //we remove the first image from the array
    UIImageView* iv = [imagesBlocks objectAtIndex:0];
    [iv removeFromSuperview];
    //[[imagesBlocks objectAtIndex:0] removeFromSuperview];
    [imagesBlocks removeObjectAtIndex:0];

    [self randomizeImages];
    [self.view layoutIfNeeded];
}
-(void)randomizeImages{
    NSMutableArray* centerCopy = [centersArray mutableCopy];
    int randomLocationInt;
    CGPoint randomLocation;
    for (UIImageView* image in imagesBlocks) {
        randomLocationInt = arc4random() % centerCopy.count;
        randomLocation =  [(NSValue*)[centerCopy objectAtIndex:randomLocationInt] CGPointValue];
        
        image.center = randomLocation;
        [centerCopy removeObjectAtIndex:randomLocationInt];
        //[currentIndex setValue:[NSValue valueWithCGPoint:image.center] forKey:[NSString stringWithFormat:@"%i",randomLocationInt]];
        [currentIndex setObject:[NSValue valueWithCGPoint:image.center] forKey:[NSString stringWithFormat:@"%i",image.tag]];
        //currentIndex[image.tag] = image.center
    }
    emptySpot = [(NSValue*) [centerCopy objectAtIndex:0] CGPointValue];
}
-(void)updateTime{
    seconds+=1;
    self.timerLabel.text = [Utils timeString:seconds];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch* myTouch = [[touches allObjects] objectAtIndex:0];
    if (myTouch.view != self.view) {
        if (!timerIsRunning) {
            timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:true];
            timerIsRunning = YES;
        }
    }
    tapCen = myTouch.view.center;
    left = CGPointMake(tapCen.x - imageWidth, tapCen.y);
    right = CGPointMake(tapCen.x + imageWidth, tapCen.y);
    top = CGPointMake(tapCen.x, tapCen.y + imageHeight);
    bottom = CGPointMake(tapCen.x, tapCen.y - imageHeight);
    
    if ((int)left.x == (int)emptySpot.x && (int) left.y == (int)emptySpot.y) leftIsEmpty =YES;
    if ((int)right.x == (int)emptySpot.x && (int) right.y == (int)emptySpot.y) rightIsEmpty =YES;
    if ((int)top.x == (int)emptySpot.x && (int) top.y == (int)emptySpot.y) topIsEmpty =YES;
    if ((int)bottom.x == (int)emptySpot.x && (int) bottom.y == (int)emptySpot.y) bottomIsEmpty =YES;
    
    if (leftIsEmpty || rightIsEmpty || topIsEmpty || bottomIsEmpty) {
        [UIView animateWithDuration:0.5 animations:^{
            myTouch.view.center = emptySpot;
        }];
        emptySpot = tapCen;
        leftIsEmpty = NO;
        rightIsEmpty = NO;
        topIsEmpty = NO;
        bottomIsEmpty = NO;
        [currentIndex setValue:[NSValue valueWithCGPoint:myTouch.view.center] forKey:[NSString stringWithFormat:@"%i",myTouch.view.tag]];
    }
    if ([currentIndex isEqualToDictionary:correctIndex]) {
        [_bravoLabel setHidden:NO];
        [timer invalidate];
        timerIsRunning = YES;
    }
}

@end
