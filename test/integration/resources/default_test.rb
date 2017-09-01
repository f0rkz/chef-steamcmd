describe user('steam') do
  its('home') { should eq '/home/steam' }
  its('shell') { should eq '/bin/bash' }
end

describe file('/opt/steam/steamcmd.sh') do
  it { should exist }
  it { should be_file }
  it { should be_owned_by 'steam' }
  its('group') { should eq 'steam' }
end

describe file('/opt/steamgames/90/hlds_linux') do
  it { should exist }
  it { should be_file }
  it { should be_owned_by 'steam' }
  its('group') { should eq 'steam' }
end
