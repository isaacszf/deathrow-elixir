import IO.ANSI

result = Deathrow.generate()

print_cyan_white = fn label, element ->
  IO.puts(cyan() <> label <> white() <> element)
end

print_cyan_white.("Full Name: ", result.full_name)
print_cyan_white.("Date of Execution: ", result.date_of_execution)
print_cyan_white.("Last Statement: ", result.last_statement)
