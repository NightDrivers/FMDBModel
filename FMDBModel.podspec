Pod::Spec.new do |s|
  s.name         = "FMDBModel"
  s.version      = "0.0.2"
  s.summary      = "虚拟数据模型，对FMDB进行封装，子类能进行基本的数据库操作"
  s.homepage     = "https://github.com/lindechun1994/FMDBModel"
  s.license      = "MIT"
  s.author       = { "DeChun Lin" => "lin_de_chun@sina.com" }
  s.platform     = :ios, "5.0"
  s.source       = { :git => "https://github.com/lindechun1994/FMDBModel.git", :tag => s.version.to_s}
  s.source_files  = "Pod/*.{h,m}"
  s.requires_arc = true
  s.dependency 'FMDB', '~> 2.6.2'
end
