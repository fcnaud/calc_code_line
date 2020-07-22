# 遍历文件夹
def traverse_dir(file_path, file_extname_arr, &deal_func)
  total_line = 0
  if File.directory? file_path
    Dir.foreach(file_path) do |file|
      if file != '.' and file != '..'
        total_line += traverse_dir(file_path + '/' + file, file_extname_arr, &deal_func)
      end
    end
  else
    extname = File.extname file_path
    if include_extname file_extname_arr, extname
      total_line += deal_func.call file_path
    end
  end
  return total_line
end

# 统计文件的行数
def calc_code_line(file_path)
  line_count = 0
  File.open(file_path, 'r').each_line do |line|
    line_count+=1
  end
  return line_count
end

# 判断是否是给定的文件后缀
def include_extname(extname_arr, extname)
  extname_arr.each do |item|
    return true if item==extname or '.'+item==extname
  end
  return false
end

args = ARGV

input_path = args[0]
file_exts = %w(cs xml js)

total_line =
traverse_dir input_path, file_exts do |file|
  calc_code_line file
end

p "total line #{total_line}"
