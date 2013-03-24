module Magnum
  class Payload::Github < Payload::Base
    def parse!
      if deleted? || last_commit.nil?
        @skip = true
        return
      end

      @commit          = last_commit.id
      @author          = last_commit.author.name
      @author_email    = last_commit.author.email
      @committer       = last_commit.committer.name
      @committer_email = last_commit.committer.email
      @message         = last_commit.message
      @branch          = data.ref.split('/').last
      @commit_url      = last_commit.url
      @compare_url     = data.compare
    end

    private

    # Check if push is forced
    # @return [Boolean]
    def forced?
      data.forced == true
    end

    # Check if head is deleted
    # @return [Boolean]
    def deleted?
      data.deleted == true
    end

    # Get last commit in the push
    # @return [Hashr]
    def last_commit
      if forced?
        data.head_commit
      else
        Hashr.new(data.commits.last)
      end
    end
  end
end