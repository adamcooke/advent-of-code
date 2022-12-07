# frozen_string_literal: true

input = File.read('input.txt')

current_path = []
current_directory = nil
current_command = nil
directories = {}

input.split("\n") do |line|
  if line =~ /\A\$ (\w+)\s?(.*)\z/
    command = Regexp.last_match(1)
    arguments = Regexp.last_match(2)

    current_command = command

    if command == 'cd'
      if arguments == '/'
        current_path = ['']
      elsif arguments == '..'
        current_path.pop
      else
        current_path += arguments.split('/')
      end
    end
    next
  end

  if current_command == 'ls' && line =~ /\A(\d+) (.*)\z/
    file_size = Regexp.last_match(1)
    file_name = Regexp.last_match(2)

    current_path.size.times do |i|
      path = current_path[0..i].join('/')
      directories[path] ||= 0
      directories[path] += file_size.to_i
    end
  end
end

puts 'Part 1: ' + directories.values.select { |v| v < 100_000 }.sum.to_s

total_used = directories['']
total_disk = 70_000_000
unused_space = total_disk - total_used
update_size = 30_000_000
space_to_free_up = update_size - unused_space

puts 'Part 2: ' + directories.values.sort.select { |v| v > space_to_free_up }.first.to_s
