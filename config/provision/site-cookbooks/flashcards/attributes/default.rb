default["new_flashcards"]["environment"] = %w(production staging).include?(node.chef_environment) ? node.chef_environment : "development"
default["new_flashcards"]["ruby_version"] = "2.3.0"
default["new_flashcards"]["rails_version"] = "5.0.0"
default["new_flashcards"]["database"]["name"] = "#{node['new_flashcards']['name']}_#{node['new_flashcards']['environment']}"
default["new_flashcards"]["database"]["user"] = "postgres"
default["new_flashcards"]["database"]["host"] = "localhost"
default["new_flashcards"]["database"]["port"] = 5432
default["new_flashcards"]['postgresql']['version'] = '9.3'
