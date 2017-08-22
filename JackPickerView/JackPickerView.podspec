Pod::Spec.new do |s|
s.name = 'JackPickerView'
s.version = '1.0.0'
s.license = 'MIT'
s.summary = 'A short description of JackPickerView.My first project.'
s.homepage = 'https://github.com/NotLovelyChild/JackPicker'
s.authors = { ‘Jack’ => '15122328114@139.com' }
s.source = { :git => 'https://github.com/NotLovelyChild/JackPicker.git', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '8.0'
s.source_files = 'JCPikcer/*.{h,m}'
#s.resources = 'SXWaveAnimate/images/*.{png,xib}'
end