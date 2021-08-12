control 'packages_check' do

    describe package('git') do
        it { should be_installed }
    end

    describe package('vim') do
        it { should be_installed }
    end 

    describe package('curl') do
        it { should be_installed }
    end 

    describe package('jq') do
        it { should be_installed }
    end 

    describe package('make') do
        it { should be_installed }
    end 
  
  end