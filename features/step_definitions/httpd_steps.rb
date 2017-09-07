require 'net/ssh'

Given(/^my server is available$/) do
  output=`vagrant reload`
end

Given(/^I provision it$/) do
  output=`vagrant provision`
end

When(/^I get access to it$/) do
  run_remote("ls")
end

Then(/^I expect it to have apache running$/) do
  run_remote("ps asx | grep apache")
end

def run_remote(command)
  Net::SSH.start("33.33.33.33", "vagrant", :password => "vagrant") do |ssh|
    result = ssh.exec!(command)
  end
end
