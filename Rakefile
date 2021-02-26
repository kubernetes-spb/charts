require 'yaml'

def charts
  result = []
  Dir["*"].map {|f| f if File.directory?(f)}.compact.each do |dir|
    chart = YAML.load_file("#{dir}/Chart.yaml")
    result << {
      name: chart['name'],
      tarball: "#{chart['name']}-#{chart['version']}.tgz",
      version: chart['version'],
    }
  end
  return result
end

task :default => :publish

task :package do
  charts.each do |chart|
    sh "helm package #{chart[:name]}" unless File.exists?(chart[:tarball])
  end
end

task :index => :package do
  repo_url = ENV['HELM_REPO'] || 'https://kubernetes-spb.github.io/charts'
  sh "helm repo index . --url=#{repo_url}"
end

task :publish => :index do
  sh "git add index.yaml #{charts.map {|c| c[:tarball]}.join(' ')}"
  sh "git commit -m 'Helm repo reindexed at #{Time.now}'"
  sh "git push"
end
