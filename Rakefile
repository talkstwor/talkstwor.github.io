require "stringex"

posts = "_posts"
server_dir = "."
new_post_ext = "markdown"

task :new_post, :title do |t, args|
  if args.title
    title = args.title
  else
    title = get_stdin("Enter a title for your post: ")
  end
i  raise "### You haven't set anything up yet. First run `rake install` to set up an Octopress theme." unless File.directory?(server_dir)
  mkdir_p "#{server_dir}/#{posts}"
  filename = "#{server_dir}/#{posts}/#{Time.now.strftime('%Y-%m-%d')}-#{title.to_url}.#{new_post_ext}"
  if File.exist?(filename)
    abort("rake aborted!") if ask("#{filename} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
  end
  puts "Creating new post: #{filename}"
  open(filename, 'w') do |post|
    post.puts "---"
    post.puts "layout: post"
    post.puts "title: \"#{title.gsub(/&/,'&amp;')}\""
    post.puts "---"
  end
end

