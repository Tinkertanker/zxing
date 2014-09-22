Pod::Spec.new do |s|
  s.name                        = "ZXing"
  s.version                     = "2.2"
  s.summary                     = "Multi-format 1D/2D barcode image processing library."
  s.homepage                    = "http://code.google.com/p/zxing/"
  s.author                      = "ZXing team (http://code.google.com/p/zxing/people/list)"
  s.license                     = { :type => 'Apache License, Version 2.0', :file => 'COPYING' }
  s.source                      = { :github => "git@github.com:Tinkertanker/zxing.git", :branch => "xcode6" }

  s.preserve_paths              = 'cpp/core/src/zxing/**/*.h', 'objc/src/ZXing/*.h', 'cpp/core/src/bigint/*.hh'
  s.source_files                = 'cpp/core/src/zxing/**/*.cpp', 'objc/src/ZXing/*.{m,mm}', 'cpp/core/src/bigint/*.cc'
  s.compiler_flags              = '-IZXing/cpp/core/src/ -IZXing/objc/src/'
  s.requires_arc                = false

# workaround for a missing import in objc/src/ZXing/ZXImage.mm
  s.prefix_header_contents      = <<-EOS
#ifdef __OBJC__
  #import <ImageIO/CGImageSource.h>
#endif
EOS

  # ZXing won't compile with c++11, default as of Xcode 5
  s.xcconfig = {
    'CLANG_CXX_LANGUAGE_STANDARD' => 'c++98',
    'CLANG_CXX_LIBRARY' => 'libstdc++'
  }

  s.libraries                   = 'stdc++', 'iconv'
  s.frameworks                  = 'AddressBook', 'AudioToolbox', 'AVFoundation', 'CoreGraphics', 'CoreMedia', 'CoreVideo', 'ImageIO'

  s.subspec 'ios' do |ios|
    ios.platform                = :ios, '4.3'
    ios.ios.deployment_target   = '4.3'

    ios.preserve_paths          = 'cpp/core/src/zxing/**/*.h', 'objc/src/ZXing/*.h', 'cpp/core/src/bigint/*.hh'
    ios.source_files            = 'cpp/core/src/zxing/**/*.cpp', 'objc/src/ZXing/*.{m,mm}', 'iphone/ZXingWidget/Classes/**/*.{h,m,mm}', 'cpp/core/src/bigint/*.cc'
    ios.compiler_flags          = '-IZXing/cpp/core/src/ -IZXing/objc/src/', '-IZXing/cpp/core/src/zxing/', '-IZXing/iphone/ZXingWidget/Classes/'
    # There are two MultiFormatReader.h files, it appears this one is unused
    ios.exclude_files           = 'iphone/ZXingWidget/Classes/MultiFormatReader.h'

#   must use xcconfig additional to compiler_flag -I to make this header path also available for the including project
    ios.xcconfig                = { 'HEADER_SEARCH_PATHS' => '${PODS_ROOT}/ZXing/cpp/core/src/ ${PODS_ROOT}/ZXing/iphone/ZXingWidget/Classes/**' }
    ios.frameworks              = 'AddressBookUI', 'QuartzCore'
  end
end
