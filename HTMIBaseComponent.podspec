#
# Be sure to run `pod lib lint HTMIBaseComponent.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'HTMIBaseComponent'
    s.version          = '1.1.8'
    s.summary          = 'base category component'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
    DESC
    
    s.homepage         = 'https://github.com/Htmitech/HTMIBaseComponent'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'lqwang521' => 'wanglq@htmitech.com' }
    s.source           = { :git => 'https://github.com/Htmitech/HTMIBaseComponent.git', :tag => s.version.to_s }
    
    s.ios.deployment_target = '8.0'
    s.source_files = 'HTMIBaseComponent/Classes/**/*.{h,m}'
    
    
    #s.subspec 'Base' do |base|
    #base.requires_arc        = true
    #base.public_header_files = [
    #]
    # base.source_files = [
    #  ]
    # end
    
    #s.subspec 'Category' do |category|
    #    category.requires_arc        = true
    #    category.public_header_files = [
    #    'HTMIBaseComponent/Classes/Category/*.h',
    #       'HTMIBaseComponent/Classes/SettingManager/*.h',
    #        'HTMIBaseComponent/Classes/UserDefault/*.h',
    #        'HTMIBaseComponent/Classes/Encryption/*.h',
    #        'HTMIBaseComponent/Classes/ObjcRuntime/*.h',
    #       'HTMIBaseComponent/Classes/Base/*.h'
    #        ]
    #        category.source_files = [
    #       'HTMIBaseComponent/Classes/Category/*',
    #        'HTMIBaseComponent/Classes/SettingManager/*',
    #        'HTMIBaseComponent/Classes/UserDefault/*',
    #        'HTMIBaseComponent/Classes/Encryption/*',
    #        'HTMIBaseComponent/Classes/ObjcRuntime/*',
    #        'HTMIBaseComponent/Classes/Base/*'
    #        ]
    #    end
    
    s.dependency 'SVProgressHUD'    , '~> 2.1.2'
    s.dependency 'Masonry', '~> 1.0.2'
    s.dependency 'BlocksKit', '2.2.5'
    
end
