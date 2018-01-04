Pod::Spec.new do |s|
  s.name             = 'BTNSDateFormatterFactory'
  s.version          = '0.1.1'
  s.summary          = 'Smart reuse of NSDateFormatter instances.'
  s.homepage         = 'https://github.com/BrooksWon/BTNSDateFormatterFactory'
  s.license          = {
    :type => 'MIT',
    :file => 'LICENSE'
  }
  s.author           = { 'BrooksWon' => '364674019@qq.com' }
  s.source           = { :git => 'https://github.com/BrooksWon/BTNSDateFormatterFactory.git', :tag => s.version.to_s }
  s.platform         = :ios, '6.0'
  s.source_files     = 'BTNSDateFormatterFactory', 'BTNSDateFormatterFactory/*.{h,m}'
  s.requires_arc     = true
  s.frameworks       = 'Foundation','UIKit'
end
