//
//  ViewController.m
//  EasyPR_iOS
//
//  Created by chen on 2017/9/27.
//  Copyright © 2017年 chen. All rights reserved.
//

#import "ViewController.h"

#import <opencv2/opencv.hpp>

#include "easypr.h"
using namespace cv;
using namespace easypr;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self myFunction];
}


- (void)myFunction{
    
    cv::Mat cvImage;
    cv::Mat RGB;
    CPlateRecognize pr;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"jpg"];
    Mat img = imread([path UTF8String]);
 
    if (img.empty()) {
        return;
    }
    cvtColor(img, RGB, COLOR_BGRA2RGB);
    vector<CPlate> plateVec;
    int result = pr.plateRecognize(RGB, plateVec);
    NSLog(@"result %@",@(result));
    if (result != 0) cout << "result:" << result << endl;
    if(plateVec.size()==0){
        
    }else {
        string name=plateVec[0].getPlateStr();
        NSString *resultMessage = [NSString stringWithCString:plateVec[0].getPlateStr().c_str()
                                                     encoding:NSUTF8StringEncoding];
        NSLog(@"%@",resultMessage);
    }
}


@end






