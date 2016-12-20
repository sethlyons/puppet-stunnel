require "spec_helper"

describe "stunnel::service", :type => :define do
  let(:facts) do
    {
      :os => { :family => "FreeBSD" },
      :operatingsystem => "FreeBSD",
    }
  end

  let :title do
    "test_service"
  end

  let :params do
    {
      :accept  => "5000",
      :connect => [ "www.google.com:443" ],
    }
  end

  context "without including the base class" do
    it do
      expect {
        is_expected.to compile
      }.to raise_error(/stunnel must be included before using stunnel::service/)
    end
  end

  context "when including the base class" do
    let :pre_condition do
      "class { 'stunnel': }"
    end

    it "should create <title>.conf in the Includes directory" do
      should contain_file("/usr/local/etc/stunnel/Includes/test_service.conf").with_content("### MANAGED BY PUPPET\n### DO NOT EDIT\n\n\[test_service\]\naccept = 5000\nclient = no\nconnect = www\.google\.com:443\n")
    end
  end
end
