defmodule Inmates do
  def get_inmate_info_by_name(inmate_name) do
    info_table =
      "https://www.tdcj.texas.gov/death_row/dr_info/#{inmate_name}last.html"
      |> Utils.get_page()
      |> Utils.parse_doc()
      |> Floki.find("div#content_right p")
      |> Floki.raw_html()
      |> String.replace(
        ["<br/>", "<span class=\"italic\">", "</span>", "\r\n", "\r", "\n"],
        ""
      )
      |> Utils.parse_doc()

    # Five is the number of lines which is above the statement
    # (which contains name and date)
    # So to get the number of sentences, we need to decrease five by the
    # width of the table
    {date, name_and_number, last_statement} = parse_info(info_table, 5 - length(info_table))

    %{
      date_of_execution: date |> String.trim(),
      full_name:
        name_and_number
        |> String.split("#")
        |> hd()
        |> String.trim(),
      last_statement: last_statement |> String.trim()
    }
  end

  def get_single_inmate_name(url) do
    inmates_list = get_all(url)

    inmates_list
    |> Enum.take_random(1)
    |> hd()
  end

  defp get_all(url) do
    body = Utils.get_page(url)

    body
    |> Utils.parse_doc()
    |> Floki.find("table.tdcj_table tr td a")
    |> Floki.attribute("href")
    |> Stream.filter(&String.contains?(&1, "last"))
    |> Stream.map(&String.replace(&1, ["dr_info/", ".html", "last", "/death_row/"], ""))
    |> Stream.filter(&(&1 != "no__statement"))
    |> Stream.map(&(String.split(&1, "9") |> hd()))
  end

  defp parse_info(inmates_info_table, range) do
    date_chunk = Enum.at(inmates_info_table, 1)
    {_, _, [date]} = date_chunk

    name_and_number_chunk = Enum.at(inmates_info_table, 3)
    {_, _, [name_and_number]} = name_and_number_chunk

    last_statement =
      Enum.take(inmates_info_table, range)
      |> Enum.map(fn {_, _, ph} -> ph end)
      |> Enum.join(" ")

    {date, name_and_number, last_statement}
  end
end
