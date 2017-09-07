# IAC (infrastructure-as-code)

sample project implementing Itamar Hassin's (of ThoughtWorks) [infrastructure-as-code presentation](https://ihassin.wordpress.com/2015/04/26/infrastructure-as-code-using-vagrant-ansible-cucumber-and-serverspec/)

## setup
things I had to do along the way to get everything to run (that I can remember)

### Gemfile

create a Gemfile:

    $ bundle init

add required gems

    group :test do
      gem 'cucumber'
      gem 'serverspec'
      gem 'rake'
    end

and install them in the project (to keep your environment clean)

    $ bundle install --path vendor/bundle

### ~/.ssh/config

    Host webserver 33.33.33.33
    	Hostname webserver
    	User vagrant
    	IdentityFile .vagrant/machines/webserver/virtualbox/private_key
    	StrictHostKeyChecking no
    	UserKnownHostsFile=/dev/null

### serverspec-init

    $ bundle exec serverspec-init
    Select OS type:

      1) UN*X
      2) Windows

    Select number: 1

    Select a backend type:

      1) SSH
      2) Exec (local)

    Select number: 1

    Vagrant instance y/n: y
    Auto-configure Vagrant from Vagrantfile? y/n: y
     + spec/webserver/sample_spec.rb
     + spec/spec_helper.rb
     + Rakefile
     + .rspec

### start the VM

I had to do this before serverspec or cucumber could succeed, though they are both capable of starting the VM. maybe some tweaks to spec_helper &/or the Vagrantfile would allow them to be self-sufficient

    $ vagrant up --provision webserver

### serverspec

    $ bundle exec rake spec

    Package "apache2"
      should be installed

    Service "apache2"
      should be enabled
      should be running

    Port "80"
      should be listening

    File "/etc/apache2/sites-enabled/000-default.conf"
      should be file
      should contain "example.com"

    Finished in 0.54695 seconds (files took 9.56 seconds to load)
    6 examples, 0 failures

### cucumber

    $ bundle exec cucumber

    Feature:
    As a Webmaster (yeah baby!) I need a webserver to be running so that I may master it.

      Background:                    # features/httpd.feature:4
        Given my server is available # features/step_definitions/httpd_steps.rb:3
        And I provision it           # features/step_definitions/httpd_steps.rb:7

      Scenario:                                 # features/httpd.feature:7
        When I get access to it                 # features/step_definitions/httpd_steps.rb:11
        Then I expect it to have apache running # features/step_definitions/httpd_steps.rb:15

    1 scenario (1 passed)
    4 steps (4 passed)
    0m34.949s

### notes

Mx Hassin's presentation describes an iterative process to reach this point. A repo containing the final state is a bit of a spoiler and maybe not so useful to anyone who didn't go through the process. So perhaps just consider this a supplementary reference.

If you're more committed to these tools or less to keeping your environment clean, you could install the gems not just in the project and not need to `bundle exec` everything.

I had a lot of false starts and things to troubleshoot along the way, so it's likely I've forgotten something... The results are all here, but perhaps not all the steps required to get them.
