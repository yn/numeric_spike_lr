As of at least Rails 4.1.4 and earlier, if prepared_statements are disabled in config/database.yml for PostgreSQL, columns of type numeric(32,0) cannot be written to.

To reproduce:

Set this project up as you usually would (clone, create database, migrate). Then at the console, execute:

    Loading development environment (Rails 4.1.4)
    2.0.0-p451 :001 > BugFix.create! big: 5959852248567281390
       (0.2ms)  BEGIN
       (0.3ms)  ROLLBACK
    ActiveRecord::ActiveRecordError: No integer type has byte size 32. Use a numeric with precision 0 instead.
    	from /home/vagrant/.rvm/gems/ruby-2.0.0-p451@numeric_spike_lr/gems/activerecord-4.1.4/lib/active_record/connection_    adapters/postgresql/schema_statements.rb:475:in `type_to_sql'
    	from /home/vagrant/.rvm/gems/ruby-2.0.0-p451@numeric_spike_lr/gems/activerecord-4.1.4/lib/active_record/connection_    adapters/postgresql/quoting.rb:21:in `quote'
    	from /home/vagrant/.rvm/gems/ruby-2.0.0-p451@numeric_spike_lr/gems/activerecord-4.1.4/lib/active_record/connection_    adapters/abstract/database_statements.rb:14:in `block in to_sql'
    	from /home/vagrant/.rvm/gems/ruby-2.0.0-p451@numeric_spike_lr/gems/arel-5.0.1.20140414130214/lib/arel/visitors/bind_visitor.rb:26:in     `call'
    	from /home/vagrant/.rvm/gems/ruby-2.0.0-p451@numeric_spike_lr/gems/arel-5.0.1.20140414130214/lib/arel/visitors/bind_visitor.rb:26:in     `visit_Arel_Nodes_BindParam'
    	from /home/vagrant/.rvm/gems/ruby-2.0.0-p451@numeric_spike_lr/gems/arel-5.0.1.20140414130214/lib/arel/visitors/visitor.rb:22:in `visit'
    	from /home/vagrant/.rvm/gems/ruby-2.0.0-p451@numeric_spike_lr/gems/arel-5.0.1.20140414130214/lib/arel/visitors/to_sql.rb:148:in `block in     visit_Arel_Nodes_Values'
    	from /home/vagrant/.rvm/gems/ruby-2.0.0-p451@numeric_spike_lr/gems/arel-5.0.1.20140414130214/lib/arel/visitors/to_sql.rb:146:in `map'
    	from /home/vagrant/.rvm/gems/ruby-2.0.0-p451@numeric_spike_lr/gems/arel-5.0.1.20140414130214/lib/arel/visitors/to_sql.rb:146:in `visit_    Arel_Nodes_Values'
    	from /home/vagrant/.rvm/gems/ruby-2.0.0-p451@numeric_spike_lr/gems/arel-5.0.1.20140414130214/lib/arel/visitors/visitor.rb:22:in `visit'
    	from /home/vagrant/.rvm/gems/ruby-2.0.0-p451@numeric_spike_lr/gems/arel-5.0.1.20140414130214/lib/arel/visitors/to_sql.rb:110:in `visit_    Arel_Nodes_InsertStatement'
    	from /home/vagrant/.rvm/gems/ruby-2.0.0-p451@numeric_spike_lr/gems/arel-5.0.1.20140414130214/lib/arel/visitors/visitor.rb:22:in `visit'
    	from /home/vagrant/.rvm/gems/ruby-2.0.0-p451@numeric_spike_lr/gems/arel-5.0.1.20140414130214/lib/arel/visitors/visitor.rb:5:in `accept'
    	from /home/vagrant/.rvm/gems/ruby-2.0.0-p451@numeric_spike_lr/gems/arel-5.0.1.20140414130214/lib/arel/visitors/bind_visitor.rb:11:in     `accept'
    	from /home/vagrant/.rvm/gems/ruby-2.0.0-p451@numeric_spike_lr/gems/activerecord-4.1.4/lib/active_record/connection_    adapters/abstract/database_statements.rb:13:in `to_sql'
    	from /home/vagrant/.rvm/gems/ruby-2.0.0-p451@numeric_spike_lr/gems/activerecord-4.1.4/lib/active_record/connection_    adapters/abstract/database_statements.rb:94:in `insert'
    ... 26 levels...
    	from /home/vagrant/.rvm/gems/ruby-2.0.0-p451@numeric_spike_lr/gems/railties-4.1.4/lib/rails/commands/console.rb:9:in `start'
    	from /home/vagrant/.rvm/gems/ruby-2.0.0-p451@numeric_spike_lr/gems/railties-4.1.4/lib/rails/commands/commands_tasks.rb:69:in `console'
    	from /home/vagrant/.rvm/gems/ruby-2.0.0-p451@numeric_spike_lr/gems/railties-4.1.4/lib/rails/commands/commands_tasks.rb:40:in `run_    command!'
    	from /home/vagrant/.rvm/gems/ruby-2.0.0-p451@numeric_spike_lr/gems/railties-4.1.4/lib/rails/commands.rb:17:in `<top (required)>'
    	from /home/vagrant/.rvm/gems/ruby-2.0.0-p451@numeric_spike_lr/gems/activesupport-4.1.4/lib/active_support/dependencies.rb:247:in `require'
    	from /home/vagrant/.rvm/gems/ruby-2.0.0-p451@numeric_spike_lr/gems/activesupport-4.1.4/lib/active_support/dependencies.rb:247:in `block     in require'
    	from /home/vagrant/.rvm/gems/ruby-2.0.0-p451@numeric_spike_lr/gems/activesupport-4.1.4/lib/active_support/dependencies.rb:232:in `load_    dependency'
    	from /home/vagrant/.rvm/gems/ruby-2.0.0-p451@numeric_spike_lr/gems/activesupport-4.1.4/lib/active_support/dependencies.rb:247:in `require'
    	from /home/vagrant/code/numeric_spike_lr/bin/rails:8:in `<top (required)>'
    	from /home/vagrant/.rvm/gems/ruby-2.0.0-p451@numeric_spike_lr/gems/activesupport-4.1.4/lib/active_support/dependencies.rb:241:in `load'
    	from /home/vagrant/.rvm/gems/ruby-2.0.0-p451@numeric_spike_lr/gems/activesupport-4.1.4/lib/active_support/dependencies.rb:241:in `block     in load'
    	from /home/vagrant/.rvm/gems/ruby-2.0.0-p451@numeric_spike_lr/gems/activesupport-4.1.4/lib/active_support/dependencies.rb:232:in `load_    dependency'
    	from /home/vagrant/.rvm/gems/ruby-2.0.0-p451@numeric_spike_lr/gems/activesupport-4.1.4/lib/active_support/dependencies.rb:241:in `load'
    	from /home/vagrant/.rvm/rubies/ruby-2.0.0-p451/lib/ruby/site_ruby/2.0.0/rubygems/core_ext/kernel_require.rb:55:in `require'
    	from /home/vagrant/.rvm/rubies/ruby-2.0.0-p451/lib/ruby/site_ruby/2.0.0/rubygems/core_ext/kernel_require.rb:55:in `require'

Then, go to config/database.yml, and change "prepared_statements:false" to "prepared_statements:true"

