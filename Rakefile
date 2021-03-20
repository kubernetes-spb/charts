require 'yaml'

REPO_SUBDIR = 'repo'.freeze

def charts
  charts = Dir['*'].select { |f| File.directory?(f) and File.file?("#{f}/Chart.yaml") }

  charts.compact.map do |dir|
    chart = YAML.load_file("#{dir}/Chart.yaml")
    {
      name: chart['name'],
      tarball: "#{chart['name']}-#{chart['version']}.tgz",
      version: chart['version'],
    }
  end
end

task default: :publish

task :package do
  charts.each do |chart|
    sh "helm package -d #{REPO_SUBDIR} #{chart[:name]}" unless File.file?("#{REPO_SUBDIR}/#{chart[:tarball]}")
  end
end

task :index => :package do
  repo_url = ENV['HELM_REPO'] || "https://kubernetes-spb.github.io/charts/#{REPO_SUBDIR}"
  sh "helm repo index #{REPO_SUBDIR} --url=#{repo_url}"
end

task :publish => :index do
  sh "git add #{REPO_SUBDIR}/index.yaml #{charts.map { |c| "#{REPO_SUBDIR}/#{c[:tarball]}" }.join(' ')}"
  sh "git commit -m 'Helm repo reindexed at #{Time.now}'"
  sh 'git push origin master'
end
