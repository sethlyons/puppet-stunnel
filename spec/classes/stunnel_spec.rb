require "spec_helper"

describe "stunnel" do
  context "on freebsd" do
    let (:facts) do
      {
        :os => { :family => "FreeBSD" },
        :operatingsystem => "FreeBSD",
      }
    end

    it "should compile" do
      is_expected.to compile
    end

    it "should install the stunnel package" do
      is_expected.to contain_package("stunnel")
    end

    it "should create the Includes directory" do
      is_expected.to contain_file("/usr/local/etc/stunnel/Includes")
    end

    it "should have stunnel.conf in /usr/local/etc/stunnel" do
      is_expected.to contain_file("/usr/local/etc/stunnel/stunnel.conf")
    end

    it "should set TLSv1.2 as the default ssl version" do
      is_expected.to contain_file("/usr/local/etc/stunnel/stunnel.conf")\
        .with_content(/TLSv1\.2/)
    end

    it "should manage the stunnel service" do
      is_expected.to contain_service("stunnel").with(
        "ensure"  => "running",
        "enable"  => "true",
      )
    end
  end

  context "on redhat" do
    let(:facts) do
      { :os => { :family => "RedHat" } }
    end

    let (:facts) do
      {
        :os => { :family => "RedHat" },
        :operatingsystem => "RedHat",
      }
    end

    it "should compile" do
      is_expected.to compile
    end

    it "should install the stunnel package" do
      is_expected.to contain_package("stunnel")
    end

    it "should create the Includes directory" do
      is_expected.to contain_file("/etc/stunnel/Includes")
    end

    it "should have stunnel.conf in /etc/stunnel" do
      is_expected.to contain_file("/etc/stunnel/stunnel.conf")
    end

    it "should set TLSv1.2 as the default ssl version" do
      is_expected.to contain_file("/etc/stunnel/stunnel.conf")\
        .with_content(/TLSv1\.2/)
    end

    it "should manage the stunnel service" do
      is_expected.to contain_service("stunnel").with(
        "ensure"  => "running",
        "enable"  => "true",
      )
    end
  end
end
