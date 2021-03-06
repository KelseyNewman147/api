class FetchReposWithIssues
  include Interactor

  def call
    context.repos = repos_with_issues.map(&:full_name)
  end

  private

  def gh_token
    ENV.fetch("GITHUB_API_TOKEN")
  end

  def repos_with_issues
    @repos_with_issues ||= all_repos.select do |repo|
      repo.open_issues.positive?
    end
  end

  def all_repos
    @all_repos ||= client.repositories("charlottejuniordevs")
  end

  def client
    @client ||= Octokit::Client.new(access_token: gh_token)
  end
end
