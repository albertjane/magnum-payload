require 'spec_helper'

describe Magnum::Payload::Bitbucket do
  let(:data)    { fixture('bitbucket.json') }
  let(:payload) { Magnum::Payload::Bitbucket.new(data) }

  describe '#parse!' do
    it 'sets commit SHA' do
      payload.commit.should eq('f15566c42759198fd32a70963d2509f3f8309586')
    end

    it 'sets commit branch' do
      payload.branch.should eq('master')
    end

    it 'sets commit message' do
      payload.message.should eq('Commit Sat Jan 19 18:42:40 CST 2013')
    end

    it 'sets author and committer' do
      payload.committer.should be_nil
      payload.committer_email.should be_nil

      payload.author.should eq('Dan Sosedoff')
      payload.author_email.should eq('dan.sosedoff@gmail.com')
    end

    it 'sets commit view url' do
      payload.commit_url.should eq('https://bitbucket.org/sosedoff/test1/commits/f15566c42759198fd32a70963d2509f3f8309586')
    end

    it 'sets compare url' do
      payload.compare_url.should eq('https://bitbucket.org/sosedoff/test1/compare/e15c6013c0f6232153e53b003b97da51d338da3a..f15566c42759198fd32a70963d2509f3f8309586')
    end
  end

  describe '#site_url' do
    it 'returns website url without a path' do
      payload.site_url.should eq('https://bitbucket.org')
    end
  end

  describe '#repo_url' do
    it 'return relative repository path' do
      payload.repo_url.should eq('/sosedoff/test1/')
    end
  end

  describe '#make_url' do
    it 'returns a full url to the repository' do
      payload.make_url.should eq('https://bitbucket.org/sosedoff/test1/')
    end 

    it 'returns a full url to the repository action' do
      payload.make_url('commits/1234').should eq('https://bitbucket.org/sosedoff/test1/commits/1234')
    end
  end
end