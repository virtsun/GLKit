//
//  UIImage+AI.m
//  Moline
//
//  Created by sunlantao on 2019/4/19.
//  Copyright © 2019 sunlantao. All rights reserved.
//

#import "UIImage+AI.h"

@implementation UIImage(AI)

/**识别脸部*/
-(NSArray *)detectFace
{
    //此处是CIDetectorAccuracyHigh，若用于real-time的人脸检测，则用CIDetectorAccuracyLow，更快
    CIDetector *faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace
                                                  context:nil
                                                  options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
    CIImage *ciimg = [CIImage imageWithCGImage:self.CGImage];
    NSArray *features = [faceDetector featuresInImage:ciimg options:@{ CIDetectorSmile : @YES,
                                                                       CIDetectorEyeBlink : @YES}];
    
    CIFaceFeature *faceFeature = [features firstObject];
    if (faceFeature) {
        NSLog(@"bounds                  : %@",NSStringFromCGRect(faceFeature.bounds));
        NSLog(@"hasLeftEyePosition      : %d",faceFeature.hasLeftEyePosition);
        NSLog(@"leftEyePosition         : %@",NSStringFromCGPoint(faceFeature.leftEyePosition));
        NSLog(@"hasRightEyePosition     : %d",faceFeature.hasRightEyePosition);
        NSLog(@"rightEyePosition        : %@",NSStringFromCGPoint(faceFeature.rightEyePosition));
        NSLog(@"hasMouthPosition        : %d",faceFeature.hasMouthPosition);
        NSLog(@"mouthPosition           : %@",NSStringFromCGPoint(faceFeature.mouthPosition));
        NSLog(@"hasTrackingID           : %d",faceFeature.hasTrackingID);
        NSLog(@"trackingID              : %d",faceFeature.trackingID);
        NSLog(@"hasTrackingFrameCount   : %d",faceFeature.hasTrackingFrameCount);
        NSLog(@"trackingFrameCount      : %d",faceFeature.trackingFrameCount);
        NSLog(@"hasFaceAngle            : %d",faceFeature.hasFaceAngle);
        NSLog(@"faceAngle               : %frightEyeClosed",faceFeature.faceAngle);
        NSLog(@"hasSmile                : %d",faceFeature.hasSmile);
        NSLog(@"leftEyeClosed           : %d",faceFeature.leftEyeClosed);
        NSLog(@"rightEyeClosed          : %d",faceFeature.rightEyeClosed);
        NSLog(@"\n\n\n");
    }
    
    return features;
}

@end
