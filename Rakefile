# -*- ruby -*-

require 'rubygems'
require 'hoe'

Hoe.plugins.delete :rubyforge
Hoe.plugin :minitest
Hoe.plugin :gemspec # `gem install hoe-gemspec`
Hoe.plugin :git     # `gem install hoe-git`

Hoe.spec 'purdytest' do
  developer('Aaron Patterson', 'aaron@tenderlovemaking.com')
  self.readme_file      = 'README.rdoc'
  self.history_file     = 'CHANGELOG.rdoc'
  self.extra_rdoc_files = FileList['*.rdoc']
  self.extra_deps       << ['minitest', '~> 5.5']
end

# vim: syntax=ruby
