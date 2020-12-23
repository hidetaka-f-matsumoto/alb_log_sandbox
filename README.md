# AlbLogSandbox

## Requirements

### Elixir

```bash
$ iex -v
Erlang/OTP 23 [erts-11.1.5] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [hipe] [dtrace]

IEx 1.11.2 (compiled with Erlang/OTP 23)
```

```bash
$ mix deps.get
```

### R

```bash
$ r --version
R version 3.5.1 (2018-07-02) -- "Feather Spray"
```

## Download ALB Log

```bash
# example: s3://your-bucket/phoenix/AWSLogs/12345/elasticloadbalancing/ap-northeast-1
S3_LOG_DIR='s3://<path to log before YYYY/MM/DD>' \
  bash scripts/download_log.sh 2020/10/25 2019/10/20
```

## Parse ALB Log and generate CSV

```bash
iex -S mix
```

```iex
AlbLogSandbox.convert_log_to_request_csv(
  "assets/log/2019/10/20",
  "assets/data/2019_10_20.csv",
  ~r/POST https:\/\/.+:443\/images/)
```

```iex
AlbLogSandbox.convert_log_to_request_csv(
  "assets/log/2020/10/25",
  "assets/data/2020_10_25.csv",
  ~r/POST https:\/\/.+:443\/images/)
```

## Visualize the number of container

```r
Rscript scripts/visualize_target_count.R assets/data/2020_10_25.csv
```
