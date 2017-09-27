//
//  SGGlobalEasyPRPath.hpp
//  SimpleOpenCV
//
//  Created by chen on 2017/9/26.
//  Copyright © 2017年 chen. All rights reserved.
//

#ifndef SGGlobalEasyPRPath_hpp
#define SGGlobalEasyPRPath_hpp

#include <stdio.h>
#include <string>

class SGGlobalEasyPRPath {
public:
    static std::string kDefaultSvmPath;
    static std::string kLBPSvmPath;
    static std::string kHistSvmPath;
    
    static std::string kDefaultAnnPath;
    static std::string kChineseAnnPath;
    static std::string kGrayAnnPath;
    static std::string kChineseMappingPath;
    
    SGGlobalEasyPRPath()=default;
    
private:
};


#endif /* SGGlobalEasyPRPath_hpp */

