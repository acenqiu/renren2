$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "renren2/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "renren2"
  s.version     = Renren2::VERSION
  s.authors     = ["Acenqiu"]
  s.email       = ["acenqiu@gmail.com"]
  s.homepage    = "https://github.com/acenqiu/renren2"
  s.summary     = "A wrapper for Renren OAuth2 API"
  s.description = "A wrapper for Renren OAuth2 API."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "oauth2", "~> 0.5.1"

  s.add_development_dependency "sqlite3"
end
