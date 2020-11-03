/***  File Header  ************************************************************/
/**
* tfl_yolo3.cc
*
* tensor flow lite prediction
* @author	   Shozo Fukuda
* @date	create Sun Nov 01 22:01:42 JST 2020
* System	   MINGW64/Windows 10<br>
*
**/
/**************************************************************************{{{*/
#ifndef cimg_plugin

#define cimg_plugin     "tfl_yolo3.cc"
#define cimg_display    0
#define cimg_use_jpeg
#include "CImg.h"
using namespace cimg_library;

#include <string>
using namespace std;

#include "nlohmann/json.hpp"
using json = nlohmann::json;

#include "tensorflow/lite/interpreter.h"
using namespace tflite;

/***  Module Header  ******************************************************}}}*/
/**
* Tensorflow lite helper functions
* @par DESCRIPTION
*   extract command & arguments string from string
**/
/**************************************************************************{{{*/
template <class T>
inline T* get_typed_input_tensor(TfLiteTensor* tensor) {
  return tensor != nullptr ? reinterpret_cast<T*>(tensor->data.raw) : nullptr;
}

inline int size_of_dimension(const TfLiteTensor* t, int dim) {
  return t->dims->data[dim];
}

/***  Module Header  ******************************************************}}}*/
/**
* parse command line string
* @par DESCRIPTION
*   extract command & arguments string from string
*
* @retval command string & vector of arguments
**/
/**************************************************************************{{{*/
void
predict_yolo3(unique_ptr<Interpreter>& interpreter, const vector<string>& args, json& result)
{
/*PRECONDITION*/
    if (args.size() < 1) {
        result["error"] = "not enough argument";
        return;
    }
/**/

    // setup
    TfLiteTensor* input_tensor = interpreter->tensor(0);
    float* input = get_typed_input_tensor<float>(input_tensor);
    int width  = size_of_dimension(input_tensor, 1);
    int height = size_of_dimension(input_tensor, 2);

    typedef CImg<unsigned char> CImgU8;
    try {
        CImgU8 image(args[0].c_str());
        auto resized_img = image.get_resize(width, height);
        cimg_foroff(resized_img, i) {
            input[i] = resized_img[i]/255.0;
        }
    }
    catch (...) {
        result["error"] = "fail CImg";
        return;
    }
    
    // predict
    if (interpreter->Invoke() == kTfLiteOk) {
        // get result
        float* probs = interpreter->typed_output_tensor<float>(0);
        for (int i = 0; i < 10; i++) {
            result[to_string(i)] = probs[i];
        }
    }
    else {
        result["error"] = "fail predict";
    }
}

#else
/**************************************************************************}}}*/
/*** CImg Plugins:                                                          ***/
/**************************************************************************{{{*/
#endif
/*** tfl_yolo3.cc *******************************************************}}}*/