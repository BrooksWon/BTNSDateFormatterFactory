Pod::Spec.new do |s|
  s.name             = 'BTNSDateFormatterFactory'
  s.version          = 'v0.1.0'
  s.summary          = 'Smart reuse of NSDateFormatter instances.'
  s.homepage         = 'https://github.com/BrooksWon/BTNSDateFormatterFactory'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'BrooksWon' => 'jianyu996@163.com' }
  s.source           = { :git => 'https://github.com/BrooksWon/BTNSDateFormatterFactory.git', :tag => s.version }
  s.platform         = :ios, '6.0'
  s.source_files     = 'BTNSDateFormatterFactory/*.{h,m}'
  s.requires_arc     = true
  s.frameworks       = 'Foundation','UIKit'
end
