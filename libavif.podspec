Pod::Spec.new do |s|
  s.name             = 'libavif'
  s.version          = '0.0.1'
  s.summary          = 'libavif is a friendly, portable C implementation of the AVIF format.'
  
  s.description      = <<-DESC
                       libavif is a library that can read and write still images using AVIF format. It is simple to integrate into applications and is a friendly and portable C implementation of the AVIF format.
                       DESC

  s.homepage         = 'https://github.com/AOMediaCodec/libavif'
  s.license          = { :type => 'BSD' }
  s.author           = { 'AOMediaCodec' => 'https://aomedia.org' }
  
  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.10'
  
  s.source           = { :git => 'https://github.com/ShroudZzz/libavif.git', :tag => 'v' + s.version.to_s }
  
  s.subspec 'core' do |ss|
    ss.source_files = 'src/*.c', 'include/avif/*.h'
    ss.public_header_files = 'include/avif/*.h'
    ss.exclude_files = 'src/codec_*.c'
    ss.pod_target_xcconfig = {
      'HEADER_SEARCH_PATHS' => '$(inherited) $(PODS_ROOT)/libavif/include $(PODS_TARGET_SRCROOT)/include'
    }
  end
  
  s.subspec 'libdav1d' do |ss|
    ss.dependency 'libavif/core'
    ss.dependency 'libdav1d', '>= 1.2.0'
    ss.source_files = 'src/codec_dav1d.c'
    ss.pod_target_xcconfig = {
      'HEADER_SEARCH_PATHS' => '$(inherited) ${PODS_ROOT}/libdav1d/dav1d/include',
      'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) AVIF_CODEC_DAV1D=1 AVIF_CODEC_AOM_DECODE=0'
    }
  end
  
  s.default_subspecs = 'libdav1d'
  s.preserve_paths = 'src', 'include/avif'
end

