//
//  Header.h
//  QGCollectionTransverse
//
//  Created by cdc on 2018/10/9.
//  Copyright © 2018年 QG. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define BXScreenW [UIScreen mainScreen].bounds.size.width
#define BXScreenH [UIScreen mainScreen].bounds.size.height

#define ViewHeight1 (self.view.frame.size.height -[[UIApplication sharedApplication] statusBarFrame].size.height)
#define iPhoneX ([UIScreen mainScreen].bounds.size.height == 812)
#define kTabBarHeight (CGFloat)(iPhoneX?(49.0 + 34.0):(49.0))
#define QGViewW(xxxx) xxxx.frame.size.width
#define QGViewH(xxxx) xxxx.frame.size.height
#define QGViewX(xxxx) xxxx.frame.origin.x
#define QGViewY(xxxx) xxxx.frame.origin.y
#define QGViewXW(xxxx) (xxxx.frame.origin.x+xxxx.frame.size.width)
#define QGViewYH(xxxx) (xxxx.frame.origin.y+xxxx.frame.size.height)
// 设置颜色
#define RGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define RGBCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]
#define TEXTCOLOR RGB(153, 153, 153)
#define TEXTCOLOR51 RGB(51, 51, 51)
#define TEXTCOLOR102 RGB(102, 102, 102)
#define  TEXTCOLOR_RED  RGB(205, 30, 30)
#define  TEXTCOLOR_BLUE  RGB(30, 84, 205)
#endif /* Header_h */
