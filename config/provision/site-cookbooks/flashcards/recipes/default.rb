include_recipe "yum"
include_recipe "imagemagick"
include_recipe 'postgresql::server'
include_recipe "build-essential"
include_recipe "ruby_build"
include_recipe "ruby_rbenv"
include_recipe "nodejs"
include_recipe "vim"

%w(postgresql-libs postgresql-devel openssl-devel libyaml-devel libffi-devel
   readline-devel zlib-devel gdbm-devel ncurses-devel
   policycoreutils policycoreutils-python).each do |package_name|
  package package_name do
    action :install
  end
end

ruby_build_ruby node["new_flashcards"]["ruby_version"] do
  prefix_path "/usr/"
  action :reinstall
  not_if "test $(ruby -v | grep #{node['new_flashcards']['ruby_version']} | wc -l) = 1"
end

gem_package "bundler" do
  gem_binary "/usr/bin/gem"
  options "--no-ri --no-rdoc"
end

gem_package "rails" do
  options "-v '#{node['new_flashcards']['rails_version']}'"
end

template '/vagrant/config/database.yml' do
  source 'database.yml.erb'
end

execute 'bundle' do
  cwd '/vagrant'
  not_if 'bundle check'
end

execute 'rails db:create db:migrate' do
  cwd '/vagrant'
  command 'rails db:create db:migrate'
  action :run
end

execute 'rails s -d -b 0.0.0.0' do
  cwd '/vagrant'
  command 'rails s -d -b 0.0.0.0'
  action :run
end
