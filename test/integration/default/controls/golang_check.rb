control 'golang_check' do

  describe command("PATH=$PATH:/usr/local/go/bin go version") do
    its('exit_status') { should eq 0 }
  end

  describe file('/etc/profile.d/golang_config.sh') do
    it { should exist }
    its('content') { should match %r|PATH=\$PATH:/usr/local/go/bin| }
  end

end
