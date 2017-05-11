@version = "1.0.1"

Pod::Spec.new do |s|
  s.name          = "PSSTableViewNoneData"
  s.version       = @version
  s.summary       = "A drop-in UITableView superclass category for showing empty datasets whenever the view has no content to display."
  s.description   = "It will work automatically, by just conforming to PSSTableViewNoneData, and returning the data you want to show. The -reloadData call will be observed so the empty dataset will be configured whenever needed."
  s.homepage      = "https://github.com/Pangshishan/PSSTableViewNoneData"
  s.license       = { :type => 'MIT', :file => 'LICENSE' }
  s.author        = { "Pangshishan" => "Pangshishan1@163.com" }
  s.ios.deployment_target   = '8.0'
  s.source        = { :git => "https://github.com/Pangshishan/PSSTableViewNoneData.git", :tag => "v#{s.version}" }
  s.source_files  = 'PSSTableViewNoneData', 'PSSTableViewNoneDataSet/**/*.{h,m}'
  s.requires_arc  = true
  s.framework     = "UIKit"
end