require File.dirname(__FILE__) + '/../spec_helper'
require 'contacts/gmail'
require 'uri'

describe Contacts::Gmail, '.authentication_url' do
  it 'generates a URL for target with default parameters' do
    uri = url('http://example.com/invite')
    
    uri.host.should == 'www.google.com'
    uri.scheme.should == 'https'
    uri.query.split('&').sort.should == [
      'next=http%3A%2F%2Fexample.com%2Finvite',
      'scope=http%3A%2F%2Fwww.google.com%2Fm8%2Ffeeds%2F',
      'secure=0',
      'session=0'
      ]
  end

  it 'should handle boolean parameters' do
    pairs = url(nil, :secure => true, :session => true).query.split('&')
    
    pairs.should include('secure=1')
    pairs.should include('session=1')
  end

  it 'skips parameters that have nil value' do
    query = url(nil, :secure => nil).query
    query.should_not include('next')
    query.should_not include('secure')
  end

  def url(*args)
    URI.parse Contacts::Gmail.authentication_url(*args)
  end
end
