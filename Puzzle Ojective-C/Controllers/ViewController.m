//
//  ViewController.m
//  Puzzle Ojective-C
//
//  Created by Mohamed El Hanafi on 14/03/2018.
//  Copyright © 2018 Mintit. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+cropImage.h"
#define APPDELEGATE ((AppDelegate*)[UIApplication sharedApplication].delegate)
@interface ViewController ()
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
    
}
@property (weak, nonatomic) IBOutlet UIImageView *first;
@property (weak, nonatomic) IBOutlet UIImageView *second;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UILabel *bravoLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    seconds = 0;
    CGFloat xCenter =  APPDELEGATE.imageWidthHeight * 0.5;
    CGFloat yCenter = APPDELEGATE.imageWidthHeight * 0.5;
    
    imagesArray = [[NSMutableArray alloc]init];
    imagesBlocks = [[NSMutableArray alloc]init];
    centersArray = [[NSMutableArray alloc]init];
    
    
    imagesArray = [Utils cropImageIntoNine:@"eye"];
    
    
    correctIndex = [[NSMutableDictionary alloc]init];
    currentIndex = [[NSMutableDictionary alloc]init];
    
    
    for (int v = 0; v<3; v++) {
        for (int h = 0; h<3; h++) {
            //Create the imageView
            UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, APPDELEGATE.imageWidthHeight, APPDELEGATE.imageWidthHeight)];
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
            xCenter += APPDELEGATE.imageWidthHeight;

            //Fill the dictionary
            if ((h + v * 3) != 0)  {
                imageView.tag = h + v * 3;
                [correctIndex setObject:[NSValue valueWithCGPoint:currentCenter] forKey:[NSString stringWithFormat:@"%i",h + v * 3]];
            }
        }
        //After the loop reset the xCenter to initial position and increment the yCenter
        xCenter = APPDELEGATE.imageWidthHeight * 0.5;
        yCenter += APPDELEGATE.imageWidthHeight;
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
    left = CGPointMake(tapCen.x - APPDELEGATE.imageWidthHeight, tapCen.y);
    right = CGPointMake(tapCen.x + APPDELEGATE.imageWidthHeight, tapCen.y);
    top = CGPointMake(tapCen.x, tapCen.y + APPDELEGATE.imageWidthHeight);
    bottom = CGPointMake(tapCen.x, tapCen.y - APPDELEGATE.imageWidthHeight);
    
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
