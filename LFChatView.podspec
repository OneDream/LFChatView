

Pod::Spec.new do |s|

  s.name         = "LFChatView"
  s.version      = "0.0.1"
  s.summary      = "模仿聊天输入框的Demo"
  s.description  = <<-DESC
                    仿聊天输入框的Demo.
                   DESC
  s.homepage     = "https://git@github.com:OneDream/LFChatView.git"
  s.license      = "MIT (example)"
  s.author             = { "ethan.lxb" => "ethan.lxb@alibaba-inc.com" }
  s.platform     = :ios
  s.source       = { :git => "git@github.com:OneDream/LFChatView.git", :branch => "master" }
  s.source_files  = 'LFChatView', "LFChatView/**/*.{h,m}"
  s.resources = "LFChatView/Resources/*"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
