# Project Guardfile
# More info at https://github.com/guard/guard#readme

group :red_green_refactor, halt_on_fail: true do
  guard :rspec, cmd: 'bundle exec rspec' do
    watch(/spec\/.+_spec\.rb$/)
    watch(/lib\/(.+)\.rb$/) { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch(/spec\/spec_helper\.rb$/) { 'spec' }
  end

  guard 'foodcritic', cmd: 'bundle exec foodcritic -f any . ; echo $?',
                      cookbook_paths: '.' do
    watch(/attributes\/.+\.rb$/)
    watch(/providers\/.+\.rb$/)
    watch(/recipes\/.+\.rb$/)
    watch(/resources\/.+\.rb$/)
    watch(/templates\/(.+)/)
    watch('metadata.rb')
  end

  guard :rubocop do
    watch(/.+\.rb$/)
    watch('.rubocop.yml') { |m| File.dirname(m[0]) }
  end

  # guard 'kitchen' do
  #   watch(/test\/.+/)
  #   watch(/recipes\/(.+)\.rb$/)
  #   watch(/attributes\/(.+)\.rb$/)
  #   watch(/files\/(.+)/)
  #   watch(/templates\/(.+)/)
  #   watch(/providers\/(.+)\.rb$/)
  #   watch(/resources\/(.+)\.rb$/)
  # end
end
