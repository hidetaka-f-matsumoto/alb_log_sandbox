defmodule AlbLog do
  @pattern ~r/(?<type>.+?) (?<time>.+?) (?<elb>.+?) (?<client>.+?) (?<target>.+?) (?<request_processing_time>.+?) (?<target_processing_time>.+?) (?<response_processing_time>.+?) (?<elb_status_code>.+?) (?<target_status_code>.+?) (?<received_bytes>.+?) (?<sent_bytes>.+?) "(?<request>.+?)" "(?<user_agent>.+?)" (?<ssl_cipher>.+?) (?<ssl_protocol>.+?) (?<target_group_arn>.+?) "(?<trace_id>.+?)" "(?<domain_name>.+?)" "(?<chosen_cert_arn>.+?)" (?<matched_rule_priority>.+?) (?<request_creation_time>.+?) "(?<actions_executed>.+?)" "(?<redirect_url>.+?)" "(?<error_reason>.+?)" "(?<target_port_list>.+?)" "(?<target_status_code_list>.+?)"/

  def parse(line) do
    Regex.named_captures(@pattern, line)
    |> validate(line)
  end

  defp validate(log, _line) when is_map(log), do: log
  defp validate(_log, line), do: IO.puts("Unexpected log format. #{line}") && nil
end
