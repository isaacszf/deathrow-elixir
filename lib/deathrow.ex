defmodule Deathrow do
  @url "https://www.tdcj.texas.gov/death_row/dr_executed_offenders.html"

  def generate do
    random_inmate = Inmates.get_single_inmate_name(@url)
    Inmates.get_inmate_info_by_name(random_inmate)
  end
end

defmodule Deathrow.CLI do
  def main(_ \\ []) do
    %{
      date_of_execution: date_of_ex,
      full_name: full_n,
      last_statement: last_s
    } = Deathrow.generate()

    print_cyan_white("Full Name: ", full_n)
    print_cyan_white("Date of Execution: ", date_of_ex)
    print_cyan_white("Last Statement: ", last_s)
  end

  defp print_cyan_white(label, field) do
    import IO.ANSI

    IO.puts(cyan() <> label <> white() <> field)
  end
end
