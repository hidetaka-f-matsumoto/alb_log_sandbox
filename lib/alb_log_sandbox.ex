defmodule AlbLogSandbox do
  @doc """
  src_dir 下の ALB ログファイル郡から、
  pattern にマッチするリクエスト情報を抽出し、
  dst_file ファイルに書き出す
  """
  def convert_log_to_request_csv(src_dir, dst_file, pattern) do
    Path.wildcard("#{src_dir}/*.log")
    |> Flow.from_enumerable(max_demand: 20)
    |> Flow.flat_map(fn path ->
      parse_log(path)
      |> select_by_pattern(pattern)
    end)
    |> Enum.to_list
    |> output_request_csv(dst_file)
  end

  defp parse_log(path) do
    File.stream!(path)
    |> Stream.reject(fn line -> line == nil || line == "" end)
    |> Stream.map(&AlbLog.parse/1)
    |> Stream.reject(&is_nil/1)
    |> Enum.to_list()
  end

  defp select_by_pattern(logs, pattern) do
    Enum.filter(logs, fn log -> match_with_pattern?(log, pattern) end)
  end

  defp output_request_csv(logs, path) do
    {:ok, file} = File.open(path, [:write])
    IO.puts(file, "\"time\",\"request\",\"client\",\"target\",\"elb_status_code\"")
    Enum.each(logs, fn log ->
      IO.puts(file, "\"#{log["time"]}\",\"#{log["request"]}\",\"#{log["client"]}\",\"#{log["target"]}\",\"#{log["elb_status_code"]}\"")
    end)
  end

  defp match_with_pattern?(%{"request" => request}, pattern) do
    Regex.match?(pattern, request)
  end
end
